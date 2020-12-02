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
        var emojiTheme = themes.randomElement()!
        emojiTheme.emojiCards.shuffle()
        let emojis = emojiTheme.emojiCards
        return MemoryGame<String>(theme: emojiTheme, score: 0) { pairIndex in
            return emojis[pairIndex]
        }
    }
        
    // MARK: - Access to the the Model
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    var themeName: String {
        model.theme.name
    }
    
    var themeColor: Color {
        model.theme.cardColor
    }
    
    var score: Int {
        model.score
    }
    
    // MARK: - Intent(s)
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
    func newGame() {
        model = EmojiMemoryGame.createMemoryGame()
    }
}

struct EmojiMemoryGame_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
