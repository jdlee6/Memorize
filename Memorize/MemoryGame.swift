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
        // property observers
        var isFaceUp: Bool = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        var isMatched: Bool = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        var content: CardContent
        var id: Int
    
        // MARK: - Bonus Time
        
        // this could give matching bonus points
        // if the user matches the card
        // before a certain amount of time passes during which the card is face up
        
        // can be zero which means "no bonus available" for this card
        var bonusTimeLimit: TimeInterval = 6
        
        //how long this card has ever been face up
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        // the last time this card was turned face up (and is still face up)
        var lastFaceUpDate: Date?
        // the accumulated time this card has been face up in the past
        // (i.e. not including the current time it's been face up if it is currently so)
        var pastFaceUpTime: TimeInterval = 0
        
        // how much time left before the bonus opportunity runs out
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        // percentage of the bonus time remaining
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit : 0
        }
        // whether the card was matched during the bonus time period
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }
        // whether we are currently face up, unmatched and have not yet used up the bonus window
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
        // called when the card transitions to face up state
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        // called when the card goes back face down (or gets matched)
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            self.lastFaceUpDate = nil
        }
    }
}
