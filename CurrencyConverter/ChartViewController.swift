//
//  ChartViewController.swift
//  CurrencyConverter
//
//  Created by Luis Arias on 19/09/16.
//  Copyright © 2016 Luis Arias. All rights reserved.
//

import Charts
import SwiftyJSON

class ChartViewController: UIViewController, ChartViewDelegate {
    
    let currencies = ["GBP" , "EUR", "JPY", "BRL"]
    var currencyValue = [Double]()
    var barCharView = BarChartView(frame: CGRect(x: 30, y: 120, width: 300, height: 300))
    
    var convertedCurrencyLabel = UILabel()
    var convertedCurrencyString = String() {
        didSet {
            self.convertedCurrencyLabel.text = convertedCurrencyString
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        setupViews()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: #selector(ChartViewController.hideModal))
        navigationItem.title = "Chart"
        getData()
    }
    
    func setupChar() {
        self.barCharView.delegate = self
        self.barCharView.descriptionText = "Tap node for details"
        self.barCharView.descriptionTextColor = UIColor.whiteColor()
        self.barCharView.gridBackgroundColor = UIColor.darkGrayColor()
        self.barCharView.tintColor = UIColor.darkGrayColor()
        self.barCharView.noDataText = "No data provided"
        self.barCharView.translatesAutoresizingMaskIntoConstraints = false
        
        self.setChartData(currencies)
    }
    
    func setChartData(months : [String]) {
        var yVals1 = [BarChartDataEntry]()

        for index in 0 ..< currencies.count {
            yVals1.append(BarChartDataEntry(value: currencyValue[index], xIndex: index))
        }
        
        let set1 = BarChartDataSet(yVals: yVals1, label: "Hola")
        
        set1.axisDependency = .Left
        set1.setColor(UIColor.redColor())
        set1.barBorderColor = UIColor.redColor()
        set1.highlightColor = UIColor.orangeColor()

        var dataSets = [BarChartDataSet]()
        dataSets.append(set1)

        let data = BarChartData(xVals: months, dataSets: dataSets)
        data.setValueTextColor(UIColor.blackColor())
        
        self.barCharView.data = data
    }
    
    func getData() {
        API.getAllCurrency({
            value, error in
            if let val = value {
                self.parseData(val)
                self.setupChar()
            } else {
                print(error.debugDescription)
            }
        })
    }
    
    func parseData(response: NSDictionary) -> [Double] {
        let json = JSON(response)
        
        for currency in currencies {
            self.currencyValue.append(json["rates"][currency].doubleValue)
        }

        return self.currencyValue
    }
    
    func setupViews() {
        
        self.convertedCurrencyLabel = {
            let label = UILabel()
            
            label.textColor = UIColor.blackColor()
            label.textAlignment = NSTextAlignment.Center
            label.text = convertedCurrencyString
            
            return label
        }()
        
        let messageLabel: UILabel = {
            let label = UILabel()
            
            label.textColor = UIColor.blackColor()
            label.textAlignment = NSTextAlignment.Center
            label.text = "New value of your money 💶💵💷"
            
            return label
        }()
        
        self.view.addSubview(messageLabel)
        self.view.addSubview(convertedCurrencyLabel)
        self.view.addSubview(barCharView)

        
        //Horizontal constraints
        self.view.addConstraintsWithFormat("H:|-30-[v0]-30-|", views: messageLabel)
        self.view.addConstraintsWithFormat("H:|-30-[v0]-30-|", views: convertedCurrencyLabel)
//        self.view.addConstraintsWithFormat("H:|-30-[v0]-30-|", views: barCharView)
        
        
        //Vertical constraints
        self.view.addConstraintsWithFormat("V:|-100-[v0]-16-[v1]", views: messageLabel,convertedCurrencyLabel)
        
    }
    
    func hideModal() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
