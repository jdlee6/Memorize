//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Joe Lee on 9/26/20.
//  Copyright © 2020 Joe Lee. All rights reserved.
//

import SwiftUI

class EmojiMemoryGame {
    // in a class, you can NOT use any variables/functions until they are initialized
    private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    // static functions - creates a function on this type (EmojiMemoryGame)
    // instead of this function to an instance of MemoryGame we send it to the type
    static func createMemoryGame() -> MemoryGame<String> {
        let emojis: Array<String> = ["🎃", "👻", "🕸"]
        return MemoryGame<String>(numberOfPairsOfCards: emojis.count) { pairIndex in
            return emojis[pairIndex]
        }
    }
        
    // MARK: - Access to the the Model
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK: - Intent(s)
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
}
