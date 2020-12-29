import UIKit

let memory = UserDefaults()

class MainViewController: UIViewController {
    
    // IBOutlets
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var billLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var percentageSelector: UISegmentedControl!
    @IBOutlet weak var currencySign: UILabel!
    
    
    // Variables
    var custom:Double? = nil
    let currency = "$"
    
    // IBActions
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
        save()
    }
    
    @IBAction func tapPercentageSelector(_ sender: Any) {
        
        if percentageSelector.selectedSegmentIndex == 3 {
            
            if let customVC = storyboard?.instantiateViewController(identifier: "CustomVC") as? CustomViewController {
                
                customVC.delegate = self
                
                showDetailViewController(customVC, sender: nil)
            }
            
        }
        
        if percentageSelector.selectedSegmentIndex != 3 {
            
            percentageSelector.setTitle("Custom", forSegmentAt: 3)
            
            custom = nil
            
            view.endEditing(true)
            
        }
        
        save()
    }
    
    
    @IBAction func calculateTip(_ sender: Any) {
        updateNum()
        save()
    }
    
    
    // Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencySign.text = currency
        
        let previousBill = retrievalBill()
        let settingsIndex = retrievalSetting()

        percentageSelector.selectedSegmentIndex = settingsIndex
        
        if previousBill != 0 {
            billField.text = String(previousBill.clean)
            calculateTip(self)
        } else {
            calculateTip(self)
        }
        
        
        billField.keyboardType = .decimalPad
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Setting", style: .plain, target: self, action: #selector(settingTapped))
        
    }
    
    func setDoneOnKeyboard() {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePressed))
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        self.billField.inputAccessoryView = keyboardToolbar
    }

    @objc func donePressed() {
        view.endEditing(true)
    }
    
    
    func updateNum() {
        
        // Get the bill amount
        let bill = Double(billField.text!) ?? 0
        billLabel.text = String(format: "\(currency)%.2f", bill)
        
        // Calculate the tip and total
        let tipPercentages = [0.1, 0.15, 0.2, custom]
        let percentage = tipPercentages[percentageSelector.selectedSegmentIndex] ?? 0
        let tip = bill * percentage
        let total = bill + tip
        
        
        // Update the tip and total label
        let percentageText = " (\(Int(percentage * 100))%)"
        tipLabel.text = String(format: "\(currency)%.2f", tip) + percentageText
        totalLabel.text = String(format: "\(currency)%.2f", total)
        
    }
    
    func save() {
        
        let bill = Double(billField.text!) ?? 0
        
        let now = Date()
        
        memory.setValue([bill, now], forKey: "Bill")
        
    }
    
    func retrievalBill() -> Double {
        
        var returnValue:Double = 0
        
        if let previousBillArray = memory.array(forKey: "Bill") {
            
            let previousValue = previousBillArray[0]
            
            let previousDate = previousBillArray[1]
            
            let currentDate = Date()
            
            let difference = currentDate.timeIntervalSince(previousDate as! Date)
            
            if difference <= 600 {
                
                returnValue = previousValue as! Double
                
            } else {
                
                returnValue = 0
            }
        }
        
        return returnValue
    }
    
    func retrievalSetting() -> Int {
        
        var returnValue:Int = 0
        
        let settingIndex = memory.integer(forKey: "selectedIndex")
        
        if settingIndex != 0 {
            
            returnValue = settingIndex
            
        }
        
        return returnValue
    }
    
    @objc func settingTapped() {
        
        if let settingVC = storyboard?.instantiateViewController(identifier: "SettingVC") as? SettingsViewController {
            
            settingVC.settingsDelegate = self
            
            showDetailViewController(settingVC, sender: nil)
        }
        
    }
    
    
}

extension MainViewController: sendData {
    
    func send(percentage: Double) {
        self.custom = percentage
        
        let text = Int(percentage * 100)
        
        percentageSelector.setTitle("CST: \(text)%", forSegmentAt: 3)
        
        updateNum()
        
        view.endEditing(true)
    }
    
}

extension MainViewController: settings {
    
    
    func percentageSetting(indexNum: Int) {
        
        memory.setValue(indexNum, forKey: "selectedIndex")
        
        
        
        
    }
    
    
}

