//
//  IllustratePageViewController.swift
//  MemoryChallenge
//
//  Created by 王冠綸 on 2017/5/17.
//  Copyright © 2017年 jexwang. All rights reserved.
//

import UIKit

class IllustratePageController: UIPageViewController, UIPageViewControllerDataSource {

    let pageTitles = ["選擇難度\n並開始遊戲", "記住答案\n並繼續下一題", "依序作答\n並同時記住下一題", "挑戰時間\n提高記憶力"]
    let pageImages = ["illustrate1", "illustrate2", "illustrate3", "illustrate4"]
    let pageContent = ["依照自己的記憶力選擇適當的難度，第一次遊玩可先以等級一理解遊戲流程。", "遊戲開始後依照選擇的難度不同，一開始要記住的題數也會不同，請依序記住目前看到題目的答案並按 Next。", "直到等待回答的提示出現後，依序使用之前所記住的答案來作答，作答同時仍需持續記住下一題的答案。", "若答錯的話使用時間會 +3 秒，試著挑戰使用更短的時間答對30題吧！"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        dataSource = self
        
        if let startingViewController = contentViewController(at: 0) {
            setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! IllustrateViewController).index
        index -= 1
        
        return contentViewController(at: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! IllustrateViewController).index
        index += 1
        
        return contentViewController(at: index)
    }
    
    func contentViewController(at  index: Int) -> IllustrateViewController? {
        if index < 0 || index >= pageTitles.count {
            return nil
        }
        
        if let pageContentViewController = storyboard?.instantiateViewController(withIdentifier: "IllustrateViewController") as? IllustrateViewController {
            pageContentViewController.titleString = pageTitles[index]
            pageContentViewController.imageFile = pageImages[index]
            pageContentViewController.content = pageContent[index]
            pageContentViewController.index = index
            
            return pageContentViewController
        }
        
        return nil
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
