

import UIKit

class TeammatesTableViewController: UITableViewController {

    var teammates = [Teammate]()
    
    @IBOutlet weak var TeammateNumberLabel: UILabel!
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        teammates.remove(at: indexPath.row)
        Teammate.saveToFile(teammates: teammates)
        tableView.reloadData()
        
    }
    
    @IBAction func goBackToTeammatesTableViewController(segue: UIStoryboardSegue) {
        if let controller = segue.source as? AddTeammatesTableViewController {
            teammates.append(controller.teammate)
            Teammate.saveToFile(teammates: teammates)
            tableView.reloadData()
            
        }
        
    }
    
    @IBAction func unwindToTeammatesPage(segue: UIStoryboardSegue) {
        let source = segue.source as? EditTeammatesTableViewController
        if let teammate = source?.teammate, let row = tableView.indexPathForSelectedRow?.row {
            teammates[row] = teammate
            Teammate.saveToFile(teammates: teammates)
            tableView.reloadData()
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "邊緣人的日常"))
        self.tableView.backgroundView?.alpha = 0.3
        
        if let teammates = Teammate.readTeammatesFromFile() {
            self.teammates = teammates
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let teammateNumber = teammates.count
        if teammateNumber == 0 {
            TeammateNumberLabel.text = " 隊員數:" + String(teammateNumber) + "  你沒有隊友，真可撥"
        }
        else if teammateNumber > 0 && teammateNumber <= 5 {
            TeammateNumberLabel.text = "隊員數:" + String(teammateNumber) + "  你竟然有隊友了？！"
        }
        else if teammateNumber > 5 && teammateNumber <= 10 {
            TeammateNumberLabel.text = "隊員數：" + String(teammateNumber) + "  真棒！隊友越來越多了！"
        }
        else {
            TeammateNumberLabel.text = "隊員數：" + String(teammateNumber) + "終於可以打比賽囉！！！！！"
        }
        
        return teammates.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "loverCell", for: indexPath) as? TeammatesTableViewCell else  {
            assert(false)
        }

        // Configure the cell...
        let teammate = teammates[indexPath.row]
        cell.nameLabel.text = teammate.name
        cell.interestLabel.text = teammate.interest
        cell.birthdayLabel.text = teammate.birth
        cell.imageView?.image = teammate.image
        
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let editTeammateTableViewController = segue.destination as? EditTeammatesTableViewController, let row = tableView.indexPathForSelectedRow?.row {
            editTeammateTableViewController.teammate = teammates[row]
        }
    }
    

}
