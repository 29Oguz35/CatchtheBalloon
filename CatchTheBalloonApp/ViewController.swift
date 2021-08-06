//
//  ViewController.swift
//  CatchTheBalloonApp
//
//  Created by naruto kurama on 6.08.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    
    @IBOutlet weak var balon1ImageView: UIImageView!
    @IBOutlet weak var balon2ImageView: UIImageView!
    @IBOutlet weak var balon3ImageView: UIImageView!
    @IBOutlet weak var balon4ImageView: UIImageView!
    @IBOutlet weak var balon5ImageView: UIImageView!
    @IBOutlet weak var balon6ImageView: UIImageView!
    @IBOutlet weak var balon7ImageView: UIImageView!
    @IBOutlet weak var balon8ImageView: UIImageView!
    @IBOutlet weak var balon9ImageView: UIImageView!
    
    var score = 0
    var counter = 0
    var highScore = 0
    
    var timer = Timer()
    var hideTimer = Timer()
    
    var balloonArray = [UIImageView]()

    override func viewDidLoad() {
        super.viewDidLoad()
       
        scoreLabel.text = "Score: \(score)"
        
        let storedHighScore = UserDefaults.standard.object(forKey: "Highscore")
        
        if storedHighScore == nil {
            highScore = 0
            highscoreLabel.text = "Highscore: \(highScore)"
            
        }
        if let newScore = storedHighScore as? Int {
            highScore = newScore
            highscoreLabel.text = "Highscore: \(highScore)"
            
        }
      
        balon1ImageView.isUserInteractionEnabled = true
        balon2ImageView.isUserInteractionEnabled = true
        balon3ImageView.isUserInteractionEnabled = true
        balon4ImageView.isUserInteractionEnabled = true
        balon5ImageView.isUserInteractionEnabled = true
        balon6ImageView.isUserInteractionEnabled = true
        balon7ImageView.isUserInteractionEnabled = true
        balon8ImageView.isUserInteractionEnabled = true
        balon9ImageView.isUserInteractionEnabled = true
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        balon1ImageView.addGestureRecognizer(recognizer1)
        balon2ImageView.addGestureRecognizer(recognizer2)
        balon3ImageView.addGestureRecognizer(recognizer3)
        balon4ImageView.addGestureRecognizer(recognizer4)
        balon5ImageView.addGestureRecognizer(recognizer5)
        balon6ImageView.addGestureRecognizer(recognizer6)
        balon7ImageView.addGestureRecognizer(recognizer7)
        balon8ImageView.addGestureRecognizer(recognizer8)
        balon9ImageView.addGestureRecognizer(recognizer9)
        
        balloonArray = [balon1ImageView, balon2ImageView, balon3ImageView, balon4ImageView, balon5ImageView, balon6ImageView,balon7ImageView,balon8ImageView,balon9ImageView]
        
        counter = 45
        timeLabel.text = String(counter)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideBallon), userInfo: nil, repeats: true)
        hideBallon()
    }
    @objc  func hideBallon(){
          
          for ballon in balloonArray {
              ballon.isHidden = true
          }
       let random = Int(arc4random_uniform( UInt32(balloonArray.count - 1)))
         balloonArray[random].isHidden = false
      }
    @objc func increaseScore() {
        score += 1
        scoreLabel.text = "Score: \(score)"
    }
    @objc func countDown() {
        counter -= 1
        timeLabel.text = String(counter)
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            for ballon in balloonArray {
                ballon.isHidden = true
            }
            
        if self.score > self.highScore {
            self.highScore = self.score
            highscoreLabel.text = "Highscore: \(self.highScore)"
            UserDefaults.standard.set(self.highScore, forKey: "highscore")
            }
            let alert = UIAlertController(title: "Time is Up", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel) { UIAlertAction in
              
                UIControl().sendAction(#selector(NSXPCConnection.suspend), to: UIApplication.shared, for: nil)
                self.score = 0
                self.scoreLabel.text = " Score: \(self.score)"
                self.counter = 45
                self.timeLabel.text = String(self.counter)
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideBallon), userInfo: nil, repeats: true)
                }
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { UIAlertAction in
                
                self.score = 0
                self.scoreLabel.text = " Score: \(self.score)"
                self.counter = 45
                self.timeLabel.text = String(self.counter)
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideBallon), userInfo: nil, repeats: true)
            }
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
        }
    }
}

