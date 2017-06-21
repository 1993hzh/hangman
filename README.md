# Project background:
[Hangman Game](https://en.wikipedia.org/wiki/Hangman_(game))

# Project aim:
Write code to play Hangman game automatically and perform well based on different strategy.

# Project achievement:
With given 1000 words, program accuracy is around 97% and 2.9 wrong count per word that had been guessed out.

# Project structure:
Game
Guesser
GuessStrategy
WordProvider

# Strategy details:
### Frequency based:
This strategy is from [Letter frequency](https://en.wikipedia.org/wiki/Letter_frequency)
1. return the letter one by one
2. it performs much better than dictionary based strategy when word length is less than 5 and guessed letter size is less than 3
3. when dictionary cannot find the word pattern, this strategy will take over

### Dictionary based:
This strategy is from a word sample which I called as dictionary, obiviously, how it performs decides on how much it can meet word provider's word sample.
1. generate a dictionary set in memory
2. give one word, filter out a word set from super word set(dictionary when first accessed) based on the pattern, for example, given 'wo*d', the pattern should be '^wo.d$'
3. calculate letter frequency of filtered word set and order by frequency desc
4. return the letter in step 3 one by one
5. if the word given has been changed in one game, then repeat step 2-4
