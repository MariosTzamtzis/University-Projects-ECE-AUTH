#include "helpers.h"
#include "player.h"

int numberOfPlayersThatHaveNoCardsLeft(Player players[]){
    int i;
    int num=0;
    for (i=0; i<4; i++){
            if (players[i].hasNoCardsLeft()) num++;

    }
    return num;

    // TODO: Implement this function
}

bool lastThreePlayersPassedOrHaveNoCardsLeft(Player players[], int playerTurn){
    int i, flag=0;
    for (i=0; i<4; i++){
        if (i==playerTurn && i!=3) i++; //If i is equal with playerTurn and player
                                        //is not the last player of the trick check the next one.
        if (i==playerTurn && i==3) break; //If i is equal with playerTurn and player
                                          //is the last player check the flag
        if (players[i].hasStatus("PASSED") || players[i].hasNoCardsLeft()) flag++; //count how many players have passed or have no cards left.
       }
    if (flag==3) return true;
    else return false;

    // TODO: Implement this function
}
