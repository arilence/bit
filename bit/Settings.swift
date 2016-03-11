//
//  Settings.swift
//  bit
//
//  Created by Anthony on 2016-03-10.
//  Copyright © 2016 Anthony Smith. All rights reserved.
//

public class Settings {
    
    public enum settingsKeys {
        static let KEY_CURRENCY = "currency_key"
        static let KEY_EXCHANGE_CURRENCY = "exchange_curr_key"
        static let KEY_EXCHANGE_RATE = "exchange_rate_key"
    }

    public static let settingsCurrency = [
        "CAD",
        "USD",
        "JPY",
        "GBP",
        "EUR",
        "AUD"
    ]
    
}