# Pac-Man v2 — ATmega128L AVR Assembly

A Pac-Man-inspired game developed in AVR Assembly for the **ATmega128L** microcontroller board.

The game runs on an 8×8 **WS2812B LED matrix**, uses an **LCD 2×16** to display the menu and score, a **PS/2 keyboard** for menu navigation, push buttons for player movement, and the internal **EEPROM** to store high scores.

## Authors

- Pauline De Baets & Stanislas Dupanloup

## Date
Spring 2025

## Project overview

The application allows the user to play a small Pac-Man-style game with two consecutive maze levels.

The player must move through the maze, collect bonuses, avoid or eat enemies, and reach the green exit. After completing the first level, the game automatically starts a second, harder level. When the second level is completed, a green check mark is displayed on the LED matrix.

The current score is shown on the LCD during gameplay. At the end of the game, the score is compared with the stored high score of the selected player profile. If the new score is higher, it is saved in EEPROM.

## Main features

- Player selection menu with 4 profiles
- Two playable maze levels
- Real-time score display on LCD
- Enemy movement controlled by Timer0 interrupts
- Bonus collection system
- Special bonus allowing the player to eat enemies
- EEPROM-based high-score storage
- Victory animation on the LED matrix
- Reset option during gameplay

## Hardware used

| Peripheral | Port | Purpose |
|---|---|---|
| WS2812B LED matrix | Port D | Displays the maze, player, enemies, bonuses, exit, and victory screen |
| PS/2 keyboard | Port F | Selects the player profile and controls the menu |
| LCD 2×16 | Port C | Displays menu text, current score, final score, and high score |
| Push buttons | Port B | Controls player movement |
| Internal EEPROM | — | Stores high scores for each player profile |

## Controls

### Menu

| Input | Action |
|---|---|
| `1`, `2`, `3`, `4` on PS/2 keyboard | Select player profile |
| `Space` | Start the game / return to menu after the end screen |

### Gameplay

| Input | Action |
|---|---|
| Push button 1 | Move right |
| Push button 2 | Move left |
| Push button 3 | Move up |
| Push button 4 | Move down |
| Push button 8 | Reset the game and return to player selection |

## Color code

| Color | Meaning |
|---|---|
| Yellow | Player |
| Red | Enemy |
| Purple | Maze wall |
| Turquoise | Bonus worth 1 point |
| Blue | Special bonus: gives the power to eat enemies |
| Green | Exit / victory display |

## Game rules

The goal is to leave the maze while collecting as many points as possible.

- The player gains points by collecting bonuses.
- The green LED represents the exit.
- Touching an enemy normally kills the player and resets the level and score.
- Collecting the blue special bonus puts the player in a special state.
- In the special state, the player can eat enemies and gain points.
- After completing level 1, the player enters level 2.
- After completing level 2, the game ends and displays a green check mark.

## Software architecture

The program follows a modular, top-down structure. The main file initializes the peripherals, includes the required modules, and controls the global execution flow.

The application is organized around a finite state machine with three main modes:

1. **Player selection mode**
   - The user selects one of four profiles.
   - The LCD displays a welcome message and the stored high score.

2. **Game mode**
   - The player moves through level 1 and level 2.
   - The LED matrix is updated continuously.
   - Enemy movement is handled periodically through Timer0.

3. **End mode**
   - The final score is displayed.
   - The high score is updated in EEPROM if necessary.
   - The user can return to the player selection menu.

## Main modules

| File / module | Role |
|---|---|
| `main_final.asm` / `main.asm` | Main program, initialization, state machine, reset vector, interrupt setup |
| `leds_macro.asm` | LED initialization, color detection, entity display, game state updates |
| `leds_sous_routines.asm` | Low-level WS2812B display routines |
| `mouvement_macro.asm` | Player and enemy movement macros, collision detection |
| `mode_sous_routine.asm` | Player welcome screen, game mode, end mode routines |
| `common_keyboard.asm` | Keyboard code interpretation |
| `macro_keyboard.asm` | PS/2 keyboard detection macros |
| `sousroutine_keyboard.asm` | Byte detection from the keyboard |
| `routines_initiation.asm` | Initialization of SRAM variables, EEPROM, and pointers |
| `eeprom_load_score.asm` | Loading, comparing, displaying, and storing high scores |
| `lcd.asm` | LCD routines |
| `printf.asm` | Formatted LCD printing |
| `definitions.asm` | Register and constant definitions |
| `macros.asm` | General macros |

## Important implementation details

- The LED matrix state is stored in SRAM in a 192-byte memory zone named `niveau`, corresponding to 64 LEDs with 3 RGB bytes each.
- Each entity, including the player, enemies, bonuses, and special bonus, has its own position and state.
- Collision detection is based on reading the RGB color of the target LED before moving.
- Timer0 is used to move enemies periodically, using overflow interrupts.
- EEPROM stores one high score per player profile, with one byte per score.

## References

- ATmega128L datasheet
- WS2812B datasheet
- A. Schmid and R. Holzer, *Microcontrôleurs : théorie et pratique de l’AVR*, EPFL Press / Presses polytechniques et universitaires romandes, 2022.
