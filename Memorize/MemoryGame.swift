//
//  MemoryGame.swift
//  Memorize
//
//  Created by Joe Lee on 9/26/20.
//  Copyright © 2020 Joe Lee. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    // we could make our cards private
    // reason why is b.c we don't want anyone else to mess with these cards
    // ie: manually setting .isMatched or .isFaceUp values
    private(set) var cards: Array<Card>
    var theme: Theme
    var score: Int
    var seenCards = [CardContent]()

    // access control can also be used for functions and internal variables
    // private logic
    // if exposed it can mess up our logic
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            cards.indices.filter { cards[$0].isFaceUp }.only
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    // this shouldn't be private b.c this is how people play the game
    mutating func choose(card: Card) {
        print("card chosen: \(card)")
        // Case: if card is face down and not matched
        if let chosenIndex: Int = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    
                    // Increment score by 2 when match occurs
                    score += 2
                    // Remove these cards from seenCards
                    let newCards = seenCards.filter {$0 != cards[chosenIndex].content}
                    // Update seenCards without the match
                    seenCards = newCards
                    
                } else if cards[potentialMatchIndex].content != cards[chosenIndex].content  {
                    let seenCard = cards[potentialMatchIndex].content
                    seenCards.append(seenCard)
                    
                    // if chosen card is already in the seenCards, deduce by 1
                    if seenCards.contains(cards[potentialMatchIndex].content) {
                        score -= 1
                    }
                }
                self.cards[chosenIndex].isFaceUp = true
            // Case: 0 or more than 1 card -> turn all the cards face down EXCEPT the one we chose
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
    }
    
    // Intialize the model with a theme
    init(theme: Theme, score: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        // Case: numberOfCards arg. is given
        if let pairOfcards = theme.numberOfCards {
            for pairIndex in 0..<pairOfcards {
                let content = cardContentFactory(pairIndex)
                cards.append(Card(content: content, id: pairIndex * 2))
                cards.append(Card(content: content, id: pairIndex * 2 + 1))
            }
        } else {
            // Case: numberOfCards arg is not given
            let pairOfCards = theme.emojiCards.count
            for pairIndex in 0..<pairOfCards {
                let content = cardContentFactory(pairIndex)
                cards.append(Card(content: content, id: pairIndex * 2))
                cards.append(Card(content: content, id: pairIndex * 2 + 1))
            }
        }
        // Task: Shuffle cards
        cards.shuffle()
        self.theme = theme
        self.score = score
    }
    
    // this doesn't need to be private b/c it's being used in 'cards' as Array<Card> which is a private(set)
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}
