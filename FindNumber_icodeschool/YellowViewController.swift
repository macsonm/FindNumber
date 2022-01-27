//
//  YellowViewController.swift
//  FindNumber_icodeschool
//
//  Created by Maxim M on 27.01.2022.
//

import UIKit

class YellowViewController: UIViewController {

// MARK: - вызываются когда vc показывается на экране
    //настраивается интерфейс, добавляются элементы, которые не были добавлены в интерфейсном файле. (вызывается только один раз когда экран создается)
    override func viewDidLoad() {
        super.viewDidLoad()
        print("YellowVC viewDIdLoad")
    }
    
    //настраиваются подписи,тексты и цвета в элементах, которые будут видны для пользователя. (вызывается каждый раз как появляется экран)
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("YellowVC viewWillAppear")
    }

    //настраивается анимация и прочие ресурсоемкие задачи,т.к. UI был уже подгружен на ЖЦ viewWillAppear (вызывается когда vc только отобразился на экране)
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("YellowVC viewDidAppear")
    }
  
// MARK: - вызываются когда vc уходит с экрана
    //(вызывается когда контролер будет скрыт с экрана, но он все еще отображается
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("YellowVC viewWillDisapear")
    }
    
    //(вызывается когда экран скрыт уже и будет уничтожен если на vc нет strong ссылок
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("YellowVC viewDidDissapear")
    }
    
    //(вызывается когда экземпляр класса удаляется)
    deinit{
        print("YellowVC deinit")
    }
    
    
    @IBAction func goToBlueScreen(_ sender: UIButton) {
        performSegue(withIdentifier: "goToBlueScreen", sender: "Test String")
   }
    
    //передаем данные на другой VC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "goToBlueScreen":
            if let blueVC = segue.destination as? BlueViewController{
                if let string = sender as? String {
                    blueVC.textForLabel = string
                }
            }
        default:
            break
            
        }
    }
    
}
