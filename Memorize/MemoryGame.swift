//
//  MemoryGame.swift
//  Memorize
//
//  Created by Joe Lee on 9/26/20.
//  Copyright © 2020 Joe Lee. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    var cards: Array<Card>
    var theme: Theme
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            cards.indices.filter { cards[$0].isFaceUp }.only
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    mutating func choose(card: Card) {
        print("card chosen: \(card)")
        // Case: if card is face up and not matched
        if let chosenIndex: Int = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                self.cards[chosenIndex].isFaceUp = true
            // Case: 0 or more than 1 card -> turn all the cards face down EXCEPT the one we chose
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
    }
    
    // Intialize the model with a theme
    init(theme: Theme, cardContentFactory: (Int) -> CardContent) {
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
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}
