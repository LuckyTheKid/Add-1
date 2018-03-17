
import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    
    var score = 0
    var timer: Timer!
    var seconds = 60
    var sound1: AVAudioPlayer!
    var sound2: AVAudioPlayer!
    var backgroundMusic: AVAudioPlayer! 

    @IBOutlet weak var numbersLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var inputField:UITextField!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var corectLabel: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // kodiranje zvuka za tacno
        let path1 = Bundle.main.path(forResource: "correct", ofType: "mp3")
        let soundURL1 = URL(fileURLWithPath: path1!)
        do {   try sound1 = AVAudioPlayer(contentsOf: soundURL1)
            sound1.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        // kodiranje zvuka za netacno
        let path2 = Bundle.main.path(forResource: "wrong 2", ofType: "mp3")
        let soundURL2 = URL(fileURLWithPath: path2!)
        do {   try sound2 = AVAudioPlayer(contentsOf: soundURL2)
            sound2.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        // kodiranje za zvuk u pozadini
        let path3 = Bundle.main.path(forResource: "background", ofType: "mp3")
        let soundURL3 = URL(fileURLWithPath: path3!)
        do {   try backgroundMusic = AVAudioPlayer(contentsOf: soundURL3)
            backgroundMusic.numberOfLoops = -1
            backgroundMusic.prepareToPlay()
            backgroundMusic.volume = 0.2
            backgroundMusic.play()
        } catch let err as NSError {
            print(err.debugDescription)
        }

        setRandomNumberLabel()
        updateScoreLabel()
        updateTimeLabel()
        corectLabel.isHidden = true
        inputField.text = ""
        
        inputField.addTarget(self, action:#selector(textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        
 
    }
    
    @objc func textFieldDidChange(textField:UITextField)
    {
        if inputField.text?.characters.count ?? 0 < 4
        {
            return
        }
        
        if  let numbersText = numbersLabel.text,
            let inputText = inputField.text,
            let numbers = Int(numbersText),
            let input = Int(inputText)
        {
            print("Comparing: \(inputText) minus \(numbersText) == \(input - numbers)")
            
            if(input - numbers == 1111) {
                
                print("Correct!")
                
                inputField.text = ""
                corectLabel.isHidden = false
                corectLabel.text = "Tačno!"
                corectLabel.textColor = UIColor.white
                sound1.currentTime = 0.7
                sound1.volume = 0.5
                sound1.play()
                
                score += 1
            }
            else {
                print("Incorrect!")
                
                inputField.text = ""
                corectLabel.isHidden = false
                corectLabel.text = "Netačno!"
                corectLabel.textColor = UIColor.brown
                
                sound2.currentTime = 0.9
                sound2.volume = 0.5
                sound2.play()
                
                if score > 0 {
                    score -= 1
                }
            }
            
           
        }
        
        setRandomNumberLabel()
        updateScoreLabel()
        corectLabel.isHidden = false
        inputField.text = ""
        
        if timer == nil {
            
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector:#selector(onUpdateTimer), userInfo: nil, repeats: true)
        }
    }

    @objc func onUpdateTimer() -> Void {
        
        if ( seconds > 0 && seconds <= 60)
        {
         seconds -= 1
            
            updateTimeLabel()
        }
        else if seconds == 0
        {
            if timer != nil
            {
              timer.invalidate()
                timer = nil
                
                let alertController = UIAlertController(title: "Vreme je isteklo!", message: "Vaš skor је: \(score) poena!", preferredStyle: .alert)
                
                let restartAction = UIAlertAction(title: "Restartuj igru", style: .default, handler: nil)
                
                alertController.addAction(restartAction)
                
                self.present(alertController, animated: true, completion: nil)
                
                score = 0
                seconds = 60
                
                updateTimeLabel()
                updateScoreLabel()
                setRandomNumberLabel()
                corectLabel.isHidden = true
                inputField.text = ""
        }
    }
}
  
    func updateTimeLabel() {   // we want to update the time label with a 00:00 format.
        
        if timeLabel != nil {
            
            let min = (seconds/60) % 60
            let sec = seconds % 60
            
            let p_min = String(format: "%02d", min) // The format indicator "%02d" means: always write me with two digits, and when there’s initially only one digit, prefix me with a zero.
            
            let p_sec = String(format: "%02d", sec)
            
            timeLabel.text = "\(p_min):\(p_sec)"
        }
    }
    
    func updateScoreLabel()
    {
        scoreLabel?.text = "\(score)"
    }
    
    func setRandomNumberLabel()
    {
        numbersLabel?.text = generateRandomNumber()
    }
    
    func generateRandomNumber() -> String
    {
        var result:String = ""
        
        for _ in 1...4
        {
            let digit = Int(arc4random_uniform(8) + 1)
            
            result += "\(digit)"
        }
        
        return result
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    
}


