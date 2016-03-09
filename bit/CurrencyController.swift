//
//  CurrencyController.swift
//  bit
//
//  Created by Anthony on 2016-03-08.
//  Copyright © 2016 Anthony Smith. All rights reserved.
//

import UIKit

class CurrencyController: UIViewController {
    
    @IBOutlet weak var currencyPicker: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Helpers.setGradientBackground(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Changes the status bar text colour to white.
    // For some reason changing it in the storyboard doesn't work.
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
}
