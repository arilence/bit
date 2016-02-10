//
//  PopupTextField.swift
//  bit
//
//  Created by Anthony on 2016-02-09.
//  Copyright © 2016 Anthony Smith. All rights reserved.
//

import UIKit

class PopupTextField {
    
    @IBOutlet var bitcoinField: UITextField?
    
    func showTextField(controller : UIViewController, completion: (result: String) -> Void) {
        // Display a popup with textfield
        let newWordPrompt = UIAlertController(
            title: "Enter Bitcoin Amount",
            message: nil,
            preferredStyle: UIAlertControllerStyle.Alert)
        
        newWordPrompt.addTextFieldWithConfigurationHandler(addTextField)
        newWordPrompt.addAction(UIAlertAction(
            title: "Cancel",
            style: UIAlertActionStyle.Default,
            handler: nil))
        
        newWordPrompt.addAction(UIAlertAction(
            title: "Update",
            style: UIAlertActionStyle.Default,
            handler: {
                (alert: UIAlertAction!) in completion(result: self.bitcoinField!.text!)
            }))
        controller.presentViewController(newWordPrompt, animated: true, completion: nil)
    }
    
    func addTextField(textField: UITextField!){
        // Add the textfield to the popup
        textField.placeholder = "0"
        textField.keyboardType = UIKeyboardType.DecimalPad
        self.bitcoinField = textField
    }
    
}
