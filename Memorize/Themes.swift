//
//  Themes.swift
//  Memorize
//
//  Created by Joe Lee on 11/30/20.
//  Copyright © 2020 Joe Lee. All rights reserved.
//

import SwiftUI

let animalCardColor: Color = .gray
let sportCardColor: Color = .blue
let vehicleCardColor: Color = .yellow

struct Theme {
    var name: String
    var emojiCards: Array<String>
    var numberOfCards: Int?
    var cardColor: Color
}

// 🐨🐭🙉🐔🦊 Animal Emojis
// 🏈⚾️🎱🏐🏓 Sport Emojis
// 🚗🚕🚙🚌 Vehicle Emojis
let animalTheme = Theme(name: "Animals", emojiCards: ["🐨","🐭","🙉","🐔","🦊"], cardColor: animalCardColor)
let sportTheme = Theme(name: "Sports", emojiCards: ["⚾️","🎱","🏐","🏓"], numberOfCards: 4, cardColor: sportCardColor)
let vehicleTheme = Theme(name: "Vehicles", emojiCards: ["🚗","🚕","🚙","🚌"], cardColor: vehicleCardColor)

// Create an enum, cardTheme, which has a case for each theme I created
internal enum colorTheme: CaseIterable {
    case animal, sport, vehicle
    
    var type: Theme {
        switch self {
        case .animal:
            return animalTheme
        case .sport:
            return sportTheme
        case .vehicle:
            return vehicleTheme
        }
    }
}

var currentTheme: colorTheme = colorTheme.allCases.randomElement()!
