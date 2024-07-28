#include "player.h"

// TODO: Implement here the methods of Player
// Do not implement the methods addCardToHand, removeCardFromHand, addCardsToBucket
// createHandCombinations, findNumberOfPlayableCombinations, playAnyCombination, play
// These are already implemented in file playercombinations.cpp
// Implement the rest of the methods of Player


Player::Player(int idx){
    bucketSize=0;
    status="HASNTPLAYED";
    switch(idx){
        case 0: name="Player 1";
            break;
        case 1: name="Player 2";
            break;
        case 2: name="Player 3";
            break;
        case 3: name="Player 4";
            break;

    }
}

void Player::setStatus(string newStatus){
    status=newStatus;
}

bool Player::hasStatus(string checkStatus){
    if(status==checkStatus) return true;
    else return false;
}

string Player::getName(){
    return name;
}

bool Player::hasNoCardsLeft(){
    if (hand.getCardCount()==0) return true;
    else return false;
}

bool Player::hasMahJong(){
    int i;
    for (i=0; i<14; i++){
        if (hand.getCard(i).getSuit()=="MAHJONG"){
            return true;
        }
        else continue;
    }
    return false;

}

bool Player::decidePlay(){
    int prop=rand()%2; //It returns 0 or 1.
    if (prop==0) return false;
    else return true;
}
