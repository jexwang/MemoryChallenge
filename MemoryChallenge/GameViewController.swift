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
    
    
    var level: Int!
    var timeCounting = 1

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startCountdown()
    }
    
    func isHidden(status: Bool) {
        backButtonOutlet.isHidden = status
        useTimeLabel.isHidden = status
        minuteLabel.isHidden = status
        colonLabel.isHidden = status
        secondLabel.isHidden = status
        correctCountStackView.isHidden = status
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
    
    @IBAction func backButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
