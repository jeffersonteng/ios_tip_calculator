//
//  ViewController.swift
//  tip_calculator
//
//  Created by Jefferson Teng on 1/20/17.
//  Copyright © 2017 Jefferson Teng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var peopleCountLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipPercentButton: UIButton!
    private var peopleCountArr = [1, 2, 3, 4]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Open keyboard on app open, not on return from Settings
        billField.becomeFirstResponder()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let tipValue = readTipFromLocalStorage()
        tipPercentButton.setTitle(String(format: "%.0f%%", tipValue ?? "15%"), forState: UIControlState.Normal)
        
        peopleCountLabel.text = String(format: "%d", peopleCountArr[readPeopleCountFromLocalStorage()])
        
        refreshTipValues()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        print("view will disappear")
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        print("view did disappear")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    func readTipFromLocalStorage() -> Double? {
        let defaults = NSUserDefaults.standardUserDefaults()
        return defaults.doubleForKey("default_tip_value_double")
    }
    
    func readPeopleCountFromLocalStorage() -> NSInteger {
        let defaults = NSUserDefaults.standardUserDefaults()
        return defaults.integerForKey("default_people_count_index")
    }
    
    func refreshTipValues() {
        let tipValue = readTipFromLocalStorage() ?? 0
        let tipPercentage = 0.01 * tipValue
        
        let preTipBill = Double(billField.text!) ?? 0
        let tipAmount = tipPercentage * preTipBill
        tipLabel.text = String(format: "$%.2f", tipAmount)
        
        let peopleCount = peopleCountArr[readPeopleCountFromLocalStorage()]
        
        totalLabel.text = String(format: "$%.2f", (preTipBill + tipAmount) / Double(peopleCount))
    }

    @IBAction func onBillValueChanged(sender: AnyObject) {
        refreshTipValues()
    }
}

