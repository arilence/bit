//
//  Helpers
//  bit
//
//  Created by Anthony on 2016-03-08.
//  Copyright © 2016 Anthony Smith. All rights reserved.
//

import UIKit

public class Helpers {
    
    // Adds a gradient layer ontop of the background view
    public static func setGradientBackground(targetView:UIViewController) {
        let gradientLayer = CAGradientLayer()
        let color1 = UIColor(red: 0.922, green: 0.353, blue: 0.227, alpha: 1.0).CGColor as CGColorRef
        let color2 = UIColor(red: 0.922, green: 0.169, blue: 0.388, alpha: 1.0).CGColor as CGColorRef
        
        gradientLayer.frame = targetView.view.bounds
        gradientLayer.colors = [color1, color2]
        gradientLayer.locations = [0.0, 1.0]
        
        targetView.view.layer.addSublayer(gradientLayer)
    }
    
    // Takes a button and makes it beautiful again :P
    public static func addBorderToButton(button:UIButton, color:UIColor) {
        button.backgroundColor = UIColor.clearColor()
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = color.CGColor
    }
    
    // Formats monetary values to hopefully fit the screen
    public static func formatMonetaryValue(value:Double) -> String {
        var newValue:Double = value
        var output:String = ""
        var ending:String = ""
        
        if (value > 1000000000) {
            ending += "B"
            newValue = value / 1000000000
        } else if (value > 1000000) {
            ending += "M"
            newValue = value / 1000000
        } else if (value > 1000) {
            ending += "K"
            newValue = value / 1000
        }
        
        output = String(format: "%.2f", newValue)
        output += ending
        return output
    }
    
}
