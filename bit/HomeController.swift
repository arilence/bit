//
//  ViewController.swift
//  bit
//
//  Created by Anthony on 2016-02-03.
//  Copyright © 2016 Anthony Smith. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import RealmSwift

class HomeController: UIViewController {
    
    @IBOutlet weak var convertButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Helpers.setGradientBackground(self)
        Helpers.addBorderToButton(convertButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Changes the status bar text colour to white.
    // For some reason changing it in the storyboard doesn't work.
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

}

