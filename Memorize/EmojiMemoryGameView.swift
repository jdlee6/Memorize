//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Joe Lee on 9/1/20.
//  Copyright © 2020 Joe Lee. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame

    var body: some View {
        HStack {
            ForEach(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    self.viewModel.choose(card:card)
                }
                     // Task: Ratio 2:3
                    .aspectRatio(0.66, contentMode: .fit)
            }
        }
            .padding()
            .foregroundColor(Color.orange)
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    // Clean Code Notes:
    // Specific the floats & integers
    // We should instead create a control panel to fine tune these args.
    var body: some View {
        // Anything in the GeometryReader & ForEach view will ALWAYS complain about missing the 'self.'
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    // this function will return our body which is of type 'some View'
    // now you can remove the 'self.'
    // NOTE: Do this until Swift gets rid of this 'self.' error
    func body(for size: CGSize) -> some View {
        ZStack {
              if card.isFaceUp {
                  RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                  RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                  Text(card.content)
              } else {
                  RoundedRectangle(cornerRadius: cornerRadius).fill()
              }
          }
        // NOTE: 'for' is the external param. and 'size' is the internal param.
        .font(Font.system(size: fontSize(for: size)))
    }
    
    // MARK: - Drawing Constants
    // Place to define vars & lets in your Struct
    // The reason they're placed down here is to make the main 'body' look as CLEAN as possible
    // Explicitly define the types b/c Swift infers the types
    let cornerRadius: CGFloat = 10
    let edgeLineWidth: CGFloat = 3
    // let fontScaleFactor: CGFloat = 0.75
    
    // Refactored into function
    // One liner functions that make the body much more CLEANer is HIGHLY recommended
    func fontSize(for size: CGSize) -> CGFloat {
        // really don't need to define the fontScaleFactor b/c this is the only function that handles that
        min(size.width, size.height) * 0.75
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
