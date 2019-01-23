# Boggle

A solution to the 4x4 'boggle' puzzle.

## Installation

First, install a dictionary.

On Debian/Ubuntu, you can install an American English dictionary using
`sudo apt-get install wamerican`.

The dictionary will then be located at /usr/share/dict/words.

To simulate a round of the game:
```elixir
Boggle.play()
```

See the Boggle.solve() doctest for an example of the API.
