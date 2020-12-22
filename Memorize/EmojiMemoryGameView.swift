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
                withAnimation(.easeInOut) {
                    self.viewModel.newGame()
                }
            })
            .padding()
            Text(viewModel.themeName)
            Text("\(viewModel.score)")
            Grid(viewModel.cards) { card in
                    CardView(card: card).onTapGesture {
                        withAnimation(.linear(duration: 0.75)) {
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

    // we want this to be synced up everytime this view appears on screen
    @State private var animatedBonusRemaining: Double = 0
    
    private func startBonusTimeAnimation() {
        // sync up the modeland then
        animatedBonusRemaining = card.bonusRemaining
        // animate it ticking down to 0
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
             animatedBonusRemaining = 0
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        // when neither happens - it transitions out of the view
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Group {
                    // if faceup, not matched, bonustime > 0
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-animatedBonusRemaining*360-90), clockwise: true)
                            .onAppear {
                                self.startBonusTimeAnimation()
                            }
                    } else {
                        // dont care when it appears
                        Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-card.bonusRemaining*360-90), clockwise: true)
                    }
                }
                    // Need to Group the Views and then apply the padding here
                    .padding(5).opacity(0.4)
                    Text(card.content)
                    .font(Font.system(size: fontSize(for: size)))
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
            }
                .cardify(isFaceUp: card.isFaceUp)
                // Hint: for hw - look at docs and look into .offset
                .transition(AnyTransition.scale)
        }
    }
        
    // MARK: - Drawing Constants
    // Todo: define constants / args. to modifiers here
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
