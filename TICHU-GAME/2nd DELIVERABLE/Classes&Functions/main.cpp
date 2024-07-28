#include <iostream>
#include <cstdlib>
#include <ctime>
#include "table.h"
#include "deck.h"
#include "helpers.h"
#include "player.h"

using namespace std;

int main(){
    srand(time(NULL));
    Table table;
    Deck deck;
    Player players[4] = {Player(0), Player(1), Player(2), Player(3)};

    // Keep the ranking (i.e. which players has no cards left first)
    int rankingIndex = 0;
    int ranking[4];

    // Deal the cards
    deck.shuffle();
    for (int i = 0; i < 4; i++){
        for (int j = 0; j < 14; j++){
            Card card = deck.deal();
            players[i].addCardToHand(card);
        }
    }

    // The player that has the Mah Jong plays first
    int playerTurn = 0;
    while(!players[playerTurn].hasMahJong()){
        playerTurn++;
    }
    players[playerTurn].setStatus("WONTHETRICK");

    for (int i = 0; i < 4; i++){
        cout << players[i].toString() << endl;
    }

    cout << "NEW TRICK" << endl;
    do{
        cout << "Turn of " << players[playerTurn].getName() << endl;
        if (players[playerTurn].hasNoCardsLeft())
            cout << players[playerTurn].getName() << " has no cards left" << endl;
        else{
            // Check if last three players passed or have no cards left
            if (lastThreePlayersPassedOrHaveNoCardsLeft(players, playerTurn)){
                players[playerTurn].setStatus("WONTHETRICK");
                cout << players[playerTurn].getName() << " won the trick" << endl;

                for (int j = 0; j < table.getNumberOfCombinations(); j++){
                    Combination temp = table.getCombination(j);
                    players[playerTurn].addCardsToBucket(temp);
                }
                table.clear();

                cout << endl << "NEW TRICK" << endl;
            }

            // Play a combination or pass
            players[playerTurn].createHandCombinations(); // first create all possible combinations for the player
            Combination currentComb; // this variable will hold the combination that will be played
            bool playerHasPlayed = false;
            if (table.getNumberOfCombinations() == 0){
                // The table has no combinations, so the player has to play a combination
                currentComb = players[playerTurn].playAnyCombination();
                playerHasPlayed = true;
            }
            else{
                // The table has an existing combination
                // Check if the player can play and if the player wants to play
                if (players[playerTurn].findNumberOfPlayableCombinations(table.getTopCombination()) > 0){
                    if (players[playerTurn].decidePlay()){
                        currentComb = players[playerTurn].play(table.getTopCombination());
                        playerHasPlayed = true;
                    }
                }
            }
            if (playerHasPlayed){ // player has played
                for (int i = 0; i < currentComb.getNumberOfCards(); i++)
                    players[playerTurn].removeCardFromHand(currentComb.getCard(i));
                table.addCombinationOnTable(currentComb);
                cout << players[playerTurn].getName() << " played: " << currentComb.toString() << endl;
                players[playerTurn].setStatus("PLAYED");
            }
            else{
                cout << players[playerTurn].getName() << " passed" << endl;
                players[playerTurn].setStatus("PASSED");
            }

            // Check if player has no cards left
            if (players[playerTurn].hasNoCardsLeft()){
                cout << players[playerTurn].getName() << " has no cards left " << endl;
                players[playerTurn].setStatus("HASNOCARDSLEFT");
                ranking[rankingIndex++] = playerTurn;
                // If player is the third with no cards left, get the trick and game over
                if (numberOfPlayersThatHaveNoCardsLeft(players) >= 3){
                    // Get the rest of the cards
                    for (int j = 0; j < table.getNumberOfCombinations(); j++){
                        Combination temp = table.getCombination(j);
                        players[playerTurn].addCardsToBucket(temp);
                    }
                    table.clear();

                    cout << endl << "Game Over!" << endl;
                    break;
                }
            }
        }

        playerTurn = (playerTurn + 1) % 4;
    }
    while(true);

    // Get the last player
    for (int i = 0; i < 4; i++){
        if (!players[i].hasNoCardsLeft())
            ranking[rankingIndex++] = i;
    }

    // Print ranking
    cout << endl << "Ranking: " << endl;
    for (int i = 0; i < 4; i++){
        cout << players[ranking[i]].getName() << endl;
    }

    return 0;
}
