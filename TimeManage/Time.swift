
import UIKit

class Time: NSObject, /* protocol */ NSCoding {

  // MARK: Properties

var name: String
var time: String
 

  // MARK: Archiving Paths

  static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
  static let ArchiveURL = DocumentsDirectory.appendingPathComponent("times")

  // MARK: Types

  struct PropertyKey {
      static let nameKey = "name"
      static let timeKey = "time"

  }

  // MARK: Initialization

    init?(name: String, time: String) {
    
        self.name = name
        self.time = time
 

    super.init() // Call superclass initializer

    
  }

  // MARK: NSCoding

  func encode(with aCoder: NSCoder) {
    aCoder.encode(name, forKey: PropertyKey.nameKey)
    aCoder.encode(time, forKey: PropertyKey.timeKey)
  
  }

  required convenience init?(coder aDecoder: NSCoder) {
    let name = aDecoder.decodeObject(forKey: PropertyKey.nameKey) as! String
    let the_time =  aDecoder.decodeObject(forKey: PropertyKey.timeKey) as! String

    self.init(name: name, time: the_time)
  }

}
