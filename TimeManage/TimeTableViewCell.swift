
import UIKit

class TimeTableViewCell: UITableViewCell {

  // MARK: Properties

    @IBOutlet weak var nameLabel: UILabel!
  
    @IBOutlet weak var timeLabel: UILabel!
    
    
    var timer : Timer?
    var second:String!
    
    func startTimer() {

        timer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(updataSecond), userInfo: nil, repeats: true)
        //调用fire()会立即启动计时器
        timer!.fire()
     }
    // 3.定时操作
    @objc func updataSecond() {
        var int_second = (second as AnyObject).integerValue!
       // print(int_second)
        if int_second >= 0 {
            self.timeLabel.text =  second.description
            int_second -= 1
           second = "\(int_second)"
        }else {
           stopTimer()
        }
    }
    func stopTimer() {
        if timer != nil {
             timer!.invalidate() //销毁timer
             timer = nil
         }
     }
    
    var cur_state = 0 //1代表title为开始，2代表暂停
    @IBAction func startButton(_ sender: UIButton) {
        if cur_state == 0 {
            second = timeLabel.text!  //程序运行起来后再重新获取标签值，如果在构造的时候获取，拿到的是未初始化的值
            sender.setTitle("暂停", for: .normal)
            cur_state = 2
            startTimer() //启动定时器
        }
        
        else if cur_state == 1 {
            sender.setTitle("暂停", for: .normal)
            
            cur_state = 2
            
            startTimer() //启动定时器
            
        }
        
        else  {
            sender.setTitle("开始", for: .normal)
            cur_state = 1
            stopTimer() //停止计时器
        }
        
    }
    

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
     // print(timeLabel.text)
      second = timeLabel.text!

  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    // Configure the view for the selected state

  }

}
