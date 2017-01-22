//
//  SettingsViewController.swift
//  tip_calculator
//
//  Created by Jefferson Teng on 1/21/17.
//  Copyright © 2017 Jefferson Teng. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var peopleCountControl: UISegmentedControl!
    @IBOutlet weak var defaultTipStepper: UIStepper!
    @IBOutlet weak var defaultTipLabel: UILabel!
    private var defaultTipFormat = "%.0f"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        defaultTipStepper.minimumValue = 0
        defaultTipStepper.maximumValue = 99
    }
    
    override func viewWillAppear(animated: Bool) {
        let localStorageValue = readTipFromLocalStorage()
        defaultTipStepper.value = localStorageValue ?? 15.0
        defaultTipLabel.text = String(format: defaultTipFormat, defaultTipStepper.value)
        
        let peopleCountIndex = readPeopleCountIndexFromLocalStorage()
        peopleCountControl.selectedSegmentIndex = peopleCountIndex
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onPeopleCountSelection(sender: AnyObject) {
        writePeopleCountIndexToLocalStorage(peopleCountControl.selectedSegmentIndex)
    }

    @IBAction func updateDefaultTip(sender: AnyObject) {
        defaultTipLabel.text = String(format: defaultTipFormat, defaultTipStepper.value)
        writeTipToLocalStorage(defaultTipStepper.value)
    }
    
    func readTipFromLocalStorage() -> Double? {
        let defaults = NSUserDefaults.standardUserDefaults()
        return defaults.doubleForKey("default_tip_value_double")
    }
    
    func writeTipToLocalStorage(tipValue: Double?) {
        if tipValue == nil {
            return;
        }
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setDouble(tipValue!, forKey: "default_tip_value_double")
        defaults.synchronize()
    }
    
    func readPeopleCountIndexFromLocalStorage() -> NSInteger {
        let defaults = NSUserDefaults.standardUserDefaults()
        // returns 0 if key did not exist
        return defaults.integerForKey("default_people_count_index")
    }
    
    func writePeopleCountIndexToLocalStorage(index: NSInteger) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(index, forKey: "default_people_count_index")
        defaults.synchronize()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
