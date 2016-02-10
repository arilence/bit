//
//  ViewController.swift
//  bit
//
//  Created by Anthony on 2016-02-03.
//  Copyright © 2016 Anthony Smith. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    private let htmlUrl:String = "https://api.bitcoinaverage.com/exchanges/CAD"
    
    @IBOutlet weak var lblCurrentBits: UILabel!
    @IBOutlet weak var lblConvertedAmount: UILabel!
    @IBOutlet weak var lblConversionRate: UILabel!
    
    private var currentBits:Float = 0
    private var convertedAmount:Float = 0
    private var conversionRate:Float = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        loadConversionRate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
     * Show a popup for the user to enter their bitcoin amount
     */
    @IBAction func getBitCoinAmount(sender: AnyObject) {
        let _ = PopupTextField().showTextField(self, completion: {
            (result: String) in
            self.updateCurrentBits(result)
        })
    }
    
    func loadConversionRate() {
        Alamofire.request(.GET, self.htmlUrl)
            .responseJSON { response in
                let jsonResponse = response.result.value!
                let jsonOBJ = JSON(jsonResponse)
                
                let rate = jsonOBJ["coinbase"]["rates"]["bid"].float!
                self.updateConversionRate(rate)
        }
    }
    
    func updateCurrentBits(input:String) {
        let bits = validBitcoin(input)
        if (bits.isNormal) {
            currentBits = bits
            lblCurrentBits.text = String(self.currentBits)
            updateConvertedAmount()
        }
    }
    
    func updateConvertedAmount() {
        convertedAmount = currentBits * conversionRate
        lblConvertedAmount.text = "$" + String(convertedAmount)
    }
    
    func updateConversionRate(input:Float) {
        conversionRate = input
        lblConversionRate.text = "$1 ≈ " + String(conversionRate) + " BTC"
    }
    
    func validBitcoin(input:String) -> Float {
        let output = Float(input)
        if (output != nil) {
            return output!
        } else {
            return 0
        }
    }
    
    // Changes the status bar text colour to white.
    // For some reason changing it in the storyboard doesn't work.
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

}

