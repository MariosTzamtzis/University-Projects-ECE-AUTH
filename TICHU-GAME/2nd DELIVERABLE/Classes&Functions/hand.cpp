#include <cstdlib>
#include <iostream>
#include "hand.h"
#include "card.h"
#include "combination.h"

Hand::Hand(){
    currentNumberOfCards = 0;
    allCombinationsSize = 0;
}

int Hand::getNumberOfCombinations(){
    return allCombinationsSize;
}

Combination Hand::getCombination(int index){
    return allCombinations[index];
}

void Hand::addCard(Card card){
    cards[currentNumberOfCards] = card;
    currentNumberOfCards++;
}

void Hand::removeCard(Card card){
    // Find the index of the card
    int index = -1;
    for (int i = 0 ; i != currentNumberOfCards; i++)
    {
        if (cards[i].equals(card))
        {
            index = i;
            break;
        }
    }
    // "Remove" the found card by moving all cards to the left until index
    for (; index < currentNumberOfCards - 1; index++)
        cards[index] = cards[index + 1];
    currentNumberOfCards--;
}

int Hand::getCardCount(){
    return currentNumberOfCards;
}

Card Hand::getCard(int index){
    return cards[index];
}

void Hand::setPhoenixValue(){
    // Check if the hand has the phoenix
    int phoenixIndex = -1;
    for (int i = 0 ; i != currentNumberOfCards; i++){
        if (cards[i].hasSuit("PHOENIX"))
            phoenixIndex = i;
    }
    // If the hand has the phoenix, then set its value randomly between 2 and 14
    if (phoenixIndex >= 0)
        cards[phoenixIndex].setValue(rand() % 13 + 2);
}

void Hand::clearHand(){
    if (allCombinationsSize > 0){
        for (int i = 0; i < allCombinationsSize; i++)
            allCombinations[i] = Combination();
        allCombinationsSize = 0;
    }
    setPhoenixValue();
}
