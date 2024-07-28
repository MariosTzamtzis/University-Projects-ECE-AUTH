#include "card.h"

///Simple Card Implementation.

SimpleCard::SimpleCard(int value, CardSuit suit):Card(value, suit){}

int SimpleCard::getPoints(){
    if (value==5) return 5;
    if (value==10 || value==13) return 10;
    return 0;
}
bool SimpleCard::canBeInCombination(){return true;}
bool SimpleCard::canBeInBomb(){return true;}

///Special Card Implementation.

SpecialCard::SpecialCard(CardSuit suit):Card(){
    this->suit=suit;
    if (suit==MAHJONG) value=1;
    else if (suit==DRAGON) value=15;
    else value=-1;
}

int SpecialCard::getPoints(){
    if (suit==DRAGON) return 25;
    else if (suit==PHOENIX) return -25;
    else return 0;
}

bool SpecialCard::canBeInCombination(){
    if (suit==MAHJONG || suit==PHOENIX) return true;
    else return false;
}

bool SpecialCard::canBeInBomb(){return false;}
// TODO: Implement here the methods of SimpleCard and SpecialCard

