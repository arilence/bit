//
//  OfflineData.swift
//  bit
//
//  Created by Anthony on 2016-03-03.
//  Copyright © 2016 Anthony Smith. All rights reserved.
//

import Foundation
import RealmSwift

class OfflineData: Object {
    
    dynamic var lastExchange = 0.0
    dynamic var lastWalletValue = 0.0
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
