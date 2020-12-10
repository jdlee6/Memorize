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
            Button("New Game", action: {
                // Explicit animation
                withAnimation(.easeInOut(duration: 1)) {
                    self.viewModel.newGame()
                }
            })
            .padding()
            Text(viewModel.themeName)
            Text("\(viewModel.score)") // Text view takes in string
            Grid(viewModel.cards) { card in
                    CardView(card: card).onTapGesture {
                        // Explicit animation for choosing a card
                        withAnimation(.linear(duration: 1)) {
                            self.viewModel.choose(card:card)
                        }
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
        // when neither happens - it transitions out of the view
        if card.isFaceUp || !card.isMatched {
            ZStack {
                // content
                Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(110-90), clockwise: true)
                    .padding(5).opacity(0.4)
                    Text(card.content)
                    .font(Font.system(size: fontSize(for: size)))
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
            }
                .cardify(isFaceUp: card.isFaceUp)
                // Hint: for hw - look at docs and look into .offset
                .transition(AnyTransition.scale)
                // We want the rotation to happen on the vertical y axis
                // It rotates but its fading in the back the emoji of the card
                .rotation3DEffect(Angle.degrees(card.isFaceUp ? 0 : 180), axis: (0,1,0))
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
