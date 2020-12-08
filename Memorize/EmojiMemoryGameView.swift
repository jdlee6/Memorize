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
    var card: MemoryGame<String>.Card

    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                // content
                Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(110-90), clockwise: true)
                    .padding(5).opacity(0.4)
                    Text(card.content)
                    .font(Font.system(size: fontSize(for: size)))
                    // rotate card 180 degrees on a match
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    // to animate it, we will do it IMPLICITLY (but ONLY animates 1 of the cards)
                    // in order to prevent the animation to start from a new game
                // we will make it so it only shows this when the card is matched
                    // .default is used to state NOT to use the animation
                    .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
            }
                .cardify(isFaceUp: card.isFaceUp)
        }
    }
        
    // MARK: - Drawing Constants
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
