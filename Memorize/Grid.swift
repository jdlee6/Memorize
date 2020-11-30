//
//  Grid.swift
//  Memorize
//
//  Created by Joe Lee on 9/30/20.
//  Copyright © 2020 Joe Lee. All rights reserved.
//

import SwiftUI

struct Grid<Item, ItemView>: View where Item: Identifiable, ItemView: View {
    var items: [Item]
    var viewForItem: (Item) -> ItemView
    
    init(_ items: [Item], viewForItem: @escaping (Item) -> ItemView) {
        self.items = items
        self.viewForItem = viewForItem
    }
    
    var body: some View {
        GeometryReader { geometry in
            // Pass the GridLayout now instead of this size
            self.body(for: GridLayout(itemCount: self.items.count, in: geometry.size))
        }
    }
    
    // Change these params. from 'size' to 'layout'
    func body(for layout: GridLayout) -> some View {
        ForEach(items) { item in
            self.body(for: item, in: layout)
        }
    }
    
    func body(for item: Item, in layout: GridLayout) -> some View {
        let index = items.firstIndex(matching: item)! // force unwrap the optional here
        return viewForItem(item)
                .frame(width: layout.itemSize.width, height: layout.itemSize.height)
                .position(layout.location(ofItemAt: index))
    }
}

