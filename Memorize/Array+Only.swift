//
//  Array+Only.swift
//  Memorize
//
//  Created by Joe Lee on 11/29/20.
//  Copyright © 2020 Joe Lee. All rights reserved.
//

import Foundation

extension Array {
    var only: Element? {
        // 'count' is a special kw
        // number of elements in the array
        // 'first' is a special kw
        // Example: array.count or array.first
        count == 1 ? first : nil
    }
}
