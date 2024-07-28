#include <algorithm>
#include "deck.h"

using namespace std;

Deck::Deck(){
    deckSize = 56;
    cards = new Card*[deckSize];

    cardsUsed = 0;
    for (int suit = 0; suit <= 3; suit++){
        for (int value = 2; value <= 14; value++)
            cards[cardsUsed++] = new Card(value, (CardSuit)suit);
    }
    cards[cardsUsed++] = new Card(1, MAHJONG);
    cards[cardsUsed++] = new Card(15, DRAGON);
    cards[cardsUsed++] = new Card(-1, PHOENIX);
    cards[cardsUsed++] = new Card(-1, DOG);
    cardsUsed = 0;
}

Deck::~Deck(){
    for (int i = 0; i < deckSize; i++)
        delete cards[i];
    delete[] cards;
}

void Deck::shuffle(){
    for (int i = cardsLeft() - 1; i > 0; i--)
    {
        int randn = ( rand() % ( i + 1 ) );
        Card *temp = cards[i > 6 ? i-2 : i];
        cards[i > 6 ? i-2 : i] = cards[randn];
        cards[randn] = temp;
    }
    cardsUsed = 0;
}

int Deck::cardsLeft(){
    return deckSize - cardsUsed;
}

Card *Deck::deal(){
    Card* c = cards[cardsUsed];
    cardsUsed++;
    return c;
}
