#include "hand.h"
// TODO: Implement here the method createAllCombinations of Hand

void Hand::createAllCombinations(){
   int i, j;
   Card temp; //We need it for the sorting.

    //Bubblesort: Sort Cards Array In Ascending Order.
    for (i=0; i<currentNumberOfCards; i++){
        for (j=i; j<currentNumberOfCards; j++){
            if (cards[i].getValue()>cards[j].getValue()){
               temp=cards[i];
               cards[i]=cards[j];
               cards[j]=temp;
            }
        }
    }
 //We sorting cards' array in ascending order
 //in order to make the creation of pairs-combination easier.


 //Create single-combination
    for (i=0; i<currentNumberOfCards; i++){
        allCombinations[i].addCard(cards[i]);
        allCombinationsSize++;
    }
    //Create pairs-combination.
    for (i=0; i<currentNumberOfCards; i++){
        //Checking if 2 cards has the same value.
        if (cards[i].getValue()==cards[i+1].getValue() && i<currentNumberOfCards-1){
            allCombinations[allCombinationsSize].addCard(cards[i]);
            allCombinations[allCombinationsSize++].addCard(cards[i+1]);
            //Checking if 3 cards has the same value.
            if (cards[i+1].getValue()==cards[i+2].getValue() && i<currentNumberOfCards-2 ){
                allCombinations[allCombinationsSize].addCard(cards[i]);
                allCombinations[allCombinationsSize++].addCard(cards[i+2]);
                allCombinations[allCombinationsSize].addCard(cards[i+1]);
                allCombinations[allCombinationsSize++].addCard(cards[i+2]);
                //Checking if 4 cards has the same value.
                if (cards[i+2].getValue()==cards[i+3].getValue() && i<currentNumberOfCards-3){
                    allCombinations[allCombinationsSize].addCard(cards[i]);
                    allCombinations[allCombinationsSize++].addCard(cards[i+3]);
                    allCombinations[allCombinationsSize].addCard(cards[i+1]);
                    allCombinations[allCombinationsSize++].addCard(cards[i+3]);
                    allCombinations[allCombinationsSize].addCard(cards[i+2]);
                    allCombinations[allCombinationsSize++].addCard(cards[i+3]);
                    i += 2; //If 4 cards has the same value jump 3 position.
                }
                else i++; //If 3 cards has the same value jump 2 position.
            }
        }
    }
}
