//
//  GameViewController.swift
//  FindNumber_icodeschool
//
//  Created by Maxim M on 25.01.2022.
//

import UIKit

class GameViewController: UIViewController {
//    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var nextDigit: UILabel!
    @IBOutlet weak var statusLable: UILabel!
    
    lazy var game = Game(countItems: buttons.count)
    
    @IBAction func pressButton(_ sender: UIButton) {
        guard let buttonIndex = buttons.firstIndex(of: sender) else {return}        //получаем индекс текущец кнопки
        game.check(index: buttonIndex)      //передаем в модель индекс кнопки, на которую нажал пользователь
        updateUI()
 //       sender.isHidden = true
 //       print(sender.currentTitle)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
//        firstButton.backgroundColor = .orange
//        firstButton.setTitle("10", for: .normal)
        setupScreen()
    }
    
    
    private func setupScreen() {        // отображаем сгенерированные цифры из модели на кнопках экрана
        for i in game.itemsButtons.indices{
            buttons[i].setTitle(game.itemsButtons[i].title, for: .normal)
            buttons[i].isHidden = false
        }
        nextDigit.text = game.nextItem?.title
    }
    
    private func updateUI() {
        for i in game.itemsButtons.indices {
            buttons[i].isHidden = game.itemsButtons[i].isFound
        }
        nextDigit.text = game.nextItem?.title
        if game.status == .win {
            statusLable.text = "Win"
            statusLable.textColor = .green
        }
    }
    
}
