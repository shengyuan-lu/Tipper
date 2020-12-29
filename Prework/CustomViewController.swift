import UIKit

protocol sendData {
    func send(percentage:Double)
}

class CustomViewController: UIViewController {
    
    @IBOutlet weak var percentageTextField: UITextField!
    
    var delegate: sendData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDoneOnKeyboard()

    }
    
    @IBAction func saveTapped(_ sender: Any) {
        
        delegate.send(percentage: ((Double(percentageTextField.text!)) ?? 0) / 100)
        
        view.endEditing(true)
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func setDoneOnKeyboard() {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePressed))
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        self.percentageTextField.inputAccessoryView = keyboardToolbar
    }

    @objc func donePressed() {
        view.endEditing(true)
    }
    

}
