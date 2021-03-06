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
    
    var clockIns: [Date] = []
    var clockOuts: [Date] = []
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
    
        fillDatasource()
        setupTable(with: clockIns, and: clockOuts)
    }
    
    func fillDatasource() {
        
        if let clockIns = UserDefaults.standard.array(forKey: "clockins") as? [Date] {
            self.clockIns = clockIns
        }
        
        if let clockOuts = UserDefaults.standard.array(forKey: "clockouts") as? [Date] {
            self.clockOuts = clockOuts
        }
    }
    
    func setupTable(with clockIns: [Date], and clockOuts: [Date]) {
        
        table.setNumberOfRows(clockIns.count, withRowType: "ClockRow")
        
        for i in 0...9 {
            if let row = table.rowController(at: i) as? ClockRow {
                let timeInterval = Int(clockOuts[i].timeIntervalSince(clockIns[i]))
                row.clockLabel.setText(getTimeText(for: timeInterval))
            }
        }
    }
    
    func getTimeText(for timeInterval: Int) -> String {
        
        var timeString = ""
        
        let hours = timeInterval / 3600
        if hours > 0 {
            timeString += "\(hours)h "
        }
        
        let minutes = (timeInterval % 3600) / 60
        if minutes > 0 {
            timeString += "\(minutes)m "
        }
        
        let seconds = timeInterval % 60
        timeString += "\(seconds)s"
        
        return timeString
    }
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        pushController(withName: "DetailInterfaceController", context: [clockIns[rowIndex], clockOuts[rowIndex]])
    }

}
