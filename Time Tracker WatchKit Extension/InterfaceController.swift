//
//  InterfaceController.swift
//  Time Tracker WatchKit Extension
//
//  Created by Ana Neto on 30/05/2018.
//  Copyright © 2018 Ana Neto. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet var timeLabel: WKInterfaceLabel!
    @IBOutlet var totalTimeLabel: WKInterfaceLabel!
    @IBOutlet var clockButton: WKInterfaceButton!
    
    var clockedIn: Bool = false
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        updateUI(with: clockedIn)
    }
    
    @IBAction func clockButtonTapped() {
        clockedIn ? clockOut() : clockIn()
        updateUI(with: clockedIn)
    }
    
    func updateUI(with clockedIn: Bool) {
        clockButton.setTitle(clockedIn ? "Clock-out": "Clock-in")
        totalTimeLabel.setHidden(!clockedIn)
        timeLabel.setText(getTimeText())
        clockButton.setBackgroundColor(clockedIn ? .red : .green)
    }
    
    func getTimeText() -> String {
        var time = clockedIn ? "" : "Today\n"
        time.append(clockedIn ? "1m:2s" : "3h:4m")
        return time
    }
    
    func clockIn() {
        clockedIn = true
        UserDefaults.standard.set(Date(), forKey: "clocked_in")
    }
    
    func clockOut() {
        addClockTime(with: clockedIn)
        clockedIn = false
        addClockTime(with: clockedIn)
    }
    
    func addClockTime(with clockedIn: Bool) {
        
        let timeKey = clockedIn ? "clocked_in" : "clocked_out"
        let arrayKey = clockedIn ? "clockins" : "clockouts"
        
        if let time = UserDefaults.standard.object(forKey: timeKey) as? Date {
            if var timeArray  = UserDefaults.standard.array(forKey: arrayKey) as? [Date] {
                timeArray.insert(time, at: 0)
                UserDefaults.standard.set(timeArray, forKey: arrayKey)
                print(timeArray)
            } else {
                UserDefaults.standard.set([time], forKey: arrayKey)
            }
        }
    }
    
}
