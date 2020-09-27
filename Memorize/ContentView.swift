//
//  ContentView.swift
//  Memorize
//
//  Created by Joe Lee on 9/1/20.
//  Copyright © 2020 Joe Lee. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var viewModel: EmojiMemoryGame

    var body: some View {
        HStack {
            ForEach(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    self.viewModel.choose(card:card)
                }
                // Task: Ratio 2:3
                .frame(width: 40, height: 60)
            }
        }
            .padding()
            .foregroundColor(Color.orange)
            // Task: if 5 pairs of cards -> change font size
            .font(viewModel.cards.count == 10 ? Font.body: Font.largeTitle)
    }
}



struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
                RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 3)
                Text(card.content)
            } else {
                RoundedRectangle(cornerRadius: 10.0).fill()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: EmojiMemoryGame())
    }
}
