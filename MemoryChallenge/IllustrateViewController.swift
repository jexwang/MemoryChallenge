//
//  IillustrateViewController.swift
//  MemoryChallenge
//
//  Created by 王冠綸 on 2017/5/17.
//  Copyright © 2017年 jexwang. All rights reserved.
//

import UIKit

class IllustrateViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var doneButtonOutlet: UIButton!
    
    var index = 0
    var titleString = ""
    var imageFile = ""
    var content = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        titleLabel.text = titleString
        contentImageView.image = UIImage(named: imageFile)
        contentLabel.text = content
        pageControl.currentPage = index
        
        if index == 3 {
            doneButtonOutlet.isHidden = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
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
