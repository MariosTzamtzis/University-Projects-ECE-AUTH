#include "table.h"

Table::Table(){
    numCombinationsOnTable = 0;
}

void Table::clear(){
    if (numCombinationsOnTable > 0){
        for (int i = 0; i < numCombinationsOnTable; i++)
            combinationsOnTable[i] = Combination();
        numCombinationsOnTable = 0;
    }
}

int Table::getNumberOfCombinations(){
    return numCombinationsOnTable;
}

Combination Table::getCombination(int index){
    return combinationsOnTable[index];
}

void Table::addCombinationOnTable(Combination combination){
    combinationsOnTable[numCombinationsOnTable++] = combination;
}

Combination Table::getTopCombination(){
    return combinationsOnTable[numCombinationsOnTable - 1];
}
