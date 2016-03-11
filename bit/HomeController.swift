//
//  HomeController.swift
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
    @IBOutlet weak var loadingIndicator:UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Helpers.setGradientBackground(self)
        Helpers.addBorderToButton(convertButton)
        setDefaultsIfNone()
        
        // Show the loading indicator when loading from the interwebz
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.stopAnimating()
    }
    
    override func viewDidAppear(animated: Bool) {
        getCurrentExchange()
    }
    
    // Updates and loads the current conversion rate from the interwebz
    func getCurrentExchange() {
        loadingIndicator.startAnimating()
        
        exchange.getCurrentExchange() {choice,rate in
            let defaults = NSUserDefaults.standardUserDefaults()
            let bitNum = defaults.floatForKey(AppDelegate.settingsKeys.KEY_SAVED_BITCOIN)
            
            self.loadingIndicator.stopAnimating()
            self.updateCurrencyLabel(bitNum, choice: choice)
            self.updateValueLabel(choice, rate: rate)
        }
    }
    
    // Sets default settings values for first time users
    func setDefaultsIfNone() {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if defaults.objectForKey(AppDelegate.settingsKeys.KEY_CURRENCY) == nil {
            defaults.setValue(0, forKey: AppDelegate.settingsKeys.KEY_CURRENCY)
            defaults.setValue(1, forKey: AppDelegate.settingsKeys.KEY_SAVED_BITCOIN)
            defaults.synchronize()
            
            // Display the defaults from previous interwebz load
            updateCurrencyLabel(1, choice: 0)
            updateValueLabel(0, rate: 0)
        } else {
            let choice = defaults.integerForKey(AppDelegate.settingsKeys.KEY_SAVED_CURRENCY)
            let rate = defaults.doubleForKey(AppDelegate.settingsKeys.KEY_SAVED_RATE)
            let bitCoin = defaults.floatForKey(AppDelegate.settingsKeys.KEY_SAVED_BITCOIN)
            // Display the defaults from previous interwebz load
            updateCurrencyLabel(bitCoin, choice: choice)
            updateValueLabel(choice, rate: rate)
        }
    }
    
    func updateCurrencyLabel(bitNum:Float, choice:Int) {
        let value = Exchange.CurrencyTypes[choice][0]
        currencyLabel.text = String(bitNum) + " BTC ➔ " + value
    }
    
    func updateValueLabel(choice:Int, rate:Double) {
        let defaults = NSUserDefaults.standardUserDefaults()
        let bitCoin = defaults.floatForKey(AppDelegate.settingsKeys.KEY_SAVED_BITCOIN)
        let symbol = Exchange.CurrencyTypes[choice][1]
        let value = Double(bitCoin) * rate
        valueLabel.text = symbol + Helpers.formatMonetaryValue(value)
    }
    
    // Show popup dialog for user to enter amount of bitcoins
    @IBAction func showInputDialog(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Bitcoin Conversion", message: "Enter an amount of bitcoins", preferredStyle: .Alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
            textField.text = ""
        })
        
        //3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            let textField = alert.textFields![0] as UITextField
            let outputString = textField.text!
            let output = Float(outputString)
            if (output != nil) {
                defaults.setValue(output, forKey: AppDelegate.settingsKeys.KEY_SAVED_BITCOIN)
                self.getCurrentExchange()
            } else if (outputString.characters.count > 0) {
                self.showErrorDialog()
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: nil))
        
        // 4. Present the alert.
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func showErrorDialog() {
        let alert = UIAlertController(title: "Whoops", message: "The value you entered is invalid", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
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

