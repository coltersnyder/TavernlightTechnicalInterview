# Tavernlight Games Technical Interview - Colter Snyder

## Methodologies:

### Question 1

There wasn't much I could find with this question, however I did notice that the local function did not need to exist as it is only called once. So I changed it into a lambda function to prevent it from being stored and only be created when it needs to be used which, from the title of the function only happens when the player logs out, which will not happen very often. As such, this will not cause  a huge performance hit from this being a lambda function.

### Question 2

Added query sanitization. Makes sure that memberCount is a number before attempting to pass it on to the query. Finally, free the memory used by the result

### Question 3

Added variable checking to this file. Check if playerId and membername exist as players and check if the player has a party.

### Question 4

Started this question by analyzing all the pointer types in this function. Given player is a pointer from mappedPlayerNames in the Game class, we do not want to delete that pointer as it will mess up other parts of the code that rely on that pointer. Given item is a new created item that should remain persistant beyond this function, we do not want to delete this pointer. We do create a new player that is potentially not used on line 25. If line 26 turns out true, the function is returned from, leaving this new player still allocated, thus we must delete it before this happens.

### Question 5

This was an interesting problem to figure out how to start. My first attempt was to use the combat API to recreate the effects. This did not work, however, when trying to do multiple effects one after the other. For this, I found my solution in the sendMagicEffect() call present in Position as this was able to create the desired effect. It is not a 1 to 1 replication of the video, however, as I was having trouble with the positioning and operation of the Ice Tornadoes not wanting to be position in the exact same spots as the video.

### Question 6

This was a somewhat tricky question to solve, with a solution I am not fully happy with. In hindsight, with more time and experience with this game's API, this could likely be more efficiently solved using some sort of shader. However, the methodology I went with involves creating four separate creatures that are clones of the player and placing them behind the player with each clone becoming more transparent the farther behind the player they are. It is not a perfect sollution by any means, but it gets the general idea of the question across.

### Question 7

This was a fun question to try and figure out. It really gave me an understanding of how the UI system in OTClient works. As for the methodology, I didn't deviate too much from how the other UI windows in the OTClient operate beyond using scheduleEvent() in order to move the button from the right side of the screen to the left and getting rid of that buttons anchoring to the window.