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
        
        table.setNumberOfRows(10, withRowType: "ClockRow")
        
        for i in 0...9 {
            if let row = table.rowController(at: i) as? ClockRow {
                row.clockLabel.setText("\(i)")
            }
        }
    }

}
