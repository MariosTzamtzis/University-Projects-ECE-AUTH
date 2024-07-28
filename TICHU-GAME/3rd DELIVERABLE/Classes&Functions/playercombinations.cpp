#include <cstdlib>
#include <iostream>
#include "player.h"

Player::Player(int index){
	hand = new Hand();
	status = HASNTPLAYED;
	this->index = index;
	if (index==0) name = "Player 1";
	else if (index==1) name = "Player 2";
	else if (index==2) name = "Player 3";
	else if (index==3) name = "Player 4";
    bucketSize = 0;
	bucket = new Card*[56];
}

Player::~Player(){
    delete hand;
    delete[] bucket;
}

void Player::setStatus(PlayerStatus status){
    this->status = status;
}

bool Player::hasStatus(PlayerStatus status){
    return this->status == status;
}

string Player::getName(){
    return name;
}

bool Player::hasNoCardsLeft(){
    return hand->getCardCount() == 0;
}

bool Player::hasMahJong(){
    for (int i = 0; i < hand->getCardCount(); i++){
        if (hand->getCard(i)->hasSuit(MAHJONG))
            return true;
    }
    return false;
}

bool Player::decidePlay(){
	return rand() % 2 == 1;
}

void Player::addCardToHand(Card* card){
    hand->addCard(card);
}

void Player::removeCombinationFromHand(Combination* combination){
    hand->removeCombination(combination);
}

void Player::addCombinationToBucket(Combination* combination){
	for (int i = 0; i < combination->getNumberOfCards(); i++)
		bucket[bucketSize + i] = combination->getCard(i);
    bucketSize += combination->getNumberOfCards();
}

void Player::addCardsToBucket(Card** cards, int numberOfCards){
	for (int i = 0; i < numberOfCards; i++)
		bucket[bucketSize + i] = cards[i];
    bucketSize += numberOfCards;
}

void Player::createHandCombinations(){
    hand->clearHand();
    hand->createAllCombinations();
}

int Player::findNumberOfPlayableCombinations(Combination* combination){
	int numPlayableCombinations = 0;
    for (int i = 0; i < hand->getNumberOfCombinations(); i++){
        if (combinationCanBePlayed(hand->getCombination(i), combination))
            numPlayableCombinations++;
    }
    return numPlayableCombinations;
}

Combination* Player::play(Combination* combination){
    // Find the combinations that are playable
    int numPlayableCombinations = (combination == NULL) ? hand->getNumberOfCombinations() : findNumberOfPlayableCombinations(combination);
    int j = 0;
    Combination** playableCombinations = new Combination*[numPlayableCombinations];
	for (int i = 0; i < hand->getNumberOfCombinations(); i++){
		if (combination == NULL || combinationCanBePlayed(hand->getCombination(i), combination))
		    playableCombinations[j++] = hand->getCombination(i);
	}

    // Print all playable combinations
    cout << "Possible combinations:";
    for (int i = 0; i < numPlayableCombinations; i++)
	    cout << " " << playableCombinations[i]->toString();
    cout << endl;

	// Select randomly a combination from 0 to number of playable combinations
	int indexOfSelectedCombination = rand() % numPlayableCombinations;
	Combination* combinationToPlay = playableCombinations[indexOfSelectedCombination];
	delete[] playableCombinations;
    return combinationToPlay;
}

string Player::toString(){
    return name;// + hand->toString();
}

void Player::getHandAndBucketFromPlayer(Player* otherPlayer){
    int numCards = otherPlayer->bucketSize;
	for (int i = 0; i < numCards; i++){
		bucket[bucketSize + i] = otherPlayer->bucket[i];
	}
    bucketSize += numCards;
    otherPlayer->bucketSize = 0;

    numCards = otherPlayer->hand->getCardCount();
	for (int i = numCards - 1; i >= 0; i--){
		bucket[bucketSize + i] = otherPlayer->hand->getCard(i);
		otherPlayer->hand->removeCard(bucket[bucketSize + i]);
	}
    bucketSize += numCards;
}
