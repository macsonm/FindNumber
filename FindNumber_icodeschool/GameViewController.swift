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
        case .lose:
            statusLabel.text = "Lose"
            statusLabel.textColor = .red
            newGameButton.isHidden = false
        }
    }
}
