//
//  HistoryInterfaceController.swift
//  Time Tracker WatchKit Extension
//
//  Created by Ana Neto on 31/05/2018.
//  Copyright © 2018 Ana Neto. All rights reserved.
//

import WatchKit
import Foundation


class HistoryInterfaceController: WKInterfaceController {

    @IBOutlet var table: WKInterfaceTable!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
