//
//  GameModel.swift
//  FindNumber_icodeschool
//
//  Created by Maxim M on 25.01.2022.
//

import Foundation

enum StatusGame{
    case start
    case win
}

class Game{
    
    struct Item{
        var title: String
        var isFound: Bool = false
    }
    
    private let dataNumbers = Array(1...99)
    var itemsButtons: [Item] = []
    private var countItems: Int
    var nextItem: Item?
    var status: StatusGame = .start
    
    init(countItems: Int){
        self.countItems = countItems
        setupGame()
    }
    
    
    private func setupGame() {
        var digits = dataNumbers.shuffled()
        
        while itemsButtons.count < countItems {
            let item = Item(title: String(digits.removeFirst()))
            itemsButtons.append(item)       // создали цифры для кнопок
        }
        
        nextItem = itemsButtons.shuffled().first    //рандомим цифры, которые будут выводиться на кнопках
    }
 
    func check(index: Int){
        
        if itemsButtons[index].title == nextItem?.title {
            itemsButtons[index].isFound = true
            nextItem = itemsButtons.shuffled().first(where: { (item) -> Bool in
                item.isFound == false
            })
        }
        if nextItem == nil {
            status = .win
        }
    }
    
}
