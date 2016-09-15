//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Luis Arias on 14/09/16.
//  Copyright © 2016 Luis Arias. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        setupViews()
    }
    
    func setupViews() {
        
        let inputCurrency: UITextField = {
            
            let input = UITextField(frame: CGRect(x: 0.0, y: 100.0, width: 150.0, height: 60.0))
            input.placeholder = "Currency I have"
            input.borderStyle = UITextBorderStyle.RoundedRect
            input.keyboardType = UIKeyboardType.NumberPad
            input.translatesAutoresizingMaskIntoConstraints = false
            
            return input
            
        }()
        
        self.view.addSubview(inputCurrency)
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-30-[v0]-30-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": inputCurrency]))
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-100-[v0]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": inputCurrency]))
        
    }
}

