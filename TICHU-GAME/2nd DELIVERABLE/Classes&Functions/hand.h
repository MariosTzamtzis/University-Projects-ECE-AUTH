#ifndef HAND_H
#define HAND_H

#include <string>
#include "combination.h"

using namespace std;

/**
 * Class denoting a hand of a player.
 */
class Hand
{
private:
	Card cards[14];
	int currentNumberOfCards;
    Combination allCombinations[1000];
    int allCombinationsSize;

public:
    /**
     * Initializes the hand that holds the cards.
     */
	Hand();

    /**
     * Clears the hand for a new round by clearing all combinations and setting the
     * value of the phoenix.
     */
    void clearHand();

    /**
     * Returns a combination of the hand given its index.
     *
     * @param index the index of the combination to be returned.
     * @return a combination of the hand given its index.
     */
    Combination getCombination(int index);

    /**
     * Returns the number of combinations of the hand.
     *
     * @return the number of combinations of the hand.
     */
    int getNumberOfCombinations();

    /**
     * Adds a card to the hand.
     *
     * @param card the card to be added to the hand.
     */
	void addCard(Card card);

    /**
     * Removes a card from the hand.
     *
     * @param card the card to be removed to the hand.
     */
	void removeCard(Card card);

    /**
     * Returns the number of cards that are currently in the hand.
     *
     * @return the number of cards of the hand.
     */
	int getCardCount();

    /**
     * Returns a card of the hand given its index.
     *
     * @param index the index of the card to be returned.
     * @return a card of the hand given its index.
     */
	Card getCard(int index);

    /**
     * Sets the value of the phoenix (if the hand has it) to a random
     * value between 2 and 14.
     */
    void setPhoenixValue();

    /**
     * Returns a string representation of the hand, including all cards.
     *
     * @return the hand of the player as string.
     */
	string toString(){
        string str;
        for (int i = 0; i < currentNumberOfCards; i++)
            str += " " + getCard(i).toString();
        return str;
    }

    /******************************************************************************/
    /*** Methods below this points are implemented in file handcombinations.cpp ***/
    /******************************************************************************/

    /**
     * Creates all the possible combinations of the hand given its cards. There are
     * two types of combinations: singles and pairs. Combinations must be put in the
     * table allCombinations.
     *
     * Hint: for each combination, you also have to update the variable allCombinationsSize.
     *       Initially, the variable allCombinationsSize is set to 0.
     */
    void createAllCombinations();
};

#endif // HAND_H
