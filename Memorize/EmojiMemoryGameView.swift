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
//            Button("New Game", action: viewModel.newGame)
//            .padding()
//            Text(viewModel.themeName)
//            Text("\(viewModel.score)") // Text view takes in string
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
    var card: MemoryGame<String>.Card

    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }

    private func body(for size: CGSize) -> some View {
        ZStack {
              if card.isFaceUp {
                  RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                  RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(110-90), clockwise: true)
                    .padding(5).opacity(0.4)
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
        min(size.width, size.height) * 0.7
    }
}

// We can tweak this so that the 1st card can be previewed as face up
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[0])
        return EmojiMemoryGameView(viewModel: game)
    }
}
