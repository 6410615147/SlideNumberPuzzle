//
//  NumberViewModel.swift
//  SlideNumberPuzzle
//
//  Created by Babypowder on 10/2/2567 BE.
//

import Foundation

class NumberViewModel: ObservableObject {
    static let numbers = [""] + (1...15).map(String.init)
    
    @Published private var model = SlideNumberModel<String>(total: numbers.count) { index in
        numbers[index]
    }
    
    var blocks: [SlideNumberModel<String>.Block] {
        return model.blocks
    }
    
    var count: Int {
        return model.count
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ block: SlideNumberModel<String>.Block) {
        model.choose(block: block)
    }
}
