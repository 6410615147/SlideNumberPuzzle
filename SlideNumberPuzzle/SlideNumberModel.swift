//
//  SlideNumberModel.swift
//  SlideNumberPuzzle
//
//  Created by Babypowder on 10/2/2567 BE.
//

import Foundation

struct SlideNumberModel<BlockContentType: Equatable> {
    private(set) var blocks: Array<Block>
    private(set) var freeSpaceBlock: Block
    private(set) var count: Int = 0
    
    init(total: Int ,blockContentFactory: (Int) -> BlockContentType){
        blocks = []
        for index in 0..<total {
            let content = blockContentFactory(index)
            blocks.append(Block(content: content, isSpace: index == 0 ? true : false))
        }
        freeSpaceBlock = blocks[0]
        shuffle()
    }
    
    struct Block: Identifiable, Equatable{
        let content: BlockContentType
        let isSpace: Bool
        var isMoveable: Bool = false
        let id = UUID()
    }
    
    private func index(of block: Block) -> Int {
        for index in blocks.indices {
            if blocks[index].id == block.id {
                return index
            }
        }
        return 0;
    }
    
    mutating func choose(block: Block) {
        let chosenIndex = index(of: block)
        if block.isMoveable {
            blocks[index(of: freeSpaceBlock)] = block
            blocks[chosenIndex] = freeSpaceBlock
        }
//        1,2,5     2,1,3,6         3,2,4,7         4,3,8
//        5,6,1,9   6,5,7,2,10      7,6,8,3,11      8,7,4,12
//        9,10,5,13 10,9,11,6,14    11,10,12,7,15   12,11,8,16
//        13,14,9   14,13,15,10     15,14,16,11     16,15,12
        count += 1
        aroundFreeSpaceMoveable()
//        isOrder()
    }
    
    private mutating func imMovable() {
        for i in blocks.indices {
            blocks[i].isMoveable = false
        }
    }
    
    
    
    private mutating func aroundFreeSpaceMoveable() {
        imMovable()
        let freeSpaceIndex = index(of: freeSpaceBlock)
        if (blocks[freeSpaceIndex].isSpace) {
//            case 1: right block can move}
            if (freeSpaceIndex % 4) != 3 {
                blocks[freeSpaceIndex+1].isMoveable = true
            }
//            case 2: left block can move
            if (freeSpaceIndex % 4) != 0 {
                blocks[freeSpaceIndex-1].isMoveable = true
            }
//            case 3: upper block can move
            if (freeSpaceIndex - 4) >= 0 {
                blocks[freeSpaceIndex-4].isMoveable = true
            }
//            case 4: upper block can move
            if (freeSpaceIndex + 4) < 16 {
                blocks[freeSpaceIndex+4].isMoveable = true
            }
        }
        freeSpaceBlock.isMoveable = true
    }
    
    mutating func shuffle() {
        blocks.shuffle()
        aroundFreeSpaceMoveable()
    }
    
    func isOrder() {
        print("isorder")
        let ordered = (0...15).map(String.init) + [""] as! Array<Block>
        if blocks.elementsEqual(ordered){
            print("end")
        }
    }

    
//    method slide, isorder(end)
}
