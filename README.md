RM X Framework
===============

Framework for competitive Age of Mythology random maps, most notably used in the [Voobly Balance Patch](https://github.com/rebelsrising/aom-vbp).

Functionality
------------
* New fair location algorithm with a variety of customization options and fair placement
* New similar location algorithm to atomically place a set of similar locations (w.r.t. strategical position) per pair of opposing players
* Placement tracking to determine whether crucial objects were successfully placed to immediately detect map screws
* Custom player placement functions to allow for advanced placement of objects and areas (e.g., between teams or players)
* Full support for mirrored placement (!) for 1v1 and teamgames
* Enhanced observer commands for Age of Mythology: The Titans to show real-time resources and technologies
* Support for (additional) observers: Spectate games in vanilla Age of Mythology or have multiple additional observers in Age of Mythology: The Titans without corrupting the recorded game
* Support for Merge Mode: Share control over a single civilization with other players (similar to Archon Mode from Starcraft II)
* A whole lot of additional handy features to aid in the creation of competitive random maps 

If you want to learn more about how to use RM X for your own map scripts, make sure you check out the provided map scripts in the `demo` folder as well as the documentation in the `.xs` source files.

Credits
-------
* To SlySherZ for a great data structure for random area generation
* To Loggy for a very nice way for storing and updating tech states for observer mode
* To whoever figured out that it is possible to inject custom triggers
* To Fophuxake for the ideas regarding map reveal and displaying all stats for observers
* To [this](https://old.reddit.com/r/AgeofMythology/comments/bojk9c/my_friends_and_i_found_a_bug_where_two_players/) Reddit post about how "restoring a game with same name will merge the players" (which resulted in the merge mode in this framework)
* To whoever helped me testing and listened to me complain 24/7 while coding
