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
let starCardColor: Color = .green

struct Theme {
    var name: String
    var emojiCards: Array<String>
    var numberOfCards: Int?
    var cardColor: Color
}

let themes = [animalTheme, sportTheme, vehicleTheme, starTheme]

let animalTheme = Theme(name: "Animals", emojiCards: ["🐨","🐭","🙉","🐔","🦊"], cardColor: animalCardColor)
let sportTheme = Theme(name: "Sports", emojiCards: ["⚾️","🎱","🏐","🏓"], numberOfCards: 4, cardColor: sportCardColor)
let vehicleTheme = Theme(name: "Vehicles", emojiCards: ["🚗","🚕","🚙","🚌"], cardColor: vehicleCardColor)
let starTheme = Theme(name: "Stars", emojiCards: ["⭐️","🌟","✨","💥"], cardColor: starCardColor)

// 🐨🐭🙉🐔🦊 Animal Emojis
// 🏈⚾️🎱🏐🏓 Sport Emojis
// 🚗🚕🚙🚌 Vehicle Emojis
// ⭐️🌟✨💥 Star Themes
