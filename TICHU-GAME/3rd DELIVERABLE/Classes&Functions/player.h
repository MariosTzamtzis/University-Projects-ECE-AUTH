#ifndef PLAYER_H
#define PLAYER_H

#include <string>
#include "hand.h"

using namespace std;

/**
 * Enumeration used to represent the different statuses of the player.
 */
enum PlayerStatus {HASNTPLAYED, PASSED, PLAYED, HASNOCARDSLEFT, WONTHETRICK};

/**
 * Class that implements a player of the game.
 */
class Player
{
private:
	int index;
	string name;
	Hand* hand; // the hand of the player
	Card** bucket; // the bucket of the player that contains the cards that are picked up by the player
    int bucketSize;  // the current size of the bucket (initialized to 0 and incremented when cards are added)
	PlayerStatus status; // the status of the player, one of HASNTPLAYED, PASSED, PLAYED, HASNOCARDSLEFT, WONTHETRICK
public:

    /**
     * Initializes a player setting the index, the name, and the status.
     * The size of the bucket is also initialized to zero.
     *
     * @param index the index of the player.
     */
	Player(int index);

    /**
     * Deletes the player by deleting its hand and bucket. Warning: this method
     * does not also delete each individual card! Cards are deleted by the deck.
     */
    ~Player();

    /**
     * Sets the status of the player.
     *
     * @param status the status to set the player to.
     */
    void setStatus(PlayerStatus status);

    /**
     * Checks whether the status of the player is the same as the one given.
     *
     * @param status the status to be checked against that of the player.
     * @return true if the status of the player is the same as the one given, or false otherwise.
     */
    bool hasStatus(PlayerStatus status);

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

    /**
     * Adds a card to the hand of the player. This method only
     * calls the method addCard of the hand.
     *
     * @param card the card to be added to the hand of the player.
     */
    void addCardToHand(Card* card);

    /**
     * Removes a combination from the hand of the player. This method only
     * calls the method removeCombination of the hand.
     *
     * @param combination the combination to be removed from the hand of the player.
     */
	void removeCombinationFromHand(Combination* combination);

    /**
     * Adds the cards of the given combination to the bucket of the player and increases the bucketSize accordingly.
     *
     * @param combination the combination of which the cards are added to the bucket of the player.
     */
	void addCombinationToBucket(Combination* combination);

    /**
     * Adds the given cards to the bucket of the player and increases the bucketSize accordingly.
     *
     * @param cards the cards to be added to the bucket of the player.
     * @param numberOfCards the number of cards that are added to the bucket of the player.
     */
	void addCardsToBucket(Card** cards, int numberOfCards);

    /**
     * Initializes (clears) the hand of the player and creates the combinations. This method only
     * calls the method clearHand and then the method createAllCombinations of the hand.
     */
    void createHandCombinations();

    /**
     * Computes and returns the number of combinations that are playable on top of the given combination.
     *
     * @param combination the top (last played) combination of the table to check how many combinations
                          can be played by the player.
     * @return the number of combinations that the player can play on top of the given combination.
     */
    int findNumberOfPlayableCombinations(Combination* combination);

    /**
     * Enumerates all playable combinations of the player and decides which of them is going to be played.
     * The combination that is played is randomly selected.
     *
     * @param combination the last combination on the table, or NULL if there is no combination on the table.
     * @return a combination of the hand of the player that is playable.
     */
    Combination* play(Combination* combination);

    /**
     * Takes all cards from the hand and the bucket of the player given and adds them to the bucket of
     * the player.
     *
     * @param otherPlayer the player from which all the cards (hand and bucket) are taken.
     */
    void getHandAndBucketFromPlayer(Player* otherPlayer);

    /**
     * Returns a string representation of the player, including the player's name
     * and the cards of the player's hand.
     *
     * @return the player as string.
     */
	string toString();

    /**
     * Computes and returns the number of points of the cards in the player's bucket.
     *
     * @return the total number of points for all cards in the player's bucket.
     */
	int countBucketPoints();

    /**
     * Checks if the current combination can be played after the last combination.
     *
     * @param current the current combination to check if it can be played after the last.
     * @param last the last combination to check if the current combination is playable.
     * @return true if the current combination can be played after the last one, or false otherwise.
     */
    bool combinationCanBePlayed(Combination *current, Combination *last);
};

#endif // PLAYER_H
