# Hangman (CLI)

**To play the game visit [replit](https://replit.com/@adrian-y1/TOPHangman) and run `ruby lib/hangman.rb` inside the terminal.**

This Hangman game is a command-line interface (CLI) game implemented using Ruby 3.1. It is a single-player game where the player attempts to guess a randomly selected secret word by guessing one letter at a time. The player has a limited number of guesses (6) before the game ends. This project was part of [The Odin Project's Ruby course.](https://www.theodinproject.com/lessons/ruby-hangman)

<img alt="Hangman gif" src="demo/hangman.gif"><br>
*A GIF demonstration of the Hangman game*

## Overview
Hangman is a classic word-guessing game, and in this Ruby CLI implementation, players have the opportunity to play against the computer. The game begins with the computer randomly selecting a word from a document, and the player must guess one letter at a time to try to uncover the word.

For each incorrect guess, the user loses a life. The player must guess the word before they lose 6 lives, or they will lose the game.

This game has been implemented with features such as checking for valid inputs, displaying the current state of the game, and allowing the player to save a game and load a saved game.

## How To Play
- Online
  - To play online visit the link at the top of this document or click [here](https://replit.com/@adrian-y1/TOPHangman)
  - Press `Run` and then enter `ruby lib/hangman.rb` inside the teminal to begin the game.
- Local
  - To play locally, you must first install [Ruby](https://www.ruby-lang.org/en/)
  - After that, [clone](https://github.com/git-guides/git-clone) this [repository](https://github.com/adrian-y1/TOPHangman)
  - To start the game, enter `ruby lib/hangman.rb` in the terminal

## Features
- Single-player game
- Limited Guesses (6 lives)
- Interactive gameplay through command-line interface
- Saving a game
- Loading a saved game
- Error handling for invalid inputs
- Display of correct & incorrect guesses
- Progress displayed after each guess

## Difficulties 
Throughout the development process of this Hangman CLI game with Ruby, there were not many major challenges. However, one difficulty that arose was related to the implementation of a feature to load a previously saved game. Initially, I struggled to figure out how to implement this feature as it involved handling file input/output and serialization in Ruby as it was still a relatively new concept for me.

## Overcoming Difficulties
To overcome the difficulty of loading a saved game, I researched more about file input/output and serialization with Ruby. I carefully read through the Ruby documentation and various online resources to gain a better understanding of how these concepts work. Eventually, I was able to implement the feature successfully by using the YAML module in Ruby to serialize and deserialize the game data to and from a file.

With this solution in place, users can now save their current game state and resume the game at a later time.

## Conclusion
Creating this Hangman game using Ruby was a great learning experience for me. One of the main takeaways was my enhanced understanding of file handling and serialization in Ruby. With this knowledge i was able to create other projects that used the save/load a game functionality, such as [Chess.](https://github.com/adrian-y1/TOPChess)