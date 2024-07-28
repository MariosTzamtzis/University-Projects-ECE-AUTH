#include "card.h"

Card::Card(){
    suit="";
    value=0;
}

void Card::setValue(int theValue){
    value=theValue;
}

void Card::setSuit(string theSuit){
    suit=theSuit;
}

string Card::getSuit(){
    return suit;
}

int Card::getValue(){
    return value;
}

bool Card::hasSuit(string theSuit){
    if (suit==theSuit) return true;
    else return false;
}

bool Card::equals(Card otherCard){
    if (otherCard.suit==suit && otherCard.value==value) return true;
    else return false;
}

bool Card::canBeInCombination(){
    if (suit=="DRAGON" || suit=="DOG") return false;
    else return true;
}

bool Card::canBeInBomb(){
    if (suit=="MAHJONG" || suit=="DRAGON" || suit=="DOG" || suit=="PHOENIX") return false;
    else return true;
}

// TODO: Implement here the methods of Card
