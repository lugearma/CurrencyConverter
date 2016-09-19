//
//  ChartViewController.swift
//  CurrencyConverter
//
//  Created by Luis Arias on 19/09/16.
//  Copyright © 2016 Luis Arias. All rights reserved.
//

import Charts

class ChartViewController: UIViewController {
    
    var convertedCurrencyLabel = UILabel()
    var convertedCurrencyString = String() {
        didSet {
            self.convertedCurrencyLabel.text = convertedCurrencyString
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        setupView()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: #selector(ChartViewController.hideModal))
        navigationItem.title = "Chart"
        
    }
    
    func setupView() {
        
        self.convertedCurrencyLabel = {
            let label = UILabel()
            
            label.textColor = UIColor.blackColor()
            label.text = convertedCurrencyString
            
            return label
        }()
        
        self.view.addSubview(convertedCurrencyLabel)
        
        //Horizontal constraints
        self.view.addConstraintsWithFormat("H:|-30-[v0]-30-|", views: convertedCurrencyLabel)
        
        
        //Vertical constraints
        self.view.addConstraintsWithFormat("V:|-100-[v0]", views: convertedCurrencyLabel)
        
    }
    
    func hideModal() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
