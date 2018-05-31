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
        time.append(getTimeText(for: totalClockedTime()))
        return time
    }
    
    func clockIn() {
        clockedIn = true
        UserDefaults.standard.set(Date(), forKey: "clocked_in")
        startClock()
    }
    
    func clockOut() {
        clockedIn = false
        addClockedTime()
    }
    
    func addClockedTime() {
        if let clockedIn = UserDefaults.standard.object(forKey: "clocked_in") as? Date {
            
            if var clockins  = UserDefaults.standard.array(forKey: "clockins") as? [Date] {
                clockins.insert(clockedIn, at: 0)
                UserDefaults.standard.set(clockins, forKey: "clockins")
            } else {
                UserDefaults.standard.set([clockedIn], forKey: "clockins")
            }
            
            if var clockouts  = UserDefaults.standard.array(forKey: "clockouts") as? [Date] {
                clockouts.insert(Date(), at: 0)
                UserDefaults.standard.set(clockouts, forKey: "clockouts")
            } else {
                UserDefaults.standard.set([Date()], forKey: "clockouts")
            }
            
            UserDefaults.standard.set(nil, forKey: "clocked_in")
        }
    }
    
    func startClock() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if let clockedInTime = UserDefaults.standard.object(forKey: "clocked_in") as? Date {
                
                let timeInterval = Int(Date().timeIntervalSince(clockedInTime))
                self.timeLabel.setText(self.getTimeText(for: timeInterval))
                self.totalTimeLabel.setText("Today: " + self.getTimeText(for: timeInterval + self.totalClockedTime()))
            }
        }
    }
    
    func getTimeText(for timeInterval: Int) -> String {
        
        let hours = timeInterval / 3600
        let minutes = (timeInterval % 3600) / 60
        let seconds = timeInterval % 60
        
        return "\(hours)h \(minutes)m \(seconds)s"
    }
    
    func totalClockedTime() -> Int {
        
        var totalTime = 0
        
        guard let clockins  = UserDefaults.standard.array(forKey: "clockins") as? [Date], let clockouts = UserDefaults.standard.array(forKey: "clockouts") as? [Date] else {
                return totalTime
        }
        
        for i in 0...clockins.count-1 {
            let time = Int(clockouts[i].timeIntervalSince(clockins[i]))
            totalTime += time
        }
        
        print(totalTime)
        return totalTime
    }
    
}
