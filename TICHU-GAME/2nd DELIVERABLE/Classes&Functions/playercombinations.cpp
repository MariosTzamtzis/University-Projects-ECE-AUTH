#include "player.h"

void Player::addCardToHand(Card card){
    hand.addCard(card);
}

void Player::removeCardFromHand(Card card){
    hand.removeCard(card);
}

void Player::addCardsToBucket(Combination combination){
	for (int i = 0; i < combination.getNumberOfCards(); i++)
		bucket[bucketSize + i] = combination.getCard(i);
    bucketSize += combination.getNumberOfCards();
}

void Player::createHandCombinations(){
    hand.clearHand();
    hand.createAllCombinations();
}

int Player::findNumberOfPlayableCombinations(Combination combination){
	int numPlayableCombinations = 0;
    for (int i = 0; i < hand.getNumberOfCombinations(); i++){
        if (hand.getCombination(i).canBePlayed(combination))
            numPlayableCombinations++;
    }
    return numPlayableCombinations;
}

Combination Player::playAnyCombination(){
    // All possible combinations are playable, so print them all
    cout << "Possible combinations:";
    for (int i = 0; i < hand.getNumberOfCombinations(); i++)
		cout << " " << hand.getCombination(i).toString();
    cout << endl;

	// Select randomly a combination from 0 to number of combinations
	int indexOfSelectedCombination = rand() % hand.getNumberOfCombinations();
	return hand.getCombination(indexOfSelectedCombination);
}

Combination Player::play(Combination combination){
    // Find the combinations that are playable
	int numPlayableCombinations = findNumberOfPlayableCombinations(combination);
    int j = 0;
    Combination playableCombinations[numPlayableCombinations];
	for (int i = 0; i < hand.getNumberOfCombinations(); i++){
		if (hand.getCombination(i).canBePlayed(combination))
		    playableCombinations[j++] = hand.getCombination(i);
	}

    // Print all playable combinations
    cout << "Possible combinations:";
    for (int i = 0; i < numPlayableCombinations; i++)
		cout << " " << playableCombinations[i].toString();
    cout << endl;

	// Select randomly a combination from 0 to number of playable combinations
	int indexOfSelectedCombination = rand() % numPlayableCombinations;
    return playableCombinations[indexOfSelectedCombination];
}

