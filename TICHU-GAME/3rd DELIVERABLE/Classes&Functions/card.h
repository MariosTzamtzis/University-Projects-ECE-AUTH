#ifndef CARD_H
#define CARD_H

#include <string>

using namespace std;

/**
 * Enumeration used to represent the different suits of cards.
 */
enum CardSuit {JADE, SWORD, PAGODA, STAR, MAHJONG, DRAGON, PHOENIX, DOG};

/**
 * Class denoting a card.
 */
class Card
{
private:
    CardSuit suit; // the suit of the card, one of JADE, SWORD, PAGODA, STAR,
                   // or one of the special cards MAHJONG, DRAGON, PHOENIX, DOG
protected:
    int value;
public:
    /**
     * Initializes the card with its value and its suit.
     *
     * @param value the value of the card.
     * @param suit the suit of the card.
     */
    Card(int value, CardSuit suit);

    /**
     * Returns the suit of the card.
     *
     * @return the suit of the card.
     */
    CardSuit getSuit();

    /**
     * Checks whether the suit of the card is the same as the one given.
     *
     * @param suit the suit to be checked against that of the card.
     * @return true if the suit of the card is the same as the one given, or false otherwise.
     */
    bool hasSuit(CardSuit suit);

    /**
     * Returns the value of the card.
     *
     * @return the value of the card.
     */
    int getValue();

    /**
     * Sets the value of the Phoenix. This function should be called once
     * before every turn of the player that has the Phoenix in hand. If this
     * function is called on any other card, then nothing happens.
     *
     * @param value the value to set the Phoenix to.
     */
    void setValue(int value);

    /**
     * Checks if this card is equal to the card given.
     *
     * @param otherCard the card to compare with this card.
     * @return true if this card is equal to the other card, or false otherwise.
     */
    bool equals(Card* otherCard);

    /**
     * Checks whether the card can participate in a combination.
     *
     * @return true if the card can be in a combination, or false otherwise.
     */
    bool canBeInCombination();

    /**
     * Checks whether the card can participate in a bomb combination.
     *
     * @return true if the card can be in a bomb combination, or false otherwise.
     */
    bool canBeInBomb();

    /**
     * Returns a string representation of the card.
     *
     * @return the card as string.
     */
    string toString();
};

#endif // CARD_H
