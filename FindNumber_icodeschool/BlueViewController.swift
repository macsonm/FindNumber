//
//  BlueViewController.swift
//  FindNumber_icodeschool
//
//  Created by Maxim M on 27.01.2022.
//

import UIKit

class BlueViewController: UIViewController {
    @IBOutlet weak var receivedInfoLabel: UILabel!
    var textForLabel = ""
    
    @IBAction func goToGreenVC(_ sender: Any) {
        
       
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //переход к зеленому экрану
        if let vc = storyboard.instantiateViewController(withIdentifier: "greenVC") as? GreenViewController {  //переход к экрану
            vc.textForLabelGreen = "Tst String"
            vc.title = "Green"      //заголовок в баре
        self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        receivedInfoLabel.text = textForLabel
       
        
    }
    

   
    
}
