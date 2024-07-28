#ifndef CARD_H
#define CARD_H

#include <sstream>
#include <string>

using namespace std;

/**
 * Class denoting a card.
 */
class Card
{
private:
    string suit; // the suit of the card, one of "JADE", "SWORD", "PAGODA", "STAR",
                 // or one of the special cards "MAHJONG", "DRAGON", "PHOENIX", "DOG"
    int value;
public:

    /**
     * Initializes the card setting its suit to an empty string and its value to 0.
     */
    Card();

    /**
     * Sets the value of the card.
     *
     * @param theValue the value to set the card to.
     */
    void setValue(int theValue);

    /**
     * Sets the suit of the card.
     *
     * @param theSuit the suit to set the card to.
     */
    void setSuit(string theSuit);

    /**
     * Returns the suit of the card.
     *
     * @return the suit of the card.
     */
    string getSuit();

    /**
     * Checks whether the suit of the card is the same as the one given.
     *
     * @param theSuit the suit to be checked against that of the card.
     * @return true if the suit of the card is the same as the one given, or false otherwise.
     */
    bool hasSuit(string theSuit);

    /**
     * Returns the value of the card.
     *
     * @return the value of the card.
     */
    int getValue();

    /**
     * Checks if this card is equal to the card given. Two cards are equal if they
     * have the same suit and the same value.
     *
     * @param otherCard the card to compare with this card.
     * @return true if this card is equal to the other card, or false otherwise.
     */
    bool equals(Card otherCard);

    /**
     * Checks whether the card can participate in a combination. All cards, except for
     * the Dragon and the Dog can be in a combination.
     *
     * @return true if the card can be in a combination, or false otherwise.
     */
    bool canBeInCombination();

    /**
     * Checks whether the card can participate in a bomb combination. All non-special
     * cards can be in a bomb. The four special cards (Mah Jong, Dragon, Dog, and Phoenix)
     * cannot be in a bomb.
     *
     * @return true if the card can be in a bomb combination, or false otherwise.
     */
    bool canBeInBomb();

    /**
     * Returns a string representation of the card.
     *
     * @return the card as string.
     */
    string toString(){
        string valueString;
        if (value >= 11 && value <= 14){
            switch (value){
                case 11: valueString = "J"; break;
                case 12: valueString = "Q"; break;
                case 13: valueString = "K"; break;
                case 14: valueString = "A"; break;
                default: valueString = "";
            }
        }
        else{
            stringstream ss; ss << value;
            valueString = ss.str();
        }
        return valueString + ":" + suit;
    };
};

#endif // CARD_H
