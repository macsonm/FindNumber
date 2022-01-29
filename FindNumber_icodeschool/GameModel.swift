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
    case lose
}

class Game{
    
    struct Item{
        var title: String
        var isFound: Bool = false
        var isError = false
    }
    
    private let dataNumbers = Array(1...99)
    var itemsButtons: [Item] = []
    private var countItems: Int
    var nextItem: Item?
    
    var isNewRecord = false
    
    var status: StatusGame = .start{
        didSet{
            if status != .start{
                if status == .win {
                    let newRecord = timerForGame - secondsGame
                    
                    let record = UserDefaults.standard.integer(forKey: KeysUserDefaults.recordGame)
                    
                    if record == 0 || newRecord < record {
                        UserDefaults.standard.setValue(newRecord, forKey: KeysUserDefaults.recordGame)
                        isNewRecord = true
                    }
                }
                
                stopGame()
            }
        }
    }
   
    private var timerForGame: Int
    private var secondsGame: Int{
        didSet{
            if secondsGame == 0 {
                status = .lose
            }
            updateTimer(status,secondsGame)
        }
    }
    private var timer: Timer?
    private var updateTimer:((StatusGame,Int)->Void)
    
    init(countItems: Int, updateTimer: @escaping (_ status: StatusGame,_ seconds: Int) -> Void){
        self.countItems = countItems
        self.timerForGame = Settings.shared.currentSettings.timeForGame
        self.secondsGame = self.timerForGame
        self.updateTimer = updateTimer
        
        setupGame()
    }
    
    
    private func setupGame() {
        isNewRecord = false
        var digits = dataNumbers.shuffled()
        itemsButtons.removeAll()        //очистка номерков для кнопочек
        while itemsButtons.count < countItems {
            let item = Item(title: String(digits.removeFirst()))
            itemsButtons.append(item)       // создали цифры для кнопок
        }
        
        nextItem = itemsButtons.shuffled().first    //рандомим цифры, которые будут выводиться на кнопках
        updateTimer(status,secondsGame)
        
        if Settings.shared.currentSettings.timerState{
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true
                                         , block: { [weak self] (_) in
                self?.secondsGame -= 1
                print("Timer")
            })
        }
        
    }
 
    func newGame(){
        status = .start
        self.secondsGame = self.timerForGame
        setupGame()
    }
    
    func check(index: Int){
        guard status == .start else {return}
        if itemsButtons[index].title == nextItem?.title {
            itemsButtons[index].isFound = true
            nextItem = itemsButtons.shuffled().first(where: { (item) -> Bool in
                item.isFound == false
            })
        } else {
            itemsButtons[index].isError = true
        }
        if nextItem == nil {
            status = .win
        }
    }
 
    func stopGame() {
        timer?.invalidate()
    }
    
}


extension Int{
    func secondsToString() -> String{
        let minutes = self / 60
        let seconds = self % 60
        
        return String(format: "%d:%02d", minutes,seconds)
    }
}
