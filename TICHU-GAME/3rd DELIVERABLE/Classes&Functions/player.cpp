#include "player.h"

// TODO: Implement here the methods combinationCanBePlayed and countBucketPoints of Player
// Do not implement any other methods of Player as these are already implemented in file playercombinations.cpp

bool Player::combinationCanBePlayed(Combination *current, Combination *last){
    if (current->getType()==last->getType() && current->getNumberOfCards()==last->getNumberOfCards() && current->getValue()>last->getValue()) return true;
    else if ((current->getType()==FOUROFAKIND || current->getType()==STRAIGHTFLUSH) && (last->getType()!=FOUROFAKIND && last->getType()!=STRAIGHTFLUSH)) return true;
    else if (current->getType()==STRAIGHTFLUSH && last->getType()==FOUROFAKIND) return true;
    else if (current->getType()==STRAIGHTFLUSH && last->getType()==STRAIGHTFLUSH && current->getNumberOfCards()>last->getNumberOfCards()) return true;
    else return false;
}

int Player::countBucketPoints(){
    int points=0;
    int i;
    for (i=0; i<bucketSize; i++){
        if (bucket[i]->getValue()==5) points += 5;
        if (bucket[i]->getValue()==13 || bucket[i]->getValue()==10) points += 10;
        if (bucket[i]->getSuit()==DRAGON) points += 25;
        if (bucket[i]->getSuit()==PHOENIX) points -= 25;
    }
    return points;
}
