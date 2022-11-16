
import UIKit

class TimeViewController: UIViewController, /* protocols */ UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

  // MARK: Properties

@IBOutlet weak var nameTextField: UITextField!
  //@IBOutlet weak var timeNameLabel: UILabel!

@IBOutlet weak var timeTextField: UITextField!
@IBOutlet weak var saveButton: UIBarButtonItem!

  /*
   This value is either passed by `TimeTableViewController` in `prepareForSegue(_:sender:)`
   or constructed as part of adding a new time.
   */
  var time: Time?

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.

    // Handle the text field’s user input through delegate callbacks.
    nameTextField.delegate = self
      timeTextField.delegate = self

    // Set up views if editing an existing Time.
    if let time = time {
      navigationItem.title = time.name

      nameTextField.text   = time.name
        timeTextField.text   = time.time
        //print(timeTextField.text)
    }

    // Enable the Save button only if the text field has a valid Time name.
    checkValidTimeName()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.

  }

  func checkValidTimeName() {
    // Disable the Save button if the text field is empty.
    let text_1 = nameTextField.text ?? ""
      let text_2 = timeTextField.text ?? ""
      saveButton.isEnabled = (!text_1.isEmpty)&&(!text_2.isEmpty)
  }

  // MARK: UITextFieldDelegate

  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    // Hide the keyboard.
    textField.resignFirstResponder()
    return true
  }

  func textFieldDidBeginEditing(_ textField: UITextField) {
    // Disable the Save button while editing.
    saveButton.isEnabled = false
  }

  func textFieldDidEndEditing(_ textField: UITextField) {
    //timeNameLabel.text = textField.text
    checkValidTimeName()
    navigationItem.title = textField.text
  }

  // MARK: UIImagePickerControllerDelegate




  // MARK: Navigation

  @IBAction func cancel(_ sender: UIBarButtonItem) {
    // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
    let isPresentingInAddTimeMode = presentingViewController is UINavigationController

    if isPresentingInAddTimeMode {
      dismiss(animated: true, completion: nil)
    }
    else {
      navigationController!.popViewController(animated: true)
    }
  }

  // This method lets you configure a view controller before it's presented.
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let s = sender as? UIBarButtonItem {
      if saveButton === s {
            let name = nameTextField.text ?? ""
            let the_time = timeTextField.text ?? ""
            //print(timeTextField.text)
        // Set the time to be passed to TimeTableViewController after the unwind segue.
            time = Time(name: name, time:the_time)
      }
    }
  }

 
 

}
