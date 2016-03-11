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
        
        setDefaultsIfNone()
    }
    
    // Sets default settings values for first time users
    func setDefaultsIfNone() {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if defaults.objectForKey(Settings.settingsKeys.KEY_CURRENCY) == nil {
            defaults.setValue(0, forKey: Settings.settingsKeys.KEY_CURRENCY)
            defaults.synchronize()
        }
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

