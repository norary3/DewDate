//
//  LoadViewExampleViewController.swift
//  SwiftExample
//
//  Created by dingwenchao on 10/17/16.
//  Copyright © 2016 wenchao. All rights reserved.
//

import UIKit
import EventKit

class MonthlyViewController:UIViewController, FSCalendarDataSource, FSCalendarDelegate {
    
    @IBOutlet weak var calendar: FSCalendar!
    
    private let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()
    private let gregorian: NSCalendar! = NSCalendar(calendarIdentifier:NSCalendar.Identifier.gregorian)
    
    /*
    let datesWithCat = ["2015/05/05","2015/06/05","2015/07/05","2015/08/05","2015/09/05","2015/10/05","2015/11/05","2015/12/05","2016/01/06",
                        "2016/02/06","2016/03/06","2016/04/06","2016/05/06","2016/06/06","2016/07/06"]
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //calendar.appearance.caseOptions = [.headerUsesUpperCase,.weekdayUsesUpperCase]
        //calendar.select(self.formatter.date(from: "2015/10/10")!)
        //calendar.scope = .week
        calendar.scopeGesture.isEnabled = true
        calendar.appearance.headerDateFormat = "MMM yy" // ex) "Jul 15"
        calendar.scrollDirection = .vertical // vertical scroll of month
        //calendar.allowsMultipleSelection = true
        
        // Uncomment this to test month->week and week->month transition
        /*
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + (2.5 * Double(NSEC_PER_SEC))) {
            self.calendar.setScope(.week, animated: true)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + (1.5 * Double(NSEC_PER_SEC))) {
                self.calendar.setScope(.month, animated: true)
            }
        }
        */
        
        
    }
    
    /*
    func minimumDate(for calendar: FSCalendar) -> Date {
        return self.formatter.date(from: "2015/01/01")!
    }
    
    func maximumDate(for calendar: FSCalendar) -> Date {
        return self.formatter.date(from: "2016/10/31")!
    }
     */
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let startDate = date
        let endDate = date.addingTimeInterval(60*60*24*1)
        let events = readEvents(startDate : startDate, endDate: endDate)
        return (events?.count)!
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        NSLog("change page to \(self.formatter.string(from: calendar.currentPage))")
    }
    
    // Update your frame
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendar.frame = CGRect(x: 0, y: self.navigationController!.navigationBar.frame.maxY, width: bounds.width, height: bounds.height)
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if monthPosition == .previous || monthPosition == .next {
            calendar.setCurrentPage(date, animated: true)
        }
        calendar.setScope(.week, animated: true)
    
    }
    
    // FSCalendarDataSource
    // function for runa calendar
    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
        if gregorian.component(.weekday, from: date) == 4 {
            return "(음) 5.5"
        } else {
            return ""
        }
    }
    
}

