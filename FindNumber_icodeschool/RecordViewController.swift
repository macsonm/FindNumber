//
//  RecordViewController.swift
//  FindNumber_icodeschool
//
//  Created by Maxim M on 29.01.2022.
//

import UIKit

class RecordViewController: UIViewController {
    
    @IBOutlet weak var recordLabel: UILabel!
    
    @IBAction func closeModalVC(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let record = UserDefaults.standard.integer(forKey: KeysUserDefaults.recordGame)
        if record != 0 {
            recordLabel.text = "Your best score = \(record)"
        }else{
            recordLabel.text = "None"
        }
    }
    

   

}
