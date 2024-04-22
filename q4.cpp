/*

Question 4
Colter Snyder

Methodology:
    Started this question by analyzing all the pointer types in this function.
    Given player is a pointer from mappedPlayerNames in the Game class, we do not 
      want to delete that pointer as it will mess up other parts of the code that 
      rely on that pointer.
    Given item is a new created item that should remain persistant beyond
      this function, we do not want to delete this pointer.
    We do create a new player that is potentially not used on line .
    If line  turns out true, the function is returned from, leaving this
      new player still allocated, thus we must delete it before this
      happens.

*/

void Game::addItemToPlayer(const std::string& recipient, uint16_t itemId)
{
    Player* player = g_game.getPlayerByName(recipient);
    if (!player) {
        player = new Player(nullptr);
        if (!IOLoginData::loadPlayerByName(player, recipient)) {
            // This player does not exist
            // Delete the new player we just created before returning
            delete player;
            return;
        }
        // Add player to game for future use and to prevent pointer
        //   dublication in future calls of this function
        g_game.addPlayer(player)
    }

    Item* item = Item::CreateItem(itemId);
    if (!item) {
        // No need to delete, item already is nullptr
        return;
    }

    g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER, FLAG_NOLIMIT);

    if (player->isOffline()) {
        IOLoginData::savePlayer(player);
    }
}