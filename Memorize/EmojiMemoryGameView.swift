//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Joe Lee on 9/1/20.
//  Copyright © 2020 Joe Lee. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    // viewModel should always be public b/c it is being used in the preview function below
    // and also in SceneDelegate.swift
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        Group {
            Button("New Game", action: viewModel.newGame)
            .padding()
            Text(viewModel.themeName)
            Text("\(viewModel.score)") // Text view takes in string
            Grid(viewModel.cards) { card in
                    CardView(card: card).onTapGesture {
                        self.viewModel.choose(card:card)
                    }
            .padding()
            }
            .padding()
            .foregroundColor(viewModel.themeColor)
        }

    }
}

struct CardView: View {
    // this shouldn't be private b/c we are using it in EmojiMemoryGameView
    // if we made this private then we would be able to pass it as an argument
    var card: MemoryGame<String>.Card
    
    // this shouldn't be private b/c the system is going to call that
    // this is how it gets the body for our View
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }

    // helper function should be private
    private func body(for size: CGSize) -> some View {
        ZStack {
              if card.isFaceUp {
                  RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                  RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                  Text(card.content)
              } else {
                if !card.isMatched {
                    RoundedRectangle(cornerRadius: cornerRadius).fill()
                }
                // Draws nothing if card is matched
              }
          }
        .font(Font.system(size: fontSize(for: size)))
    }
    
    // MARK: - Drawing Constants
    // these should be private since there shouldn't be a reason for anyone to change these
    private let cornerRadius: CGFloat = 10
    private let edgeLineWidth: CGFloat = 3
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.75
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
