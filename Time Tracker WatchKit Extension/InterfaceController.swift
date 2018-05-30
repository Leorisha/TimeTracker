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
        
        // Configure interface objects here.
        updateUI(with: clockedIn)
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func clockButtonTapped() {
        clockedIn = !clockedIn
        updateUI(with: clockedIn)
    }
    
    func updateUI(with clockedIn: Bool) {
        clockButton.setTitle(clockedIn ? "Clock-out": "Clock-in")
        totalTimeLabel.setHidden(!clockedIn)
        
        timeLabel.setText(getTimeText())
    }
    
    func getTimeText() -> String {
        var time = clockedIn ? "" : "Today\n"
        time.append(clockedIn ? "1m:2s" : "3h:4m")
        return time
    }
}
