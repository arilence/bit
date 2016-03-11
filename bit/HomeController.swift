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
    
    private let exchange:Exchange = Exchange()
    @IBOutlet weak var convertButton: UIButton!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Helpers.setGradientBackground(self)
        Helpers.addBorderToButton(convertButton)
        
        setDefaultsIfNone()
    }
    
    override func viewDidAppear(animated: Bool) {
        exchange.getCurrentExchange() {choice,rate in
            self.updateCurrencyLabel(choice)
            self.updateValueLabel(choice, rate: rate)
        }
    }
    
    // Sets default settings values for first time users
    func setDefaultsIfNone() {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if defaults.objectForKey(AppDelegate.settingsKeys.KEY_CURRENCY) == nil {
            defaults.setValue(0, forKey: AppDelegate.settingsKeys.KEY_CURRENCY)
            defaults.synchronize()
        }
    }
    
    func updateCurrencyLabel(choice:Int) {
        let value = Exchange.CurrencyTypes[choice][0]
        currencyLabel.text = "1 BTC ➔ " + value
    }
    
    func updateValueLabel(choice:Int, rate:Double) {
        let symbol = Exchange.CurrencyTypes[choice][1]
        let value = 1 * rate
        valueLabel.text = symbol + String(value)
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

