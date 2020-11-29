//
//  Array+Idenfiable.swift
//  Memorize
//
//  Created by Joe Lee on 11/28/20.
//  Copyright © 2020 Joe Lee. All rights reserved.
//

import Foundation

// we have an array of things aka cards w/ strings that are of type Identifiable
// and we want to look inside to find them
// This is where we can implement an extension

// Arrays that don't have elements that are of type identifiable can NOT access this function
extension Array where Element: Identifiable {
    func firstIndex(matching: Element) -> Int {
        for index in 0..<self.count {
            if self[index].id == matching.id {
                return index
            }
        }
        return 0 // Todo: bogus
    }
}
