//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Luis Arias on 14/09/16.
//  Copyright © 2016 Luis Arias. All rights reserved.
//

import UIKit
import SwiftyJSON

enum Currency {
    
    case GBP, EUR, JPY, BRL
    
    func getStringValue() -> String {
        switch self {
        case .GBP:
            return "GBP"
        case .EUR:
            return "EUR"
        case .JPY:
            return "JPY"
        case .BRL:
            return "BRL"
        }
    }
}

class ViewController: UIViewController, UIPickerViewDataSource {
    
    let currencyOptions = ["Pound sterling", "Euro", "Japanese Yen", "Brazilian Real"]
    var inputCurrency: UITextField?
    var currencyPicker: UIPickerView?
    var selectedRow: Currency?
    var currencyValue: Double?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        navigationItem.title = "Currency converter"
        setupViews()
    }
    
    func setupViews() {
        
        self.inputCurrency = {
            
            let input = UITextField()
            input.placeholder = "Currency I have (USD)"
            input.borderStyle = UITextBorderStyle.RoundedRect
            input.keyboardType = UIKeyboardType.NumberPad
            input.translatesAutoresizingMaskIntoConstraints = false
            
            return input
            
        }()
        
        let convertButton: UIButton = {
            
            let button = UIButton()
            button.setTitle("Convert \u{1f4b8}", forState: .Normal)
            button.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self, action: #selector(ViewController.convertCurrency), forControlEvents: UIControlEvents.TouchUpInside)
            
            return button
            
        }()
        
        currencyPicker = {
           
            let picker = UIPickerView()
            picker.delegate = self
            picker.dataSource = self
            picker.translatesAutoresizingMaskIntoConstraints = false
            
            return picker
        }()
        
        //Add child views
        self.view.addSubview(inputCurrency!)
        self.view.addSubview(convertButton)
        self.view.addSubview(currencyPicker!)
        
        //Horizontal constraints
        self.view.addConstraintsWithFormat("H:|-30-[v0]-30-|", views: inputCurrency!)
        self.view.addConstraintsWithFormat("H:|-30-[v0]-30-|", views: convertButton)
        self.view.addConstraintsWithFormat("H:|-30-[v0]-30-|", views: currencyPicker!)
        
        //Vertical constraints
        self.view.addConstraintsWithFormat("V:|-100-[v0][v1][v2]", views: inputCurrency!, currencyPicker!, convertButton)
    }
    
    func convertCurrency() {
        
        if let value = inputCurrency?.text {
            let castedInputValue = Double(value)
            if self.selectedRow == nil {
                self.selectedRow = .GBP
            }
            
            API.getCurrencyValue((selectedRow?.getStringValue())!) { value, error in
                if let val = value {
                    self.parseData(val)
                    print(val)
                    if let currency = self.currencyValue {
                        if let inValConverted = castedInputValue {
                            print(self.calculateConvertion(inValConverted, newCurrencyValue: currency))
                            self.pushCharView(self.calculateConvertion(inValConverted, newCurrencyValue: currency))
                        }
                    }
                } else {
                    print(error)
                }
            }
        } else {
            print("Text field required")
        }
    }
    
    func pushCharView(value: Double) {
        let charViewController = ChartViewController()
        let strValue = String(value)
        charViewController.convertedCurrencyString = strValue
        
        let navigationViewController = UINavigationController(rootViewController: charViewController)
        
        self.presentViewController(navigationViewController, animated: true, completion: nil)
    }
    
    func parseData(response: NSDictionary) -> Double? {
        let json = JSON(response)
        
        self.currencyValue = json["rates"][(selectedRow?.getStringValue())!].doubleValue
        
        return self.currencyValue
    }
    
    func calculateConvertion(inputValue: Double, newCurrencyValue: Double) -> Double {
        return inputValue * newCurrencyValue
    }
}

extension ViewController: UIPickerViewDelegate {
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyOptions.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyOptions[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.assignSelected(row)
    }
    
    func assignSelected(row: Int) {
        
        switch row {
        case 1:
            self.selectedRow = .EUR
        case 2:
            self.selectedRow = .JPY
        case 3:
            self.selectedRow = .BRL
        default:
            self.selectedRow = .GBP
            
        }
    }
}

extension UIView {
    
    func addConstraintsWithFormat(format: String, views: UIView...) {
        
        var viewsDictionary = [String: UIView]()
        
        for (index, view) in views.enumerate() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
        
    }
    
}

