//
//  ViewController.swift
//  ITRex Group Test
//
//  Created by Женя  on 9.02.22.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var selectFromCurrencybutton: UIButton!
    @IBOutlet weak var selectToCurrencybutton: UIButton!
    @IBOutlet weak var fromCurrencyTextField: UITextField!
    @IBOutlet weak var toCurrencyTextField: UITextField!
    
    //MARK: - Property
    
    //Info from Api
    var currencyConvertDictionary = ["CAD":1.3448367167,"HKD":7.7501323919,"ISK":131.4210061783,"PHP":49.8296557811,"DKK":6.5811120918,"HUF":304.1659311562,"CZK":23.4677846425,"GBP":0.7894792586,"RON":4.2702559576,"SEK":9.2012356575,"IDR":14018.0052956752,"INR":75.5781112092,"BRL":5.059929391,"RUB":68.6809355693,"HRK":6.6827007944,"JPY":109.2409532215,"THB":31.4651368049,"CHF":0.9590467785,"EUR":0.8826125331,"MYR":4.2669902913,"BGN":1.7262135922,"TRY":6.7737864078,"CNY":7.0917034422,"NOK":9.3030008826,"NZD":1.5350397176,"ZAR":16.8422771403,"USD":1.0,"MXN":21.7533980583,"SGD":1.392321271,"AUD":1.4322153575,"ILS":3.4573698147,"KRW":1205.2691968226,"PLN":3.9210061783]
    
    var fromCurrency = ""
    var toCurrency = ""
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: - Logic
    
    @IBAction func selectFromCurrencyButtonAction(_ sender: UIButton) {
        
        let list = UIAlertController(title: "Select From Currency", message: nil, preferredStyle: .actionSheet)
        
        for key in self.currencyConvertDictionary.keys {
            
            let action = UIAlertAction(title: key, style: .default) { (action) in
                
                self.fromCurrency = key
                self.selectFromCurrencybutton.setTitle(key, for: .normal)
                self.toCurrencyTextField.text = ""
                
            }
            list.addAction(action)
        }
        if let popoverPresentationController = list.popoverPresentationController {
            popoverPresentationController.sourceView = self.view
            popoverPresentationController.sourceRect = sender.bounds
        }
        self.present(list, animated: true, completion: nil)
    }
    
    @IBAction func selectToCurrencyButtonAction(_ sender: UIButton) {
        
        let list = UIAlertController(title: "Select To Currency", message: nil, preferredStyle: .actionSheet)
        
        for key in self.currencyConvertDictionary.keys {
            
            let action = UIAlertAction(title: key, style: .default) { (action) in
                
                self.toCurrency = key
                
                self.selectToCurrencybutton.setTitle(key, for: .normal)
                self.toCurrencyTextField.text = ""
            }
            
            list.addAction(action)
        }
        if let popoverPresentationController = list.popoverPresentationController {
            popoverPresentationController.sourceView = self.view
            popoverPresentationController.sourceRect = sender.bounds
        }
        self.present(list, animated: true, completion: nil)
    }
    
    @IBAction func convertButtonAction(_ sender: Any) {
        // Convert from and To Currency to USD
        //LOGIC
        //1 USD = 1.35 CAD
        //        1 CAD = 1/1.35 USD
        //        1 CAD = 0.74 USD
        //        1 USD = 75.20 INR
        //        1 CAD = 0.74 USD = 0.74 * 75.20 INR = 55.65 INR
        if let fromCurrencyRate = currencyConvertDictionary[fromCurrency], let toCurrencyRate = currencyConvertDictionary[toCurrency], let textFieldVal = fromCurrencyTextField.text, let val: Double = Double(textFieldVal) {
            let usdVal = 1.0/fromCurrencyRate
            let toCurrencyVal = usdVal * toCurrencyRate
            let totalVal = val * toCurrencyVal
            self.toCurrencyTextField.text = String(format:"%.2f", totalVal)
            //
        }
        
    }
    
}

