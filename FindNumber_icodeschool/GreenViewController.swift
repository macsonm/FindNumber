//
//  GreenViewController.swift
//  FindNumber_icodeschool
//
//  Created by Maxim M on 27.01.2022.
//

import UIKit

class GreenViewController: UIViewController {
   
    @IBOutlet weak var labelGreen: UILabel!
    var textForLabelGreen = ""
    
    @IBAction func backToRootVC(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)        // возврат к экрану рут, при этом все предыдущие vc удалены из массивов VCs
    
    }
    
    
    @IBAction func backToYellowButton(_ sender: UIButton) {
        //возврат к определенному экрану
            if let viewControllers = self.navigationController?.viewControllers{
                for vc in viewControllers {
                    if vc is YellowViewController{
                        self.navigationController?.popToViewController(vc, animated: true)
                    }
                }
            }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        labelGreen.text = textForLabelGreen
    }
    

   
    
}
