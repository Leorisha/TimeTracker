//
//  DetailInterfaceController.swift
//  Time Tracker WatchKit Extension
//
//  Created by Ana Neto on 31/05/2018.
//  Copyright © 2018 Ana Neto. All rights reserved.
//

import WatchKit
import Foundation


class DetailInterfaceController: WKInterfaceController {

    @IBOutlet var clockInLabel: WKInterfaceLabel!
    @IBOutlet var clockOutLabel: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        if let context = context as? [Date] {
            
            let clockIn = context[0]
            let clockOut = context[1]
            
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM d h:mm:ssa"
            
            clockInLabel.setText(formatter.string(from: clockIn))
            clockOutLabel.setText(formatter.string(from: clockOut))
        }
    }

}
