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
        updateUI()
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
        updateUI()
    }
    
    func updateUI() {
        clockButton.setTitle(clockedIn ? "Clock-out": "Clock-in")
        totalTimeLabel.setHidden(!clockedIn)
    }
}
