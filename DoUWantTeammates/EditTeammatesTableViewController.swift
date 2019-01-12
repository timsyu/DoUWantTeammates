

import UIKit

class EditTeammatesTableViewController: UITableViewController, UINavigationControllerDelegate {
    
    var teammate: Teammate?
    
        @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var starTextField: UITextField!
    @IBOutlet weak var interestTextField: UITextField!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var innerSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let teammates = teammate {
            nameTextField.text = teammates.name
            starTextField.text = teammates.star
            interestTextField.text = teammates.interest
            birthdayLabel.text = teammates.birth
            innerSwitch.isOn = teammates.innerBeauty
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        teammate?.name = nameTextField.text ?? ""
        teammate?.star = starTextField.text ?? ""
        teammate?.interest = interestTextField.text ?? ""
        teammate?.innerBeauty = innerSwitch.isOn
    }
}
