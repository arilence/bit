//
//  SettingsController.swift
//  bit
//
//  Created by Anthony on 2016-03-08.
//  Copyright © 2016 Anthony Smith. All rights reserved.
//

import UIKit

class SettingsController: UIViewController {
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Helpers.setGradientBackground(self)
        Helpers.addBorderToButton(saveButton)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveButton(sender: AnyObject) {
        // TODO: Save curreny preference
        closeView()
    }
    
    @IBAction func closeButton(sender: AnyObject) {
        closeView()
    }
    
    // Set the font colour of the elements in the pickerView to white
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = Settings.settingsCurrency[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Helvetica", size: 15.0)!,NSForegroundColorAttributeName:UIColor.whiteColor()])
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
        return Settings.settingsCurrency.count
    }
    
    // Returns the user back to the home page
    func closeView() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Changes the status bar text colour to white.
    // For some reason changing it in the storyboard doesn't work.
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
}
