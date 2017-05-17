//
//  GameViewController.swift
//  MemoryChallenge
//
//  Created by 王冠綸 on 2017/5/15.
//  Copyright © 2017年 jexwang. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var backButtonOutlet: UIButton!
    @IBOutlet weak var useTimeLabel: UILabel!
    @IBOutlet weak var minuteLabel: UILabel!
    @IBOutlet weak var colonLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var correctCountStackView: UIStackView!
    @IBOutlet weak var mainButtonOutlet: UIButton!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var answerLabel2: UILabel!
    @IBOutlet weak var mainQuestionLabel: UILabel!
    @IBOutlet weak var mainQuestionLabel2: UILabel!
    @IBOutlet weak var subQuestionLabel: UILabel!
    @IBOutlet weak var subQuestionLabel2: UILabel!
    @IBOutlet weak var questionMarkLabel: UILabel!
    @IBOutlet weak var questionMarkLabel2: UILabel!
    @IBOutlet weak var numberPadStackView: UIStackView!
    
    var level: Int!
    var timeCounting = 1
    var questionArray: [String] = []
    var answerArray: [Int] = []
    var questionCount = 0

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
        mainQuestionLabel.isHidden = status
        subQuestionLabel.isHidden = status
        questionMarkLabel.isHidden = status
        questionMarkLabel2.isHidden = status
        numberPadStackView.isHidden = status
    }

    func startCountdown() {
        var startCountdownNumber = 3
        let startCountdownLabel = UILabel()
        startCountdownLabel.frame = UIScreen.main.bounds
        startCountdownLabel.textAlignment = .center
        startCountdownLabel.text = "Ready?"
        startCountdownLabel.font = UIFont.boldSystemFont(ofSize: 80)
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
                self.timer()
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
    
    func timer() {
        var minute: Int {
            return timeCounting / 60
        }
        var second: Int {
            return timeCounting % 60
        }
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            self.minuteLabel.text = "\(String(format: "%02d", minute))"
            self.secondLabel.text = "\(String(format: "%02d", second))"
            self.timeCounting += 1
        }
    }
    
    @IBAction func mainButton(_ sender: UIButton) {
        question()
        answerLabel.text?.removeAll()
    }
    
    @IBAction func numberPad(_ sender: UIButton) {
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
            
            UIView.animate(withDuration: 0.5, animations: { 
                self.mainQuestionLabel2.transform = CGAffineTransform(translationX: 0, y: 30)
                self.mainQuestionLabel2.alpha = 0
                self.answerLabel2.transform = CGAffineTransform(translationX: 0, y: 30)
                self.answerLabel2.alpha = 0
            })
        }
    }
}
