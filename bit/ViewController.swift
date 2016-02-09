//
//  ViewController.swift
//  bit
//
//  Created by Anthony on 2016-02-03.
//  Copyright © 2016 Anthony Smith. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    private let htmlUrl:String = "https://api.bitcoinaverage.com/exchanges/CAD"
    
    @IBOutlet weak var lblCurrentBits: UILabel!
    @IBOutlet weak var lblConvertedAmount: UILabel!
    @IBOutlet weak var lblConversionRate: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        loadConversionRate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadConversionRate() {
        Alamofire.request(.GET, self.htmlUrl)
            .responseJSON { response in
            print(response.result.value)
        }
    }
    
    // Changes the status bar text colour to white.
    // For some reason changing it in the storyboard doesn't work.
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

}

