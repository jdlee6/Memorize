//
//  Array+Idenfiable.swift
//  Memorize
//
//  Created by Joe Lee on 11/28/20.
//  Copyright © 2020 Joe Lee. All rights reserved.
//

import Foundation

extension Array where Element: Identifiable {
    // returns an Optional Int may allow us to return nil
    func firstIndex(matching: Element) -> Int? {
        for index in 0..<self.count {
            if self[index].id == matching.id {
                return index
            }
        }
        return nil
    }
}
