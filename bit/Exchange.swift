//
//  Exchange.swift
//  bit
//
//  Created by Anthony on 2016-03-10.
//  Copyright © 2016 Anthony Smith. All rights reserved.
//

import Alamofire
import SwiftyJSON

public class Exchange {
    
    public static let CurrencyTypes = [
        ["CAD", "$"],
        ["USD", "$"],
        ["JPY", "¥"],
        ["GBP", "£"],
        ["EUR", "€"]
    ]
    
    private let baseURL = "https://api.bitcoinaverage.com/ticker/global/"
    private let userDefaults = NSUserDefaults.standardUserDefaults()
    
    public func getCurrentExchange(completion: (choice: Int, rate:Double) -> Void) {
        // Get the currency code from the users settings
        let exchangeChoice = userDefaults.integerForKey(AppDelegate.settingsKeys.KEY_CURRENCY)
        let exchange = Exchange.CurrencyTypes[exchangeChoice][0]
        
        // Try and get the current exchange rate for the specified currency
        Alamofire.request(.GET, baseURL + exchange, parameters: nil)
            .responseJSON { response in
                if let result = response.result.value {
                    let jsonResult = JSON(result)
                    let rate = jsonResult["last"].double! ?? 0.0
                    self.saveCurrentExchange(exchangeChoice, rate: rate)
                    
                    completion(choice: exchangeChoice, rate: rate)
                }
        }
    }
    
    func saveCurrentExchange(choice:Int, rate:Double) {
        // Save the value into local storage
        userDefaults.setValue(choice, forKey: AppDelegate.settingsKeys.KEY_SAVED_CURRENCY)
        userDefaults.setValue(rate, forKey: AppDelegate.settingsKeys.KEY_SAVED_RATE)
        userDefaults.synchronize()
    }
    
}
