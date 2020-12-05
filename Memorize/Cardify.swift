//
//  Cardify.swift
//  Memorize
//
//  Created by Joe Lee on 12/4/20.
//  Copyright © 2020 Joe Lee. All rights reserved.
//

import SwiftUI // View modifiers are a UI thing

struct Cardify: ViewModifier {
    var isFaceUp: Bool
    
    // content refers to whatever View that we're mutating
    func body(content: Content) -> some View {
        ZStack {
            if isFaceUp {
              RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
              RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
              content // this is where content will be displayed
            } else {
                // Matching should not be within this cardify view
                // That way this can this 'Cardify' modifier can be used for other things
                RoundedRectangle(cornerRadius: cornerRadius).fill()
            }
          }
    }
    // these should be private since there shouldn't be a reason for anyone to change these
    private let cornerRadius: CGFloat = 10
    private let edgeLineWidth: CGFloat = 3
}


extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
