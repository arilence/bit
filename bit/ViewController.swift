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

class ViewController: UIViewController {
    
    let gradientLayer = CAGradientLayer()
    
    @IBOutlet weak var convertButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setGradientBackground()
        
        convertButton.backgroundColor = UIColor.clearColor()
        convertButton.layer.cornerRadius = 5
        convertButton.layer.borderWidth = 1
        convertButton.layer.borderColor = UIColor.whiteColor().CGColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Adds a gradient layer ontop of the background view
    private func setGradientBackground() {
        // 1
        self.view.backgroundColor = UIColor.greenColor()
        
        // 2
        gradientLayer.frame = self.view.bounds
        
        // 3
        let color1 = UIColor(red: 0.922, green: 0.353, blue: 0.227, alpha: 1.0).CGColor as CGColorRef
        let color2 = UIColor(red: 0.922, green: 0.169, blue: 0.388, alpha: 1.0).CGColor as CGColorRef
        gradientLayer.colors = [color1, color2]
        
        // 4
        gradientLayer.locations = [0.0, 1.0]
        
        // 5
        self.view.layer.addSublayer(gradientLayer)
    }
    
    // Changes the status bar text colour to white.
    // For some reason changing it in the storyboard doesn't work.
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

}

