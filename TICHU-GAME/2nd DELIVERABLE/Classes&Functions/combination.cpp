#include "combination.h"

Combination::Combination(){
    numberOfCards=0;
}
void Combination::addCard(Card card){
    if (cards[0].getValue()==0 && cards[0].getSuit()==""){
            cards[0].setValue(card.getValue());
            cards[0].setSuit(card.getSuit());
            numberOfCards=1;
    }
    else{
        cards[1].setValue(card.getValue());
        cards[1].setSuit(card.getSuit());
        numberOfCards=2;
    }

}
Card Combination::getCard(int index){
    return cards[index];
}

int Combination::getValue(){
   return cards[0].getValue();

}
int Combination::getNumberOfCards(){
    return numberOfCards;
}

bool Combination::canBePlayed(Combination last){
    if (numberOfCards==last.numberOfCards && getValue()>last.getValue()) return true;
    return false;
}
// TODO: Implement here the methods of Combination
