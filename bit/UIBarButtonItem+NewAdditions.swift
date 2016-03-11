//
//  UIBarButtonItem+NewAdditions.swift
//  bit
//
//  Created by Anthony on 2016-03-11.
//  Copyright © 2016 Anthony Smith. All rights reserved.
//

import UIKit

internal extension UIBarButtonItem {
    static func profileItem(target target: AnyObject?, action: Selector) -> UIBarButtonItem {
        let image = UIImage(named: "profile.icon")
        return UIBarButtonItem(image: image, style: .Plain, target: target, action: action)
    }
    
    static func closeItem(target target: AnyObject?, action: Selector) -> UIBarButtonItem {
        let image = UIImage(named: "close.icon")
        return UIBarButtonItem(image: image, style: .Plain, target: target, action: action)
    }
    
    var position: CGPoint {
        return  (valueForKey("view") as? UIView)?.center ?? CGPoint.zero
    }
}