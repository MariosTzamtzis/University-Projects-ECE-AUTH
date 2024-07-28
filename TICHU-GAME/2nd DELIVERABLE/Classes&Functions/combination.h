#ifndef COMBINATION_H
#define COMBINATION_H

#include <string>
#include "card.h"

using namespace std;

/**
 * Class denoting a combination. Combinations can be single cards or pairs.
 */
class Combination
{
private:
    Card cards[2];
    int numberOfCards;

public:
    /**
     * Initializes a combination with 0 cards.
     */
    Combination();

    /**
     * Adds a card to the combination.
     *
     * @param card the card to be added to the combination.
     */
    void addCard(Card card);

    /**
     * Returns a card of the combination given its index.
     *
     * @param index the index of the card to be returned.
     * @return a card of the combination given its index.
     */
    Card getCard(int index);

    /**
     * Returns the value of the cards of the combination. The value of the
     * combination is equal to the value of its higher card.
     *
     * @return the value of the cards of the combination.
     */
    int getValue();

    /**
     * Returns the number of cards of the combination.
     *
     * @return the number of cards of the combination.
     */
    int getNumberOfCards();

    /**
     * Checks if this combination can be played after a given combination. This is true if this
     * combination has the same number of cards with the given one and has larger value than the
     * given one.
     *
     * @param last the last combination to check if this combination can be played after.
     * @return true if this combination can be played after the given one, or false otherwise.
     */
    bool canBePlayed(Combination last);

    /**
     * Returns a string representation of the combination.
     *
     * @return the combination as string.
     */
    string toString(){
        string str;
        str += (getNumberOfCards() == 1 ? "SINGLE" : "PAIR");
        str += "[";
        for (int i = 0; i < getNumberOfCards(); i++)
            str += " " + cards[i].toString();
        str += " ]";
        return str;
    };
};

#endif // COMBINATION_H
