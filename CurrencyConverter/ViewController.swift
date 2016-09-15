//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Luis Arias on 14/09/16.
//  Copyright © 2016 Luis Arias. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource {
    
    var inputCurrency: UITextField?
    var currencyPicker: UIPickerView?
    let currencyOptions = [0: "Pound sterling", 1: "Euro", 2: "Japanese Yen", 3: "Brazilian Real"]
    let currencyKey = ["GBP", "EUR", "JPY", "BRL"]
    var selectedRow: Int?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        setupViews()
    }
    
    func setupViews() {
        
        self.inputCurrency = {
            
            let input = UITextField()
            input.placeholder = "Currency I have"
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
        
        self.view.addSubview(inputCurrency!)
        self.view.addSubview(convertButton)
        self.view.addSubview(currencyPicker!)
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-30-[v0]-30-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": inputCurrency!]))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-30-[v0]-30-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": convertButton]))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-30-[v0]-30-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": currencyPicker!]))
        
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-100-[v0]-16-[v1][v2]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": inputCurrency!, "v1": convertButton, "v2": currencyPicker!]))
    }
    
    func convertCurrency() {
        if let value = inputCurrency?.text {
            print(value)
            if let row = selectedRow {
                print(currencyKey[row])
            } else {
                selectedRow = 0
            }
            
        } else {
            print("Text field required")
        }
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
        self.selectedRow = row
//        print(currencyOptions[row]!)
    }
    
}

