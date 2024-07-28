#include "combination.h"

// TODO: Implement here the methods of Combination and all derived classes

Combination::Combination(){}

Combination::Combination(Card** cards, CombinationType type, int numberOfCards){
    this->type=type;
    this->numberOfCards=numberOfCards;
    this->cards=new Card*[numberOfCards];
    int i;
    for (i=0; i<numberOfCards; i++) this->cards[i]=cards[i];

}
Combination:: ~Combination(){delete[] cards;}

Card* Combination::getCard(int index){
    return cards[index];
}

bool Combination::containsCard(Card* card){
    for (int i=0; i<numberOfCards; i++){
        if (card==cards[i]) return true;
        else continue;
    }
    return false;
}

CombinationType Combination::getType(){
    return type;
}

bool Combination::hasType(CombinationType type){
    if (this->type==type) return true;
    else return false;
}

int Combination::getValue(){
    return value;
}

int Combination::getNumberOfCards(){
    return numberOfCards;
}

bool Combination::equals(Combination* otherCombination){
    if (otherCombination->getType()==type && otherCombination->getNumberOfCards()==numberOfCards){
        for(int i=0;i<numberOfCards;i++){
            if(cards[i]==otherCombination->cards[i]) continue;
            else return false;
        }
        return true;
    }
    else return false;
}

//Derived Classes' Implementation.

Single::Single(Card* card):Combination(){
    numberOfCards=1;
    type=SINGLE;
    value=card->getValue();
    cards=new Card*[1];
    cards[0]=card;
}

Pair::Pair(Card* card1, Card* card2):Combination(){
    type=PAIR;
    numberOfCards=2;
    value=card1->getValue();
    cards=new Card*[2];
    cards[0]=card1;
    cards[1]=card2;
}

ThreeOfAKind::ThreeOfAKind(Card* card1, Card* card2, Card* card3): Combination(){
    cards=new Card*[3];
    cards[0]=card1;
    cards[1]=card2;
    cards[2]=card3;
    type=THREEOFAKIND;
    numberOfCards=3;
    value=card3->getValue();
}

FourOfAKind::FourOfAKind(Card* card1, Card* card2, Card* card3, Card* card4):Combination(){
    numberOfCards=4;
    type=FOUROFAKIND;
    value=card1->getValue();
    cards=new Card*[4];
    cards[0]=card1;
    cards[1]=card2;
    cards[2]=card3;
    cards[3]=card4;
}

Stairs::Stairs(Card** cards, int numberOfCards):Combination(cards, STAIRS, numberOfCards){
    value=cards[numberOfCards-1]->getValue();
}

Straight::Straight(Card** cards, int numberOfCards):Combination(cards, STRAIGHT, numberOfCards){
    value=cards[numberOfCards-1]->getValue();
}

bool Straight::cardsHaveTheSameSuit(){
    for (int i=0; i<numberOfCards - 1; i++){
        if (cards[i]->getSuit()==cards[i+1]->getSuit()) continue;
        else return false;
    }
    return true;
}

FullHouse::FullHouse(ThreeOfAKind* combination1, Pair* combination2):Combination(){
    numberOfCards=5;
    type=FULLHOUSE;
    value=100*combination1->getValue() + combination2->getValue();
    cards=new Card*[5];
    int i;
    for (i=0; i<2; i++) this->cards[i]=combination2->getCard(i);
    for (i=2; i<numberOfCards; i++)this->cards[i]=combination1->getCard(i-2);
}

StraightFlush::StraightFlush(Straight* combination):Combination(){
    type=STRAIGHTFLUSH;
    numberOfCards=combination->getNumberOfCards();
    value=combination->getValue();
    cards=new Card*[numberOfCards];
    for (int i=0; i<numberOfCards; i++) this->cards[i]=combination->getCard(i);
}
// TODO: Implement here the methods of Combination and all derived classes
