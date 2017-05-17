//
//  GameViewController.swift
//  MemoryChallenge
//
//  Created by 王冠綸 on 2017/5/15.
//  Copyright © 2017年 jexwang. All rights reserved.
//

import UIKit
import AudioToolbox

class GameViewController: UIViewController {
    
    @IBOutlet weak var backButtonOutlet: UIButton!
    @IBOutlet weak var useTimeLabel: UILabel!
    @IBOutlet weak var minuteLabel: UILabel!
    @IBOutlet weak var colonLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var correctCountStackView: UIStackView!
    @IBOutlet weak var correctCountLabel: UILabel!
    @IBOutlet weak var mainButtonOutlet: UIButton!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var answerLabel2: UILabel!
    @IBOutlet weak var judgeLabel: UILabel!
    @IBOutlet weak var mainQuestionLabel: UILabel!
    @IBOutlet weak var mainQuestionLabel2: UILabel!
    @IBOutlet weak var subQuestionLabel: UILabel!
    @IBOutlet weak var subQuestionLabel2: UILabel!
    @IBOutlet weak var questionMarkLabel: UILabel!
    @IBOutlet weak var questionMarkLabel2: UILabel!
    @IBOutlet weak var numberPadStackView: UIStackView!
    
    var level: Int!
    var timeCounting = 0
    var questionArray: [String] = []
    var answerArray: [Int] = []
    var questionCount = 0
    var canInput = false
    var correctCount = 0
    var gameTimer: Timer!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startCountdown()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func isHidden(status: Bool) {
        backButtonOutlet.isHidden = status
        useTimeLabel.isHidden = status
        minuteLabel.isHidden = status
        colonLabel.isHidden = status
        secondLabel.isHidden = status
        correctCountStackView.isHidden = status
        mainButtonOutlet.isHidden = status
        answerLabel.isHidden = status
        answerLabel2.isHidden = status
        judgeLabel.isHidden = status
        mainQuestionLabel.isHidden = status
        mainQuestionLabel2.isHidden = status
        subQuestionLabel.isHidden = status
        subQuestionLabel2.isHidden = status
        questionMarkLabel.isHidden = status
        questionMarkLabel2.isHidden = status
        numberPadStackView.isHidden = status
    }

    func startCountdown() {
        var startCountdownNumber = 3
        let startCountdownLabel = UILabel()
        startCountdownLabel.frame = UIScreen.main.bounds
        startCountdownLabel.textAlignment = .center
        startCountdownLabel.text = "READY?"
        startCountdownLabel.font = UIFont.boldSystemFont(ofSize: 80)
        startCountdownLabel.adjustsFontSizeToFitWidth = true
        view.addSubview(startCountdownLabel)
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            switch startCountdownNumber {
            case 1...3:
                startCountdownLabel.text = "\(startCountdownNumber)"
            case 0:
                startCountdownLabel.text = "START!"
            default:
                timer.invalidate()
                startCountdownLabel.removeFromSuperview()
                self.isHidden(status: false)
                self.gameTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                    self.timeCounting += 1
                    self.timerRefresh()
                }
                self.question()
            }
            
            startCountdownLabel.transform = CGAffineTransform(scaleX: 50, y: 50)
            startCountdownLabel.alpha = 0
            UIView.animate(withDuration: 0.7, animations: {
                startCountdownLabel.transform = CGAffineTransform.identity
                startCountdownLabel.alpha = 1
            })
            
            startCountdownNumber -= 1
        }
    }
    
    func timerRefresh() {
        var minute: Int {
            return timeCounting / 60
        }
        var second: Int {
            return timeCounting % 60
        }
        minuteLabel.text = "\(String(format: "%02d", minute))"
        secondLabel.text = "\(String(format: "%02d", second))"
    }
    
    @IBAction func mainButton(_ sender: UIButton) {
        judge()
        question()
        answerLabel.text?.removeAll()
    }
    
    @IBAction func numberPad(_ sender: UIButton) {
        if canInput {
            switch sender.tag {
            case 1...9:
                if (answerLabel.text?.characters.count)! < 2 {
                    answerLabel.text?.append(String(sender.tag))
                }
            case 10:
                if (answerLabel.text?.characters.count)! < 2 {
                    answerLabel.text?.append("0")
                }
            case 11:
                if answerLabel.text != "" {
                    let index = answerLabel.text!.index(before: answerLabel.text!.endIndex)
                    answerLabel.text!.remove(at: index)
                }
            default:
                break
            }
        }
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }

}

