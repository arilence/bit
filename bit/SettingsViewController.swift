//
//  SettingsController.swift
//  bit
//
//  Created by Anthony on 2016-03-08.
//  Copyright © 2016 Anthony Smith. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDelegate {
    
    // MARK: Variables
    
    let userDefaults = NSUserDefaults.standardUserDefaults()
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Helpers.addBorderToButton(saveButton, color: UIColor.blackColor())

        // Initialize Currency Picker and set it to the users preference setting
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let choice = userDefaults.integerForKey(AppDelegate.settingsKeys.KEY_CURRENCY)
        
        currencyPicker.delegate = self
        currencyPicker.selectRow(Int(choice), inComponent: 0, animated: false)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // MARK: UI Button Actions

    @IBAction func saveButton(sender: AnyObject) {
        // Get the users selection from the uiPicker
        let choice = currencyPicker.selectedRowInComponent(0)
        
        // Save the value into local storage
        userDefaults.setValue(choice, forKey: AppDelegate.settingsKeys.KEY_CURRENCY)
        userDefaults.synchronize()

        closeView()
    }
    
    @IBAction func closeButton(sender: AnyObject) {
        closeView()
    }
    
    // MARK: Pickerview
    
    // Set the font colour of the elements in the pickerView to white
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = Exchange.CurrencyTypes[row]
        let myTitle = NSAttributedString(string: titleData[0], attributes: [NSFontAttributeName:UIFont(name: "Helvetica", size: 15.0)!,NSForegroundColorAttributeName:UIColor.blackColor()])
        return myTitle
    }
    
    // Resizes the height of each element in pickerView
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 48.0
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Exchange.CurrencyTypes.count
    }
    
    // MARK: Miscellaneous Extras
    
    // Returns the user back to the home page
    func closeView() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Changes the status bar text colour to white.
    // For some reason changing it in the storyboard doesn't work.
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.Default
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
