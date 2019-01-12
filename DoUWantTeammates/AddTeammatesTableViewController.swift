
import UIKit

class AddTeammatesTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var isChangeImage = false
    
    @IBOutlet weak var headButton: UIButton!
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        headButton.setBackgroundImage(info[UIImagePickerControllerOriginalImage] as? UIImage, for: .normal)
        isChangeImage = true
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func changePhotoButtonPressed(_ sender: Any) {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = .photoLibrary
        present(controller, animated: true, completion: nil)
        
    }
    var teammate: Teammate!
    
    @IBOutlet weak var innerBeautySwitch: UISwitch!
    
    @IBOutlet weak var starTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var interestTextField: UITextField!
    
    @IBOutlet weak var birthDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func showAlert(message: String) {
        let controller = UIAlertController(title: "錯誤", message: message, preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        controller.addAction(action)
        present(controller, animated: true, completion: nil)
        
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        guard let name = nameTextField.text, name.count > 0 else {
            
            showAlert(message: "請輸入名字")
            return false
        }
        
        guard let star = starTextField.text, star.count > 0 else {
            
            showAlert(message: "請輸入守備位置")

            return false
        }
        
        /*guard star == "aquarius" else {
            showAlert(message: "只能喜歡水瓶座")
            return false
        }*/
        
        guard let interest = interestTextField.text, interest.count > 0 else {
            
            showAlert(message: "請輸入背號")
            
            return false
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let birth = formatter.string(from:birthDatePicker.date)
        
        guard innerBeautySwitch.isOn else {
            showAlert(message: "你怎麽會找不帥的隊員呢，這樣怎麽會有球經？")
            return false
        }
        
        var imageName: String?
        if isChangeImage {
            imageName = "\(Date().timeIntervalSinceReferenceDate)"
            let url = Teammate.documentsDirectory.appendingPathComponent(imageName!)
            let data = UIImageJPEGRepresentation(headButton.backgroundImage(for: .normal)!, 0.9)
            
            try? data?.write(to: url)
        }

        
        teammate = Teammate(name: name, star: star, interest: interest, birth: birth, innerBeauty: innerBeautySwitch.isOn, imageName: imageName)
        
        return true 
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
      
    }
    

}
