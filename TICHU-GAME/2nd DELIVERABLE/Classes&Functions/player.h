#ifndef PLAYER_H
#define PLAYER_H

#include <string>
#include <cstdlib>
#include <iostream>
#include "hand.h"

using namespace std;

/**
 * Class that implements a player of the game.
 */
class Player
{
	int index;
	string name;
	Hand hand; // the hand of the player
	Card bucket[56]; // the bucket of the player that contains the cards that are picked up by the player
    int bucketSize;  // the current size of the bucket (initialized to 0 and incremented when cards are added)
	string status; // the status of the player, one of "HASNTPLAYED", "PASSED",
                   // "PLAYED", "HASNOCARDSLEFT", "WONTHETRICK"
public:

    /**
     * Initializes a player setting the index, the name, and the status.
     * The size of the bucket is also initialized to zero.
     *
     * @param idx the index of the player.
     */
	Player(int idx);

    /**
     * Sets the status of the player.
     *
     * @param newStatus the status to set the player to.
     */
    void setStatus(string newStatus);

    /**
     * Checks whether the status of the player is the same as the one given.
     *
     * @param checkStatus the status to be checked against that of the player.
     * @return true if the status of the player is the same as the one given, or false otherwise.
     */
    bool hasStatus(string checkStatus);

    /**
     * Returns the name of the player.
     *
     * @return the name of the player.
     */
    string getName();

    /**
     * Checks whether the player's hand has no cards left.
     *
     * @return true if the hand of the player has no cards left, or false otherwise.
     */
	bool hasNoCardsLeft();

    /**
     * Checks whether the player's hand has the Mah Jong card.
     *
     * @return true if the hand of the player has the Mah Jong card, or false otherwise.
     */
    bool hasMahJong();

    /**
     * Decides whether the player should play or pass with 50-50 probability.
     *
     * @return true if the player will play, or false otherwise.
     */
    bool decidePlay();

    /********************************************************************************/
    /*** Methods below this points are implemented in file playercombinations.cpp ***/
    /********************************************************************************/

    /**
     * Adds a card to the hand of the player. This method only
     * calls the method addCard of the hand.
     *
     * @param card the card to be added to the hand of the player.
     */
    void addCardToHand(Card card);

    /**
     * Removes a card from the hand of the player. This method only
     * calls the method removeCard of the hand.
     *
     * @param card the card to be removed from the hand of the player.
     */
	void removeCardFromHand(Card card);

    /**
     * Initializes (clears) the hand of the player and creates the combinations. This method only
     * calls the method clearHand and then the method createAllCombinations of the hand.
     */
    void createHandCombinations();

    /**
     * Adds the cards of the given combination to the bucket of the player and increases the bucketSize accordingly.
     *
     * @param combination the combination of which the cards are added to the bucket of the player.
     */
	void addCardsToBucket(Combination combination);

    /**
     * Computes and returns the number of combinations that are playable on top of the given combination.
     *
     * @param combination the top (last played) combination of the table to check how many combinations
                          can be played by the player.
     * @return the number of combinations that the player can play on top of the given combination.
     */
    int findNumberOfPlayableCombinations(Combination combination);

    /**
     * Enumerates all combinations of the player and decides which of them is going to be played.
     * The combination that is played is randomly selected.
     *
     * @return a combination of the hand of the player.
     */
    Combination playAnyCombination();

    /**
     * Enumerates all playable combinations of the player and decides which of them is going to be played.
     * The combination that is played is randomly selected.
     *
     * @return a combination of the hand of the player that is playable.
     */
    Combination play(Combination combination);

    /**
     * Returns a string representation of the player, including the player's name
     * and the cards of the player's hand.
     *
     * @return the player as string.
     */
     string toString(){
         return name + hand.toString();
     }
};

#endif // PLAYER_H
