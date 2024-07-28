#include<iostream>

using namespace std;

/**
 * Shuffles an array using an algorithm that initially iterates an index i from the last to second element.
 * And then a second index j is used to select an element randomly between the first element and the i-th element.
 * And finally The elements in positions i and j are swapped.
 *
 * @param myArray the array to be shuffled.
 * @param myArraySize the index of the array to be shuffled.
 */
template <class X> void shuffle(X** myArray, int myArraySize){
    // TODO: Implement here the shuffle algorithm
    // Copy your implementation from the fourth deliverable
    for (int i=myArraySize-1; i>0; i--){
        int j = rand() % (i+1); //Creates a random number between 0 and i.
        X* temp;
        temp=myArray[i];
        myArray[i]=myArray[j];
        myArray[j]=temp;
    }

}

/**
 * "Cuts" an array at a random point similarly to a deck of cards (i.e. getting the last part of
 * the cards and moving it before the first part of the cards).
 *
 * @param myArray the array to be "cut".
 * @param myArraySize the index of the array to be "cut".
 */
template <class X> void cut(X** myArray, int myArraySize){
    // TODO: Implement here the cut algorithm
    // Copy your implementation from the fourth deliverable
    int cutPoint = rand() % myArraySize; //Creates a random number between 0 and myArraySize - 1.
    //If cutpoint is equals to 0 or myArraySize - 1, the first and the last card respectively, there is no reason to do a cut.
    if (cutPoint != 0 && cutPoint != myArraySize-1){
        X** temp=new X*[cutPoint]; //Creating a temporal array to save the first part of the deck.
        int i, j;
        for (i=0; i<cutPoint; i++) temp[i]=myArray[i]; //Saving the first part of the deck.
        for (i=cutPoint, j=0; i<myArraySize; i++, j++) myArray[j]=myArray[i]; //Transport the part after cutpoint at the beginning of the deck.
        for (i=0; j<myArraySize; i++, j++) myArray[j]=temp[i]; //Transport the part of the deck before cutpoint at the end of the deck.
        delete[] temp; //Deleting dynamic array.
    }
}
