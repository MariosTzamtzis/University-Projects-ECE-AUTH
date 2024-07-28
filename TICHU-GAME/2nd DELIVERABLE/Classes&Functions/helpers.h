#ifndef HELPERS_H
#define HELPERS_H

#include "player.h"

/**
 * Function that returns the number of players that have have no cards left.
 *
 * @param players the players of the game as an array with four elements.
 * @return the number of players that have no cards left.
 */
int numberOfPlayersThatHaveNoCardsLeft(Player players[]);

/**
 * Function that checks whether the last three players have passed or have no cards left.
 *
 * @param players the players of the game as an array with four elements.
 * @param playerTurn the turn of the game, which indicates which player is the next to play,
 *                   and is an integer with values 0, 1, 2 or 3
 * @return true if all other players apart from the current playing one have passed or have
 *         no cards left, or false otherwise.
 */
bool lastThreePlayersPassedOrHaveNoCardsLeft(Player players[], int playerTurn);

#endif // HELPERS_H