extension GameViewController {
    func question() {
        let firstNumber = arc4random_uniform(10)
        let secondNumber = arc4random_uniform(firstNumber + 1)
        let randomOpretor = arc4random_uniform(2)
        if randomOpretor == 0 {
            let question = "\(firstNumber) + \(secondNumber) ="
            questionArray.append(question)
            let answer = firstNumber + secondNumber
            answerArray.append(Int(answer))
        } else {
            let question = "\(firstNumber) - \(secondNumber) ="
            questionArray.append(question)
            let answer = firstNumber - secondNumber
            answerArray.append(Int(answer))
        }
        
        questionCount += 1
        animate()
        
        if questionCount == level + 1 {
            mainButtonOutlet.setTitle("Enter", for: .normal)
            canInput = true
        }
    }
    
    func animate() {
        subQuestionLabel.text = questionArray[questionArray.count - 1]
        subQuestionLabel.transform = CGAffineTransform(translationX: 0, y: -30)
        subQuestionLabel.alpha = 0
        
        questionMarkLabel.transform = CGAffineTransform(translationX: 0, y: -30)
        questionMarkLabel.alpha = 0
        
        UIView.animate(withDuration: 0.5) {
            self.subQuestionLabel.transform = .identity
            self.subQuestionLabel.alpha = 1
            self.questionMarkLabel.transform = .identity
            self.questionMarkLabel.alpha = 1
        }
        
        if questionCount > 1 {
            subQuestionLabel2.text = questionArray[questionCount - 2]
            subQuestionLabel2.transform = .identity
            subQuestionLabel2.alpha = 1
            
            questionMarkLabel2.transform = .identity
            questionMarkLabel2.alpha = 1
            
            UIView.animate(withDuration: 0.5, animations: {
                self.subQuestionLabel2.transform = CGAffineTransform(translationX: 0, y: 30)
                self.subQuestionLabel2.alpha = 0
                self.questionMarkLabel2.transform = CGAffineTransform(translationX: 0, y: 30)
                self.questionMarkLabel2.alpha = 0
            })
        }
        
        if questionCount > level {
            mainQuestionLabel.transform = CGAffineTransform(translationX: 0, y: -30)
            mainQuestionLabel.alpha = 0
            UIView.animate(withDuration: 0.5, animations: {
                self.mainQuestionLabel.transform = .identity
                self.mainQuestionLabel.alpha = 1
            })
        }
        
        if questionCount > level + 1 {
            mainQuestionLabel2.text = questionArray[questionCount - (level + 2)]
            mainQuestionLabel2.transform = .identity
            mainQuestionLabel2.alpha = 1
            
            answerLabel2.text = answerLabel.text
            answerLabel2.transform = .identity
            answerLabel2.alpha = 1
            
            judgeLabel.transform = .identity
            judgeLabel.alpha = 1
            
            UIView.animate(withDuration: 0.5, animations: { 
                self.mainQuestionLabel2.transform = CGAffineTransform(translationX: 0, y: 30)
                self.mainQuestionLabel2.alpha = 0
                self.answerLabel2.transform = CGAffineTransform(translationX: 0, y: 30)
                self.answerLabel2.alpha = 0
                self.judgeLabel.transform = CGAffineTransform(translationX: 0, y: 30)
                self.judgeLabel.alpha = 0
            })
        }
    }
    
    func judge() {
        if canInput {
            if Int(answerLabel.text!) == answerArray[questionCount - (level + 1)] {
                correctCount += 1
                correctCountLabel.text = "\(correctCount)"
                
                if correctCount == 10 {
                    gameset()
                }
                
                AudioServicesPlaySystemSound(1377)
                judgeLabel.text = "O"
                judgeLabel.textColor = UIColor.green
            } else {
                timeCounting += 3
                timerRefresh()
                
                AudioServicesPlaySystemSound(1380)
                judgeLabel.text = "X"
                judgeLabel.textColor = UIColor.red
            }
        }
    }
    
    func gameset() {
        gameTimer.invalidate()
        isHidden(status: true)
        let gameoverLabel = UILabel()
        gameoverLabel.frame = UIScreen.main.bounds
        gameoverLabel.textAlignment = .center
        gameoverLabel.text = "GAME SET!"
        gameoverLabel.font = UIFont.boldSystemFont(ofSize: 80)
        gameoverLabel.adjustsFontSizeToFitWidth = true
        view.addSubview(gameoverLabel)
        gameoverLabel.transform = CGAffineTransform(scaleX: 50, y: 50)
        gameoverLabel.alpha = 0
        UIView.animate(withDuration: 0.5, animations: {
            gameoverLabel.transform = CGAffineTransform.identity
            gameoverLabel.alpha = 1
        })
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
            gameoverLabel.removeFromSuperview()
            let alert = UIAlertController(title: nil, message: "難度：\(self.level!)\n使用時間：\(self.minuteLabel.text!)分\(self.secondLabel.text!)秒", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "確定", style: .default, handler: { _ in
                self.navigationController?.popViewController(animated: true)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
