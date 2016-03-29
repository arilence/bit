//
//  Network.swift
//  bit
//
//  Created by Anthony on 2016-03-22.
//  Copyright © 2016 Anthony Smith. All rights reserved.
//

import ReachabilitySwift

public class Network {
    
    private var reachability: Reachability!
    private var reachable:Bool = false
    
    init () {
        do {
            reachability = try Reachability.reachabilityForInternetConnection()
        } catch {
            print("Unable to create Reachability")
            return
        }
    }
    
    public func startChecking(connected:() -> Void, notConnected:() -> Void) {
        reachability.whenReachable = { reachability in
            // this is called on a background thread, but UI updates must
            // be on the main thread, like this:
            dispatch_async(dispatch_get_main_queue()) {
                self.reachable = true
                connected()
                print("Reachable")
            }
        }
        reachability.whenUnreachable = { reachability in
            // this is called on a background thread, but UI updates must
            // be on the main thread, like this:
            dispatch_async(dispatch_get_main_queue()) {
                self.reachable = false
                notConnected()
                print("Not reachable")
            }
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    public func isReachable() -> Bool {
        return self.reachable
    }
    
}
