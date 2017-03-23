//
//  MainViewController.swift
//  MTLive
//
//  Created by MartinLee on 17/3/22.
//  Copyright © 2017年 MartinLee. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addChildiewController(storyName: "Home")
        addChildiewController(storyName: "Live")
        addChildiewController(storyName: "Follow")
        addChildiewController(storyName: "Profile")
    }
    
    private func addChildiewController(storyName : String){
        let childViewController = UIStoryboard(name: storyName, bundle: nil).instantiateInitialViewController()!
        addChildViewController(childViewController)
    }

}
