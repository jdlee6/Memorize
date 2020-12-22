//
//  Pie.swift
//  Memorize
//
//  Created by Joe Lee on 12/3/20.
//  Copyright © 2020 Joe Lee. All rights reserved.
//

import SwiftUI

// Shape protocol already has the Animatable Protocol apart of it
struct Pie: Shape {
    // need to create angles
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool = false
    
    // we will be animating the Angle
    // we want to animate 2 things (startAngle and endAngle) at once so we will use the AnimatablePair protocol
    var animatableData: AnimatablePair<Double, Double> {
        get {
            AnimatablePair(startAngle.radians, endAngle.radians)
        } set {
            startAngle = Angle.radians(newValue.first)
            endAngle = Angle.radians(newValue.second)
        }
    }
    
    // rect is the area where we are supposed to fit our shape
    // space offered to it
    func path(in rect: CGRect) -> Path {
        // rect.midX .midY is the center of each x and y axis
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        // this is the center point of the top of the circle
        let start = CGPoint (
            x: center.x + radius * cos(CGFloat(startAngle.radians)),
            y: center.y + radius * sin(CGFloat(startAngle.radians))
        )
        var p = Path()
        
        // call functions to draw the line here
        // let's go to the middle first
        // then we need to go around our emoji and make the circle
        // now we need to draw the line back to the center of the circle
        p.move(to: center)
        p.addLine(to: start)
        p.addArc(
            center: center,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: clockwise
        )
        p.addLine(to: center)
        return p
    }
}
