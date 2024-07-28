#include <iostream>
#include <cstdlib>
#include <ctime>
#include "table.h"
#include "deck.h"
#include "player.h"
#include "game.h"

using namespace std;

int main(){
    // Initialize game
    //srand(time(NULL));
    srand(5);
    Table* table = new Table();
    Deck* deck = new Deck();
    Player** players = new Player*[4];
    for (int i = 0; i < 4; i++)
        players[i] = new Player(i);
    Game* game = new Game(table, deck, players);

    // Deal and start round
    int playerTurn = game->startRound();
    Player* currentPlayer = players[playerTurn];
    currentPlayer->setStatus(WONTHETRICK);

    game->printState();
    cout << "NEW TRICK" << endl;
    do{
        currentPlayer = players[playerTurn];

        // Check if last three players passed or have no cards left
        if (game->lastThreePlayersPassedOrHaveNoCardsLeft(playerTurn)){
            currentPlayer->setStatus(WONTHETRICK);
            cout << currentPlayer->getName() << " won the trick" << endl;

            for (int j = 0; j < table->getNumberOfCombinations(); j++){
                Combination *temp = table->getCombination(j);
                currentPlayer->addCombinationToBucket(temp);
            }
            table->clear();

            cout << endl << "NEW TRICK" << endl;
        }
        cout << "Turn of " << currentPlayer->toString() << endl;

        if (currentPlayer->hasNoCardsLeft())
            cout << currentPlayer->getName() << " has no cards left" << endl;
        else{
            // Play a combination or pass
            currentPlayer->createHandCombinations(); // first create all possible combinations for the player
            Combination *currentComb = NULL;
            if (table->getNumberOfCombinations() == 0){
                // The table has no combinations, so the player has to play a combination
                currentComb = currentPlayer->play(NULL);
            }
            else{
                // The table has an existing combination
                // Check if the player can play and if the player wants to play
                if (currentPlayer->findNumberOfPlayableCombinations(table->getTopCombination()) > 0){
                    if (currentPlayer->decidePlay()){
                        currentComb = currentPlayer->play(table->getTopCombination());
                    }
                }
            }

            if (currentComb != NULL){ // Player has played
                currentPlayer->removeCombinationFromHand(currentComb);
                table->addCombinationOnTable(currentComb);
                cout << currentPlayer->getName() << " played: " << currentComb->toString() << endl;
                currentPlayer->setStatus(PLAYED);
            }
            else{ // Player has passed
                cout << currentPlayer->getName() << " passed" << endl;
                currentPlayer->setStatus(PASSED);
            }

            // Check if player has no cards left
            if (currentPlayer->hasNoCardsLeft()){
                cout << currentPlayer->getName() << " has no cards left " << endl;
                currentPlayer->setStatus(HASNOCARDSLEFT);
                game->playerCardsHaveEnded(playerTurn);
                // If the partner of the player has no cards left then get the trick and game over
                if (game->partnerHasNoCardsLeft(playerTurn)){
                    // Get the rest of the cards
                    for (int j = 0; j < table->getNumberOfCombinations(); j++){
                        Combination *temp = table->getCombination(j);
                        currentPlayer->addCombinationToBucket(temp);
                    }
                    table->clear();

                    cout << endl << "Game Over!" << endl;
                    break;
                }
            }
        }

        playerTurn = (playerTurn + 1) % 4;
    }
    while(true);

    game->endRound();

    // Print ranking
    int* ranking = game->getRanking();
    cout << endl << "Ranking: " << endl;
    for (int i = 0; i < 4; i++){
        cout << players[ranking[i]]->getName() << endl;
    }

    // Print score
    cout << endl << "Score: " << endl;
    cout << players[0]->getName() << " and " << players[2]->getName() << " - " << game->getTeamPoints(0) << endl;
    cout << players[1]->getName() << " and " << players[3]->getName() << " - " << game->getTeamPoints(1) << endl;

    // Delete all objects
    delete table;
    delete deck;
    for (int i = 0; i < 4; i++)
        delete players[i];
    delete[] players;
    delete game;

    return 0;
}
