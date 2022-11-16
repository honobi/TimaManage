

import UIKit

class TimeTableViewController: UITableViewController {
    
  // MARK: Properties

  var times = [Time]()

  override func viewDidLoad() {
    super.viewDidLoad()

    navigationItem.leftBarButtonItem = editButtonItem

    // Load any saved times, otherwise load sample data.
    if let savedTimes = loadTimes() {
      times += savedTimes
      
    }
    else {
      // Load the sample data.
      loadSampleTimes()
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.

  }

  func loadSampleTimes() {

    let time1 = Time(name: "LeetCode", time: "60")!

    let time2 = Time(name: "Effective C++", time: "30")!

    let time3 = Time(name: "Webserver", time: "120")!

    times += [time1, time2, time3]
   
  }



  // MARK: - Table view data source

  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return times.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    // Table view cells are reused and should be dequeued using a cell identifier.
    let cellIdentifier = "TimeTableViewCell"
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TimeTableViewCell

    // Fetches the appropriate time for the data source layout.
    let time = times[indexPath.row]

    cell.nameLabel.text = time.name
    cell.timeLabel.text = time.time
      print(cell.timeLabel.text)
    

    return cell
  }

  // Override to support conditional editing of the table view.
  override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
  }

  // Override to support editing the table view.
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    print("at: \(indexPath.row)") // Debug
    if editingStyle == .delete {
      // Delete the row from the data source
      times.remove(at: indexPath.row)
      saveTimes()
      tableView.deleteRows(at: [indexPath], with: .fade)
    } else if editingStyle == .insert {
      // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
  }

  // Override to support rearranging the table view.
  override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to toIndexPath: IndexPath) {
    print("from: \(fromIndexPath.row), to: \(toIndexPath.row)") // Debug
    let time = times.remove(at: fromIndexPath.row)
    times.insert(time, at: toIndexPath.row)
    saveTimes()
  }

  // Override to support conditional rearranging of the table view.
  override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
    // Return false if you do not want the item to be re-orderable.
    return true
  }

  // MARK: - Navigation

  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "ShowDetail" {
      let timeDetailViewController = segue.destination as! TimeViewController // If the cast is unsuccessful, the app should crash at runtime.

      // Get the cell that generated this segue.
      if let selectedTimeCell = sender as? TimeTableViewCell {
        let indexPath = tableView.indexPath(for: selectedTimeCell)!

     let selectedTime = times[indexPath.row]

        timeDetailViewController.time = selectedTime
      }
    }
    else if segue.identifier == "AddItem" {
      print("Adding new time.")
    }

  }

  // MARK: Actions

  @IBAction func unwindToTimeList(_ sender: UIStoryboardSegue) {
    if let sourceViewController = sender.source as? TimeViewController, let time = sourceViewController.time {
      if let selectedIndexPath = tableView.indexPathForSelectedRow {
        // Update an existing time.
        times[selectedIndexPath.row] = time
        tableView.reloadRows(at: [selectedIndexPath], with: .none)
      }
      else {
        // Add a new time.
        let newIndexPath = IndexPath(row: times.count, section: 0)
        times.append(time)
        tableView.insertRows(at: [newIndexPath], with: .bottom)
      }
      // Save the times.
      saveTimes()
    }
  }

  // MARK: NSCoding

  func saveTimes() {
    let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(times, toFile: Time.ArchiveURL.path)
    
  }

  func loadTimes() -> [Time]? {
    return NSKeyedUnarchiver.unarchiveObject(withFile: Time.ArchiveURL.path) as? [Time]
  }

}
