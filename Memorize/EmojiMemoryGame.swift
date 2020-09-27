//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Joe Lee on 9/26/20.
//  Copyright © 2020 Joe Lee. All rights reserved.
//

import SwiftUI

class EmojiMemoryGame {
    private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    static func createMemoryGame() -> MemoryGame<String> {
        // Task: Start game between random # between 2 and 5 pairs
        let emojis: Array<String> = ["🎃", "👻", "🕸", "👼🏻", "🤩"]
        let randomNumberOfPairsOfCards: Int = Int.random(in: 2...emojis.count)
        return MemoryGame<String>(numberOfPairsOfCards: randomNumberOfPairsOfCards) { pairIndex in
            return emojis[pairIndex]
        }
    }
        
    // MARK: - Access to the the Model
    var cards: Array<MemoryGame<String>.Card> {
        // Task: Shuffle the cards
        return model.cards.shuffled()
    }
    
    // MARK: - Intent(s)
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
}

struct EmojiMemoryGame_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
