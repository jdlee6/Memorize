//
//  Cardify.swift
//  Memorize
//
//  Created by Joe Lee on 12/4/20.
//  Copyright © 2020 Joe Lee. All rights reserved.
//

import SwiftUI

// A modifier that can create another modifier with animation
// protocols 'ViewModifier' & 'Animatable' in 1
struct Cardify: AnimatableModifier {
    var rotation: Double
    
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    // define animatableData (required by protocol Animatable)
    // we are animating the rotation which is a double
    // this is the name that the Animatable protocol is looking for
    var animatableData: Double {
        get { return rotation }
        set { rotation = newValue }
    }
    
    // isFaceUp is true if rotation is less than 90
    var isFaceUp: Bool {
        rotation < 90
    }
    
    func body(content: Content) -> some View {
        ZStack {
            // when its face down we won't be able to see this grouped view
            Group {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                content // text is always on screen
            }
                .opacity(isFaceUp ? 1 : 0) // if face up, fully opaque
            RoundedRectangle(cornerRadius: cornerRadius).fill()
                .opacity(isFaceUp ? 0 : 1)
            }
            .rotation3DEffect(Angle.degrees(rotation), axis: (0,1,0))
      }
    
    private let cornerRadius: CGFloat = 10
    private let edgeLineWidth: CGFloat = 3
}


extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
