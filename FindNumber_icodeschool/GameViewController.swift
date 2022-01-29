import UIKit

class GameViewController: UIViewController {
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var nextDigit: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var newGameButton: UIButton!
    
    lazy var game = Game(countItems: buttons.count) { [weak self] (status, seconds) in
        guard let self = self else {return}
        self.timeLabel.text = seconds.secondsToString()
        self.updateInfoGame(with: status)
    }
    
    @IBAction func pressButton(_ sender: UIButton) {
        guard let buttonIndex = buttons.firstIndex(of: sender) else {return}        //получаем индекс текущец кнопки
        game.check(index: buttonIndex)      //передаем в модель индекс кнопки, на которую нажал пользователь
        updateUI()
    }
    @IBAction func pressNewGameButton(_ sender: UIButton) {
        game.newGame()
        sender.isHidden = true
        setupScreen()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScreen()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        game.stopGame()
    }
    
    
    private func setupScreen() {        // отображаем сгенерированные цифры из модели на кнопках экрана
        for i in game.itemsButtons.indices{
            buttons[i].setTitle(game.itemsButtons[i].title, for: .normal)
            //buttons[i].isHidden = false
            buttons[i].alpha = 1
            buttons[i].isEnabled = !game.itemsButtons[i].isFound
        }
        nextDigit.text = game.nextItem?.title
    }
    
    private func updateUI() {
        for i in game.itemsButtons.indices {
         //   buttons[i].isHidden = game.itemsButtons[i].isFound
            buttons[i].alpha = game.itemsButtons[i].isFound ? 0 : 1
            buttons[i].isEnabled = !game.itemsButtons[i].isFound
            
            
        //animation
        if game.itemsButtons[i].isError{
            UIView.animate(withDuration: 0.3) { [weak self] in     // длительность анимации
                self?.buttons[i].backgroundColor = .red      //то что анимируется
            } completion: { [weak self] (_) in                             //действия по окончании анимации
                self?.buttons[i].backgroundColor = .white
                self?.game.itemsButtons[i].isError = false
            }
            }
        }
        
        nextDigit.text = game.nextItem?.title
        updateInfoGame(with: game.status)
    }
    
    private func updateInfoGame(with status: StatusGame) {
        switch status {
        case .start:
            statusLabel.text = "Find the number"
            statusLabel.textColor = .black
            newGameButton.isHidden = true
        case .win:
            statusLabel.text = "Win"
            statusLabel.textColor = .green
            newGameButton.isHidden = false
            if game.isNewRecord{
                showAlert()
            }else{
                showAlertActionSheet()
            }
        case .lose:
            statusLabel.text = "Lose"
            statusLabel.textColor = .red
            newGameButton.isHidden = false
            showAlertActionSheet()
        }
    }
    
        private func showAlert() {
            let alert = UIAlertController(title: "You are winner", message: "You set new Record", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            alert.addAction(okAction)
            
            present(alert, animated: true, completion: nil)

    }
    
    private func showAlertActionSheet(){
       
        let alert = UIAlertController(title: "What do you want to do next?", message: nil, preferredStyle: .actionSheet)
        
        //добавляем кнопки действий
        let newGameAction = UIAlertAction(title: "Start new Game", style: .default) { [weak self] (_) in
            self?.game.newGame()
            self?.setupScreen()
        }
        let showRecord = UIAlertAction(title: "Go to scoreboard", style: .default) { [weak self](_) in
            self?.performSegue(withIdentifier: "recordVC", sender: nil)

        }
        
        let menuAction = UIAlertAction(title: "Back to menu", style: .destructive) { [weak self] (_) in
            self?.navigationController?.popViewController(animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        
        alert.addAction(newGameAction)
        alert.addAction(showRecord)
        alert.addAction(menuAction)
        alert.addAction(cancelAction)
        
        //на ipad падает приложение, если не привязать точку привязки (popover)
        if let popover = alert.popoverPresentationController{
            
            popover.sourceView = statusLabel //привязка alertController к, например, label:
            
//            //стандартный вывод в центре экрана уведомления
//            popover.sourceView = self.view
//            popover.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
//            popover.permittedArrowDirections = UIPopoverArrowDirection.init(rawValue: 0)
          
        }
        
        present(alert, animated: true, completion: nil)
    }

}

// FIXME: метки в коде
//    #warning("test")
//   #error("test")
//assert() //упадет приложение при указанном условии (для дебага, не работает в опубликованных приложениях appstore)
//fatalError() //роняет приложение даже на релизе в апп стор
