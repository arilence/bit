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

internal final class HomeViewController: UIViewController {
    
    // MARK: Variables
    
    private let exchange:Exchange = Exchange()
    private let network:Network = Network()
    @IBOutlet weak var convertButton: UIButton!
    @IBOutlet weak var settingsGearButton: UIButton!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var lastUpdatedSync: UILabel!
    @IBOutlet weak var loadingIndicator:UIActivityIndicatorView!
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Helpers.addBorderToButton(convertButton, color: UIColor.whiteColor())
        setDefaultsIfNone()
        navigationItem.hidesBackButton = true
        
        // Hide the loading indicator at launch
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.stopAnimating()
        
        // Notifies when the user is connected to the internet
        network.startChecking({
            print("Connected")
            self.getCurrentExchange()
        }, notConnected: {
            print("Lost Connection")
        })
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewWillAppear(animated)
        getCurrentExchange()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        Helpers.setGradientBackground(self)
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
    
    // MARK: Dialog Popups
    
    // Show popup dialog for user to enter amount of bitcoins
    @IBAction func showInputDialog(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        // Create the alert
        let alert = UIAlertController(title: "Bitcoin Conversion", message: "Enter an amount of bitcoins", preferredStyle: .Alert)
        alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
            textField.keyboardType = UIKeyboardType.DecimalPad
            textField.text = ""
        })
        
        // Configure the alert
        alert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            let textField = alert.textFields![0] as UITextField
            let outputString = textField.text!
            let output = Float(outputString)
            if (output != nil) {
                if (output < 1000000) {
                    defaults.setValue(output, forKey: AppDelegate.settingsKeys.KEY_SAVED_BITCOIN)
                    self.getCurrentExchange()
                } else {
                    self.showErrorDialog("Too many bitcoins")
                }
            } else if (outputString.characters.count > 0) {
                self.showErrorDialog()
            }
        }))
        
        // Present the alert
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func showErrorDialog(text:String = "The value you entered is invalid") {
        let alert = UIAlertController(title: "Whoops", message: text, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    // MARK: Other
    
    // Updates and loads the current conversion rate from the interwebz
    func getCurrentExchange() {
        if (network.isReachable()) {
            loadingIndicator.startAnimating()
        
            exchange.getCurrentExchange() {choice,rate in
                let defaults = NSUserDefaults.standardUserDefaults()
                let bitNum = defaults.floatForKey(AppDelegate.settingsKeys.KEY_SAVED_BITCOIN)
                defaults.setObject(NSDate(), forKey: AppDelegate.settingsKeys.KEY_PREVIOUS_SYNC)
                defaults.synchronize()
                
                self.updateLastSyncTime()
            
                self.loadingIndicator.stopAnimating()
                self.updateCurrencyLabel(bitNum, choice: choice)
                self.updateValueLabel(choice, rate: rate)
            }
        } else {
            showErrorDialog("No network connection")
        }
    }
    
    // Sets default settings values for first time users
    func setDefaultsIfNone() {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if defaults.objectForKey(AppDelegate.settingsKeys.KEY_CURRENCY) == nil {
            defaults.setValue(0, forKey: AppDelegate.settingsKeys.KEY_CURRENCY)
            defaults.setValue(1, forKey: AppDelegate.settingsKeys.KEY_SAVED_BITCOIN)
            defaults.synchronize()
            
            // Display the defaults if no internet
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
        updateLastSyncTime()
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
    
    func updateLastSyncTime() {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if let dateTime = defaults.objectForKey(AppDelegate.settingsKeys.KEY_PREVIOUS_SYNC) as? NSDate {
            lastUpdatedSync.text = "Last Updated: " + timeAgoSince(dateTime)
        } else {
            lastUpdatedSync.text = "Last Updated: Never"
        }
    }
    
    // Shows the settings page
    @IBAction func settingsButton(sender: AnyObject) {
        let controller = UINavigationController(rootViewController: SettingsViewController())
        controller.modalPresentationStyle = .Custom
        controller.transitioningDelegate = self
        presentViewController(controller, animated: true, completion: nil)
    }

}

extension HomeViewController: UIViewControllerTransitioningDelegate {
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return MaskTransition(presenting: true, position: settingsGearButton?.center ?? CGPoint.zero)
    }
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        getCurrentExchange()
        return MaskTransition(presenting: false, position: settingsGearButton?.center ?? CGPoint.zero)
    }
}

