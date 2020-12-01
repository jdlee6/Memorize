//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Joe Lee on 9/26/20.
//  Copyright © 2020 Joe Lee. All rights reserved.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    static func createMemoryGame() -> MemoryGame<String> {
        // Task: Fetch emojis as well as # of cards from current theme 
        let emojis: Array<String> = currentTheme.type.emojiCards
        // Task: if 'numberOfCards' is given from the theme, use that if not, then pick a random number of pairs
        if let randomNumberOfPairsOfCards: Int = currentTheme.type.numberOfCards {
            return MemoryGame<String>(numberOfPairsOfCards: randomNumberOfPairsOfCards) { pairIndex in
                return emojis[pairIndex]
            }
        } else {
            return MemoryGame<String>(numberOfPairsOfCards: Int.random(in: 1..<(currentTheme.type.emojiCards.count * 2))) { pairIndex in
                return emojis[pairIndex]
                }
            }
        }
        
    // MARK: - Access to the the Model
    var cards: Array<MemoryGame<String>.Card> {
        // Task: Shuffle the cards
        // model.cards.shuffled()
        model.cards
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
