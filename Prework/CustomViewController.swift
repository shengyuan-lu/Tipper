import UIKit

protocol sendData {
    func send(percentage:Double)
}

class CustomViewController: UIViewController {
    
    @IBOutlet weak var percentageTextField: UITextField!
    
    var delegate: sendData!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func saveTapped(_ sender: Any) {
        
        delegate.send(percentage: ((Double(percentageTextField.text!)) ?? 0) / 100)
        
        view.endEditing(true)
        
        dismiss(animated: true, completion: nil)
        
    }
    

}
