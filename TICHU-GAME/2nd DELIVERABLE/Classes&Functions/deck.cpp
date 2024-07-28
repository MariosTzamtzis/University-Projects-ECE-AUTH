#include <algorithm>
#include "deck.h"

using namespace std;

Deck::Deck(){
    deckSize = 56;
    string suits[4] = {"JADE", "SWORD", "PAGODA", "STAR"};

    cardsUsed = 0;
    for (int suit = 0; suit <= 3; suit++){
        for (int value = 2; value <= 14; value++){
            cards[cardsUsed] = Card();
            cards[cardsUsed].setValue(value);
            cards[cardsUsed].setSuit(suits[suit]);
            cardsUsed++;
        }
    }
    cards[cardsUsed] = Card();
    cards[cardsUsed].setValue(1);
    cards[cardsUsed].setSuit("MAHJONG");
    cardsUsed++;

    cards[cardsUsed] = Card();
    cards[cardsUsed].setValue(15);
    cards[cardsUsed].setSuit("DRAGON");
    cardsUsed++;

    cards[cardsUsed] = Card();
    cards[cardsUsed].setValue(-1);
    cards[cardsUsed].setSuit("PHOENIX");
    cardsUsed++;

    cards[cardsUsed] = Card();
    cards[cardsUsed].setValue(-1);
    cards[cardsUsed].setSuit("DOG");

    cardsUsed = 0;
}

void Deck::shuffle(){
    for (int i = 0; i < cardsLeft(); i++){
        int r = i + (rand() % (cardsLeft() - i));
        Card temp = cards[i];
        cards[i] = cards[r];
        cards[r] = temp;
    }
    cardsUsed = 0;
}

int Deck::cardsLeft(){
    return deckSize - cardsUsed;
}

Card Deck::deal(){
    Card c = cards[cardsUsed];
    cardsUsed++;
    return c;
}
