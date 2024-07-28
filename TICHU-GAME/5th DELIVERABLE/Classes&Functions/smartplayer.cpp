#include <cstdlib>
#include "player.h"
#include "shuffler.h"
#include "card.h"

SmartPlayer::SmartPlayer(int index) : Player(index){
    team = "Team 006"; // TODO: Change this to your team number e.g. "Team 150"
}

int SmartPlayer::setPhoenixValue(Table* table, PlayerStatus* playerStatuses, int* numberOfCardsPerPlayer, Combination* lastCombinationOnTable){
    // TODO: Implement this function (some useful objects that you may use are the cards that can be retrieved from the hand
    // or the playable combinations that are given as a parameter)
    /// This function MUST return an integer value from 1 to 14
    return 14;
}

int SmartPlayer::decideAndPlay(Combination** playableCombinations, int numPlayableCombinations, Table* table, PlayerStatus* playerStatuses, int* numberOfCardsPerPlayer, Combination* lastCombinationOnTable){
    // TODO: Implement this function (some useful objects that you may use are the cards that can be retrieved from the hand
    // or the combinations that are currently on the table and can be retrieved from the table or the number of cards or the statuses of other players)
    /// After that, it MUST return an integer index to the combinations available in this dynamic array (a Combination* object).
    /// This function can also return -1 if the player wishes to pass, however -1 CANNOT BE RETURNED if the last given
    /// combination (the 'Combination* lastCombinationOnTable' that is given as a parameter) is NULL
    int i,j,k,flag=0,m=index,p=0,v=0;

    //Create a temp array of the cards in order to be able to use it for the function containsCard which is included in class Combination
    int tempsize = 56;
    Card** temp = new Card*[tempsize];

    int cardsUsed = 0;
    for (int suit = 0; suit <= 3; suit++){
        for (int value = 2; value <= 14; value++)
            temp[cardsUsed++] = new SimpleCard(value, (CardSuit)suit);
    }
    temp[cardsUsed++] = new SpecialCard(MAHJONG);
    temp[cardsUsed++] = new SpecialCard(DRAGON);
    temp[cardsUsed++] = new SpecialCard(PHOENIX);
    temp[cardsUsed++] = new SpecialCard(DOG);
    cardsUsed = 0;


    if(m<=1)//For the first smart player
    {
    //The table is empty
    if(lastCombinationOnTable==NULL)
    {

        for(i=0;i<numPlayableCombinations;i++)
        {
            if(playableCombinations[i]->getNumberOfCards()==numberOfCardsPerPlayer[m])//Checking if the player has a combination which contains all the cards that he's got
                return i;
        }
        for(j=14;j>4;j--)
        {
            for(i=0;i<numPlayableCombinations;i++)
            {
                if((playableCombinations[i]->getType()==STRAIGHT&&playableCombinations[i]->containsCard(temp[52]))&&playableCombinations[i]->getNumberOfCards()==j)//Checking if player has a straight which includes Mahjong and contains j cards
                    return i;
            }
        }
        for(i=0;i<numPlayableCombinations;i++)
        {
            if(playableCombinations[i]->containsCard(temp[52]))//Checking if player has the Mahjong(without being in straight)
            return i;
        }
        for(i=0;i<numPlayableCombinations;i++)
        {
            if(playableCombinations[i]->containsCard(temp[55]))//Checking if player has the Dog
            return i;
        }
        if(m==0)//Checking if player's index is 0
        {
            for(i=0;i<numPlayableCombinations;i++)
        {
            if(playableCombinations[i]->getNumberOfCards()>numberOfCardsPerPlayer[1]&&playableCombinations[i]->getNumberOfCards()>numberOfCardsPerPlayer[3])//Checking if player has a combination which contains more cards than the cards that other players have
            return i;
        }
        }
        if(m==1)//Checking if player's index is 1
        {
            for(i=0;i<numPlayableCombinations;i++)
        {
            if(playableCombinations[i]->getNumberOfCards()>numberOfCardsPerPlayer[0]&&playableCombinations[i]->getNumberOfCards()>numberOfCardsPerPlayer[2])//Checking if player has a combination which contains more cards than the cards that other players have
            return i;
        }

        }


        for(j=14;j>4;j--)
        {
            for(i=0;i<numPlayableCombinations;i++)
            {
                if((playableCombinations[i]->getType()==STRAIGHT&&playableCombinations[i]->getType()!=STRAIGHTFLUSH)&&playableCombinations[i]->getNumberOfCards()==j)//Checking if player has a straight which contains j cards
                    return i;
            }
        }

        for(j=14;j>4;j--)
        {
            for(i=0;i<numPlayableCombinations;i++)
            {
                if(playableCombinations[i]->getType()==STAIRS&&playableCombinations[i]->getNumberOfCards()==j)//Checking if player has stairs which contain j cards
                    return i;
            }
        }

        for(i=0;i<numPlayableCombinations;i++)
        {
            for(j=200;j<1100;j+=100)
            if(playableCombinations[i]->getType()==FULLHOUSE&&(playableCombinations[i]->getValue()>j&&playableCombinations[i]->getValue()<100+j))//Searching for a fullhouse with the lowest value
                return i;
        }

        p=0,v=0;
        for(j=2;j<14;j++)
        {
            v+=4;
            for(i=0;i<numPlayableCombinations;i++)
            {
            if(playableCombinations[i]->getType()==SINGLE&&playableCombinations[i]->getValue()==j)//Checking if player has a single with j value
            {
                flag=1;//flag becomes 1
                break;
            }
            }
            while(p<v)
            {
            for(k=0;k<numPlayableCombinations;k++)
            {
                if(playableCombinations[k]->getType()!=SINGLE&&playableCombinations[k]->containsCard(temp[p]))//Checking if the card with j value can be played in a combination except for single
            {
            flag=2;//flag becomes 2
            break;
            }
            }
            p++;
            }
            if(flag==1)//If the card can be played only as single we play it(we prefer to play from lower valued to higher valued cards)
                return i;
        }

        flag=0,p=0,v=0;
        for(j=2;j<14;j++)
        {
            v+=4;
            for(i=0;i<numPlayableCombinations;i++)
            {
            if(playableCombinations[i]->getType()==PAIR&&playableCombinations[i]->getValue()==j)//Checking if player has a pair with j value
            {
                flag=1;//flag becomes 1
                break;
            }
            }
            while(p<v)
            {
            for(k=0;k<numPlayableCombinations;k++)
            {
            if((playableCombinations[k]->getType()!=PAIR&&playableCombinations[k]->getType()!=SINGLE)&&playableCombinations[k]->containsCard(temp[p]))//Checking if the 2 cards with j value can be played in a combination except for single and pair
            {
            flag=2;//flag becomes 2
            break;
            }
            }
            p++;
            }
            if(flag==1)//If the 2 cards can be played only as a pair(except for single) we play it(we prefer to play from lower valued to higher valued cards)
                return i;
        }


        flag=0;

        p=0,v=0;
        for(j=2;j<14;j++)
        {
            v+=4;
            for(i=0;i<numPlayableCombinations;i++)
            {
            if(playableCombinations[i]->getType()==THREEOFAKIND&&playableCombinations[i]->getValue()==j)//Checking if player has a threeofakind with j value
            {
                flag=1;//flag becomes 1
                break;
            }
            }
            while(p<v)
            {
            for(k=0;k<numPlayableCombinations;k++)
            {
            if(((playableCombinations[k]->getType()!=PAIR&&playableCombinations[k]->getType()!=SINGLE)&&playableCombinations[k]->containsCard(temp[p]))&&playableCombinations[k]->getType()!=THREEOFAKIND)//Checking if the 3 cards with j value can be played
            {                                                                                                                                                                                       //in a combination except for single,pair and threeofakind
            flag=2;//flag becomes 2
            break;
            }
            }
            p++;
            }
            if(flag==1)//If the 3 cards can be played only as threeofakind(except for single and pair) we play it(we prefer to play from lower valued to higher valued cards)
                return i;
        }

    }

    if(playableCombinations[0]==NULL)//if there is no playable combinations the player folds
                return -1;

        //The table is not empty but the player has at least one combination to play
        if(lastCombinationOnTable!=NULL&&playableCombinations[0]!=NULL)
        {

            if(m==0)
            {
            if((playerStatuses[2]==PLAYED&&playerStatuses[3]==PASSED)&&(lastCombinationOnTable->getValue()>5||lastCombinationOnTable->getType()!=FOUROFAKIND))//If the teammate is the last player that played the smartplayer folds
                return -1;                                                                                                                                    //unless the teammate played a low valued combination(and not a bomb)
            }

            if(m==1)
            {
                if((playerStatuses[3]==PLAYED&&playerStatuses[0]==PASSED)&&(lastCombinationOnTable->getValue()>5||lastCombinationOnTable->getType()!=FOUROFAKIND))
                    return -1;
            }

            if((lastCombinationOnTable->getValue()==15||lastCombinationOnTable->getNumberOfCards()>9)||(lastCombinationOnTable->getType()==FOUROFAKIND||lastCombinationOnTable->getType()==STRAIGHTFLUSH))//Checking if the last combination that has been
            {
                return 0;//returns whatever can be played(we just want to hit the powerful combination)                                                                                                  // played is the dragon or a combination which contains 10 cards or more or a bomb

            }

            if(lastCombinationOnTable->getType()==THREEOFAKIND&&lastCombinationOnTable->getValue()==14)//If the combination on the table is three aces
                return 0;//returns whatever can be played(we just want to hit the powerful combination)

            if(lastCombinationOnTable->getType()==FULLHOUSE&&lastCombinationOnTable->getValue()>1400)
                return 0;//returns whatever can be played(we just want to hit the powerful combination)

            if(lastCombinationOnTable->getValue()==14&&lastCombinationOnTable->getType()==SINGLE)//Checking if the last combination on the table is an Ace
            {
                for(i=0;i<numPlayableCombinations;i++)
                {
                    if(playableCombinations[i]->getValue()==15)//Checking if the player has the dragon
                    {
                        return i;
                    }
                }
            }

            flag=0,v=0,p=0;
            if(lastCombinationOnTable->getType()==SINGLE)
            {
                v=((1+(lastCombinationOnTable->getValue()))-2)*4;
                p=((1+(lastCombinationOnTable->getValue()))-2)*4;
            for(j=1+(lastCombinationOnTable->getValue());j<14;j++)
            {
                v+=4;

            for(i=0;i<numPlayableCombinations;i++)
            {
            if(playableCombinations[i]->getType()==SINGLE&&playableCombinations[i]->getValue()==j)//Checking if player has a single with j value
            {
                flag=1;//flag becomes 1
                break;
            }
            }
            while(p<v)
            {
            for(k=0;k<numPlayableCombinations;k++)
            {
            if(playableCombinations[k]->getType()!=SINGLE&&playableCombinations[k]->containsCard(temp[p]))//Checking if the card with j value can be played in a combination except for single
            {
            flag=2;//flag becomes 2
            break;
            }
            }
            p++;
            }
            if(flag==1)//If the card can be played only as single we play it(we prefer to play from lower valued to higher valued cards)
                return i;
            }
            }

        flag=0;v=0,p=0;
        if(lastCombinationOnTable->getType()==PAIR)
        {
            v=((1+(lastCombinationOnTable->getValue()))-2)*4;
            p=((1+(lastCombinationOnTable->getValue()))-2)*4;
        for(j=(1+lastCombinationOnTable->getValue());j<14;j++)
        {
            v+=4;
            for(i=0;i<numPlayableCombinations;i++)
            {
            if(playableCombinations[i]->getType()==PAIR&&playableCombinations[i]->getValue()==j)//Checking if player has a pair with j value
            {
                flag=1;//flag becomes 1
                break;
            }
            }
            while(p<v)
            {
            for(k=0;k<numPlayableCombinations;k++)
            {
            if((playableCombinations[k]->getType()!=PAIR&&playableCombinations[k]->getType()!=SINGLE)&&playableCombinations[k]->containsCard(temp[p]))//Checking if the 2 cards with j value can be played in a combination except for single and pair
            {
            flag=2;//flag becomes 2
            break;
            }
            }
            p++;
            }
            if(flag==1)//If the 2 cards can be played only as a pair(except for single) we play it(we prefer to play from lower valued to higher valued cards)
                return i;
        }
        }

            if((lastCombinationOnTable->getType()==SINGLE||lastCombinationOnTable->getType()==PAIR)&&(lastCombinationOnTable->getValue()>9))//If the type of the last combination on the table is single or pair
            {                                                                                                                             //and its value is 10 or more and the only playable combination is with
                for(i=0;i<numPlayableCombinations;i++)                                                                                    //ace we play it
                {
                    if(playableCombinations[i]->getValue()==14)
                        return i;
                }
            }
        flag=0,v=0,p=0;
        if(lastCombinationOnTable->getType()==THREEOFAKIND)
        {
            v=((1+(lastCombinationOnTable->getValue()))-2)*4;
            p=((1+(lastCombinationOnTable->getValue()))-2)*4;
        for(j=(1+lastCombinationOnTable->getValue());j<14;j++)
        {
            v+=4;
            for(i=0;i<numPlayableCombinations;i++)
            {
            if(playableCombinations[i]->getType()==THREEOFAKIND&&playableCombinations[i]->getValue()==j)//Checking if player has a threeofakind with j value
            {
                flag=1;//flag becomes 1
                break;
            }
            }
            while(p<v)
            {
            for(k=0;k<numPlayableCombinations;k++)
            {
            if(((playableCombinations[k]->getType()!=PAIR&&playableCombinations[k]->getType()!=SINGLE)&&playableCombinations[k]->containsCard(temp[p]))&&playableCombinations[k]->getType()!=THREEOFAKIND)//Checking if the 3 cards with j value can be played
            {                                                                                                                                                                                       //in a combination except for single,pair and threeofakind
            flag=2;//flag becomes 2
            break;
            }
            }
            p++;
            }
            if(flag==1)//If the 3 cards can be played only as threeofakind(except for single and pair) we play it(we prefer to play from lower valued to higher valued cards)
                return i;
        }
        }
        if(lastCombinationOnTable->getType()==THREEOFAKIND&&lastCombinationOnTable->getValue()==13)//If the type of the last combination on the table is Threeofakind and its value is 13 and the only playable combinaton(except for bombs) is with ace we play it
        {
            for(i=0;i<numPlayableCombinations;i++)
                {
                    if(playableCombinations[i]->getValue()==14)
                        return i;
                }
        }

        if(lastCombinationOnTable->getType()==STAIRS)
        {
            for(j=(1+lastCombinationOnTable->getValue());j<15;j++)
        {
            for(i=0;i<numPlayableCombinations;i++)
            {
                if(playableCombinations[i]->getType()==STAIRS&&playableCombinations[i]->getValue()==j)//Checking if player has stairs with j value
                    return i;
            }
        }
        }


        if(lastCombinationOnTable->getType()==STRAIGHT)
        {
            for(j=(1+lastCombinationOnTable->getValue());j<15;j++)
        {
            for(i=0;i<numPlayableCombinations;i++)
            {
                if(playableCombinations[i]->getType()==STRAIGHT&&playableCombinations[i]->getValue()==j)//Checking if player has straight with j value
                    return i;
            }
        }
        }

        if(lastCombinationOnTable->getType()==FULLHOUSE)
        {
                for(j=100+(lastCombinationOnTable->getValue());j<1400;j+=100)
        {
            for(i=0;i<numPlayableCombinations;i++)
            {
                if(playableCombinations[i]->getType()==FULLHOUSE&&(playableCombinations[i]->getValue()>j&&playableCombinations[i]->getValue()<100+j))//Checking if player has fullhouse with value bigger than j(as close as we can to the value of last combination)
                    return i;
            }
        }
        }



    }
    }

    else//For the second smartplayer
    {
        if(lastCombinationOnTable==NULL)
    {

        for(i=0;i<numPlayableCombinations;i++)
        {
            if(playableCombinations[i]->getNumberOfCards()==numberOfCardsPerPlayer[m])//Checking if the player has a combination which contains all the cards that he's got
                return i;
        }
        for(j=14;j>4;j--)
        {
            for(i=0;i<numPlayableCombinations;i++)
            {
                if((playableCombinations[i]->getType()==STRAIGHT&&playableCombinations[i]->containsCard(temp[52]))&&playableCombinations[i]->getNumberOfCards()==j)//Checking if player has a straight which includes Mahjong and contains j cards
                    return i;
            }
        }
        for(i=0;i<numPlayableCombinations;i++)
        {
            if(playableCombinations[i]->containsCard(temp[52]))//Checking if player has the Mahjong(without being in straight)
            return i;
        }
        for(i=0;i<numPlayableCombinations;i++)
        {
            if(playableCombinations[i]->containsCard(temp[55]))//Checking if player has the Dog
            return i;
        }
        if(m==2)//Checking if player's index is 2
        {
            for(i=0;i<numPlayableCombinations;i++)
        {
            if(playableCombinations[i]->getNumberOfCards()>numberOfCardsPerPlayer[1]&&playableCombinations[i]->getNumberOfCards()>numberOfCardsPerPlayer[3])//Checking if player has a combination which contains more cards than the cards that other players have
            return i;
        }
        }
        if(m==3)//Checking if player's index is 3
        {
            for(i=0;i<numPlayableCombinations;i++)
        {
            if(playableCombinations[i]->getNumberOfCards()>numberOfCardsPerPlayer[0]&&playableCombinations[i]->getNumberOfCards()>numberOfCardsPerPlayer[2])//Checking if player has a combination which contains more cards than the cards that other players have
            return i;
        }

        }


        for(j=14;j>4;j--)
        {
            for(i=0;i<numPlayableCombinations;i++)
            {
                if((playableCombinations[i]->getType()==STRAIGHT&&playableCombinations[i]->getType()!=STRAIGHTFLUSH)&&playableCombinations[i]->getNumberOfCards()==j)//Checking if player has a straight which contains j cards
                    return i;
            }
        }

        for(j=14;j>4;j--)
        {
            for(i=0;i<numPlayableCombinations;i++)
            {
                if(playableCombinations[i]->getType()==STAIRS&&playableCombinations[i]->getNumberOfCards()==j)//Checking if player has stairs which contain j cards
                    return i;
            }
        }

        for(i=0;i<numPlayableCombinations;i++)
        {
            for(j=200;j<1100;j+=100)
            if(playableCombinations[i]->getType()==FULLHOUSE&&(playableCombinations[i]->getValue()>j&&playableCombinations[i]->getValue()<100+j))//Searching for a fullhouse with the lowest value
                return i;
        }

        p=0,v=0;
        for(j=2;j<14;j++)
        {
            v+=4;
            for(i=0;i<numPlayableCombinations;i++)
            {
            if(playableCombinations[i]->getType()==SINGLE&&playableCombinations[i]->getValue()==j)//Checking if player has a single with j value
            {
                flag=1;//flag becomes 1
                break;
            }
            }
            while(p<v)
            {
            for(k=0;k<numPlayableCombinations;k++)
            {
                if(playableCombinations[k]->getType()!=SINGLE&&playableCombinations[k]->containsCard(temp[p]))//Checking if the card with j value can be played in a combination except for single
            {
            flag=2;//flag becomes 2
            break;
            }
            }
            p++;
            }
            if(flag==1)//If the card can be played only as single we play it(we prefer to play from lower valued to higher valued cards)
                return i;
        }

        flag=0,p=0,v=0;
        for(j=2;j<14;j++)
        {
            v+=4;
            for(i=0;i<numPlayableCombinations;i++)
            {
            if(playableCombinations[i]->getType()==PAIR&&playableCombinations[i]->getValue()==j)//Checking if player has a pair with j value
            {
                flag=1;//flag becomes 1
                break;
            }
            }
            while(p<v)
            {
            for(k=0;k<numPlayableCombinations;k++)
            {
            if((playableCombinations[k]->getType()!=PAIR&&playableCombinations[k]->getType()!=SINGLE)&&playableCombinations[k]->containsCard(temp[p]))//Checking if the 2 cards with j value can be played in a combination except for single and pair
            {
            flag=2;//flag becomes 2
            break;
            }
            }
            p++;
            }
            if(flag==1)//If the 2 cards can be played only as a pair(except for single) we play it(we prefer to play from lower valued to higher valued cards)
                return i;
        }

        flag=0;


        p=0,v=0;
        for(j=2;j<14;j++)
        {
            v+=4;
            for(i=0;i<numPlayableCombinations;i++)
            {
            if(playableCombinations[i]->getType()==THREEOFAKIND&&playableCombinations[i]->getValue()==j)//Checking if player has a threeofakind with j value
            {
                flag=1;//flag becomes 1
                break;
            }
            }
            while(p<v)
            {
            for(k=0;k<numPlayableCombinations;k++)
            {
            if(((playableCombinations[k]->getType()!=PAIR&&playableCombinations[k]->getType()!=SINGLE)&&playableCombinations[k]->containsCard(temp[p]))&&playableCombinations[k]->getType()!=THREEOFAKIND)//Checking if the 3 cards with j value can be played
            {                                                                                                                                                                                       //in a combination except for single,pair and threeofakind
            flag=2;//flag becomes 2
            break;
            }
            }
            p++;
            }
            if(flag==1)//If the 3 cards can be played only as threeofakind(except for single and pair) we play it(we prefer to play from lower valued to higher valued cards)
                return i;
        }

    }

    if(playableCombinations[0]==NULL)//if there is no playable combinations the player folds
                return -1;

        //The table is not empty but the player has at least one combination to play
        if(lastCombinationOnTable!=NULL&&playableCombinations[0]!=NULL)
        {

            if(m==2)
            {
            if((playerStatuses[0]==PLAYED&&playerStatuses[1]==PASSED)&&(lastCombinationOnTable->getValue()>5||lastCombinationOnTable->getType()!=FOUROFAKIND))//If the teammate is the last player that played the smartplayer folds
                return -1;                                                                                                                                    //unless the teammate played a low valued combination(and not a bomb)
            }

            if(m==3)
            {
                if((playerStatuses[1]==PLAYED&&playerStatuses[2]==PASSED)&&(lastCombinationOnTable->getValue()>5||lastCombinationOnTable->getType()!=FOUROFAKIND))
                    return -1;
            }

            if((lastCombinationOnTable->getValue()==15||lastCombinationOnTable->getNumberOfCards()>9)||(lastCombinationOnTable->getType()==FOUROFAKIND||lastCombinationOnTable->getType()==STRAIGHTFLUSH))//Checking if the last combination that has been
            {
                return 0;//returns whatever can be played(we just want to hit the powerful combination)                                                                                                  // played is the dragon or a combination which contains 10 cards or more or a bomb

            }

            if(lastCombinationOnTable->getType()==THREEOFAKIND&&lastCombinationOnTable->getValue()==14)//If the combination on the table is three aces
                return 0;//returns whatever can be played(we just want to hit the powerful combination)

            if(lastCombinationOnTable->getType()==FULLHOUSE&&lastCombinationOnTable->getValue()>1400)
                return 0;//returns whatever can be played(we just want to hit the powerful combination)

            if(lastCombinationOnTable->getValue()==14&&lastCombinationOnTable->getType()==SINGLE)//Checking if the last combination on the table is an Ace
            {
                for(i=0;i<numPlayableCombinations;i++)
                {
                    if(playableCombinations[i]->getValue()==15)//Checking if the player has the dragon
                    {
                        return i;
                    }
                }
            }

            flag=0,v=0,p=0;
            if(lastCombinationOnTable->getType()==SINGLE)
            {
                v=((1+(lastCombinationOnTable->getValue()))-2)*4;
                p=((1+(lastCombinationOnTable->getValue()))-2)*4;
            for(j=1+(lastCombinationOnTable->getValue());j<14;j++)
            {
                v+=4;

            for(i=0;i<numPlayableCombinations;i++)
            {
            if(playableCombinations[i]->getType()==SINGLE&&playableCombinations[i]->getValue()==j)//Checking if player has a single with j value
            {
                flag=1;//flag becomes 1
                break;
            }
            }
            while(p<v)
            {
            for(k=0;k<numPlayableCombinations;k++)
            {
            if(playableCombinations[k]->getType()!=SINGLE&&playableCombinations[k]->containsCard(temp[p]))//Checking if the card with j value can be played in a combination except for single
            {
            flag=2;//flag becomes 2
            break;
            }
            }
            p++;
            }
            if(flag==1)//If the card can be played only as single we play it(we prefer to play from lower valued to higher valued cards)
                return i;
            }
            }

        flag=0;v=0,p=0;
        if(lastCombinationOnTable->getType()==PAIR)
        {
            v=((1+(lastCombinationOnTable->getValue()))-2)*4;
            p=((1+(lastCombinationOnTable->getValue()))-2)*4;
        for(j=(1+lastCombinationOnTable->getValue());j<14;j++)
        {
            v+=4;
            for(i=0;i<numPlayableCombinations;i++)
            {
            if(playableCombinations[i]->getType()==PAIR&&playableCombinations[i]->getValue()==j)//Checking if player has a pair with j value
            {
                flag=1;//flag becomes 1
                break;
            }
            }
            while(p<v)
            {
            for(k=0;k<numPlayableCombinations;k++)
            {
            if((playableCombinations[k]->getType()!=PAIR&&playableCombinations[k]->getType()!=SINGLE)&&playableCombinations[k]->containsCard(temp[p]))//Checking if the 2 cards with j value can be played in a combination except for single and pair
            {
            flag=2;//flag becomes 2
            break;
            }
            }
            p++;
            }
            if(flag==1)//If the 2 cards can be played only as a pair(except for single) we play it(we prefer to play from lower valued to higher valued cards)
                return i;
        }
        }

            if((lastCombinationOnTable->getType()==SINGLE||lastCombinationOnTable->getType()==PAIR)&&(lastCombinationOnTable->getValue()>9))//If the type of the last combination on the table is single or pair
            {                                                                                                                             //and its value is 10 or more and the only playable combination is with
                for(i=0;i<numPlayableCombinations;i++)                                                                                    //ace we play it
                {
                    if(playableCombinations[i]->getValue()==14)
                        return i;
                }
            }
        flag=0,v=0,p=0;
        if(lastCombinationOnTable->getType()==THREEOFAKIND)
        {
            v=((1+(lastCombinationOnTable->getValue()))-2)*4;
            p=((1+(lastCombinationOnTable->getValue()))-2)*4;
        for(j=(1+lastCombinationOnTable->getValue());j<14;j++)
        {
            v+=4;
            for(i=0;i<numPlayableCombinations;i++)
            {
            if(playableCombinations[i]->getType()==THREEOFAKIND&&playableCombinations[i]->getValue()==j)//Checking if player has a threeofakind with j value
            {
                flag=1;//flag becomes 1
                break;
            }
            }
            while(p<v)
            {
            for(k=0;k<numPlayableCombinations;k++)
            {
            if(((playableCombinations[k]->getType()!=PAIR&&playableCombinations[k]->getType()!=SINGLE)&&playableCombinations[k]->containsCard(temp[p]))&&playableCombinations[k]->getType()!=THREEOFAKIND)//Checking if the 3 cards with j value can be played
            {                                                                                                                                                                                       //in a combination except for single,pair and threeofakind
            flag=2;//flag becomes 2
            break;
            }
            }
            p++;
            }
            if(flag==1)//If the 3 cards can be played only as threeofakind(except for single and pair) we play it(we prefer to play from lower valued to higher valued cards)
                return i;
        }
        }
        if(lastCombinationOnTable->getType()==THREEOFAKIND&&lastCombinationOnTable->getValue()==13)//If the type of the last combination on the table is Threeofakind and its value is 13 and the only playable combinaton(except for bombs) is with ace we play it
        {
            for(i=0;i<numPlayableCombinations;i++)
                {
                    if(playableCombinations[i]->getValue()==14)
                        return i;
                }
        }

        if(lastCombinationOnTable->getType()==STAIRS)
        {
            for(j=(1+lastCombinationOnTable->getValue());j<15;j++)
        {
            for(i=0;i<numPlayableCombinations;i++)
            {
                if(playableCombinations[i]->getType()==STAIRS&&playableCombinations[i]->getValue()==j)//Checking if player has stairs with j value
                    return i;
            }
        }
        }


        if(lastCombinationOnTable->getType()==STRAIGHT)
        {
            for(j=(1+lastCombinationOnTable->getValue());j<15;j++)
        {
            for(i=0;i<numPlayableCombinations;i++)
            {
                if(playableCombinations[i]->getType()==STRAIGHT&&playableCombinations[i]->getValue()==j)//Checking if player has straight with j value
                    return i;
            }
        }
        }

        if(lastCombinationOnTable->getType()==FULLHOUSE)
        {
                for(j=100+(lastCombinationOnTable->getValue());j<1400;j+=100)
        {
            for(i=0;i<numPlayableCombinations;i++)
            {
                if(playableCombinations[i]->getType()==FULLHOUSE&&(playableCombinations[i]->getValue()>j&&playableCombinations[i]->getValue()<100+j))//Checking if player has fullhouse with value bigger than j(as close as we can to the value of last combination)
                    return i;
            }
        }
        }



    }
    }

    return 0;
}

void SmartPlayer::watch(Table* table, PlayerStatus* playerStatuses, int* numberOfCardsPerPlayer){
    // TODO: This function is optional. It is called whenever the player cannot play in order to watch the game.
    /// Use this to watch what cards/combinations are played, or just simply leave it empty.
}
