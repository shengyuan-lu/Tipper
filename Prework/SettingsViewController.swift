//
//  SettingsViewController.swift
//  Prework
//
//  Created by Shengyuan Lu on 12/27/20.
//

import UIKit

protocol settings {
    func percentageSetting(indexNum:Int)
}

class SettingsViewController: UIViewController {

    @IBOutlet weak var tipPercentageSelector: UISegmentedControl!
    
    var settingsDelegate:settings!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tipPercentageSelector.selectedSegmentIndex = memory.integer(forKey: "selectedIndex")

    }
    
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        
        settingsDelegate.percentageSetting(indexNum: tipPercentageSelector.selectedSegmentIndex)
        
        dismiss(animated: true, completion: nil)
    }
    
}
