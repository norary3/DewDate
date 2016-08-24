//
//  AddTableViewController.swift
//  DewDate
//
//  Created by cscoi027 on 2016. 8. 24..
//  Copyright © 2016년 Koreauniv. All rights reserved.
//

import UIKit
import EventKit

extension String {
    public func indexOfCharacter(char: Character) -> Int? {
        if let idx = self.characters.indexOf(char) {
            return self.startIndex.distanceTo(idx)
        }
        return nil
    }
    
    func toDateTime(dateFormatter:NSDateFormatter) -> NSDate
    {
        //Parse into NSDate
        let dateFromString : NSDate = dateFormatter.dateFromString(self)!
        
        //Return Parsed Date
        return dateFromString
    }
}

extension NSDate
{
    func year() -> Int
    {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Year, fromDate: self)
        let year = components.year
        
        return year
    }
    
    func month() -> Int
    {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Month, fromDate: self)
        let month = components.month
        
        return month
    }
    
    func day() -> Int
    {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Day, fromDate: self)
        let day = components.day
        
        return day
    }
    
    func hour() -> Int
    {
        //Get Hour
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Hour, fromDate: self)
        let hour = components.hour
        
        //Return Hour
        return hour
    }
    
    
    func minute() -> Int
    {
        //Get Minute
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Minute, fromDate: self)
        let minute = components.minute
        
        //Return Minute
        return minute
    }
    
    func toTimeString(formatter:NSDateFormatter) -> String
    {
        //Get Time String
        
        let timeString = formatter.stringFromDate(self)
        
        //Return Time String
        return timeString
    }
    
}

class AddTableViewController: UITableViewController {
    var convertingString: String?
    let cal = NSCalendar.currentCalendar()
    
    var eventTitle:String = ""
    var eventLocation = ""
    var eventIsAllDay = false
    var eventStart:NSDate = NSDate()
    var eventEnd:NSDate = NSDate()
    //var eventRepeat:EKRecurrenceRule? = nil
    //var eventAlarm:EKAlarm? = nil
    var eventURL:NSURL = NSURL()
    var eventMemo = ""
    
    //Create Date Formatter
    var dateFormatter = NSDateFormatter()
    
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var endLabel: UILabel!
    //@IBOutlet weak var repeatLabel: UILabel!
    //@IBOutlet weak var alarmLabel: UILabel!
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var memoTextField: UITextView!
    
    @IBAction func isAllDaySwitch(sender: AnyObject) {
        let allDaySwitch = sender as! UISwitch
        let allDayBool:Bool = allDaySwitch.on
        self.eventIsAllDay = allDayBool
        if eventIsAllDay {
            //Specify Format of String to Parsez
            self.dateFormatter.dateFormat = "yyyy-MM-dd"
            self.startDatePickerValue.datePickerMode = UIDatePickerMode.Date
            self.endDatePickerValue.datePickerMode = UIDatePickerMode.Date
            self.startLabel.text = self.eventStart.toTimeString(self.dateFormatter)
            self.endLabel.text = self.eventEnd.toTimeString(self.dateFormatter)
        } else {
            //Specify Format of String to Parsez
            self.dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
            self.startDatePickerValue.datePickerMode = UIDatePickerMode.DateAndTime
            self.endDatePickerValue.datePickerMode = UIDatePickerMode.DateAndTime
            self.startLabel.text = self.eventStart.toTimeString(self.dateFormatter)
            self.endLabel.text = self.eventEnd.toTimeString(self.dateFormatter)
        }
    }
    
    @IBOutlet weak var startDatePickerValue: UIDatePicker!
    @IBAction func startDatePicker(sender: AnyObject) {
        //self.endCheck()
        self.eventStart = startDatePickerValue.date
        self.startLabel.text = eventStart.toTimeString(self.dateFormatter)
    }
    
    @IBOutlet weak var endDatePickerValue: UIDatePicker!
    @IBAction func endDatePicker(sender: AnyObject) {
        //self.endCheck()
        self.eventEnd = endDatePickerValue.date
        self.endLabel.text = eventEnd.toTimeString(self.dateFormatter)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Specify Format of String to Parse
        self.dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        dispatch_async(dispatch_get_main_queue()){
            self.titleTextField.text = self.eventTitle
            self.locationTextField.text = self.eventLocation
            self.startLabel.text = self.eventStart.toTimeString(self.dateFormatter)
            self.endLabel.text = self.eventEnd.toTimeString(self.dateFormatter)
            self.memoTextField.text = self.eventMemo
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            return 2
        case 1:
            return 5
        case 2:
            return 2
        default:
            return 0
            
        }
    }
    
    /*
     override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
     if editingStyle == .Delete {
     // Delete the row from the data source
     tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
     } else if editingStyle == .Insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
        if segue.identifier == "AddUnwind" {
            let eventStore = EKEventStore()
            
            if let newEventTitle = self.titleTextField.text { self.eventTitle =  newEventTitle }
            if let newEventLocation = self.locationTextField.text { self.eventLocation = newEventLocation }
            if let newEventStart = self.startLabel.text?.toDateTime(self.dateFormatter) { self.eventStart = newEventStart }
            if let newEventEnd = self.endLabel.text?.toDateTime(self.dateFormatter) { self.eventEnd = newEventEnd }
            if let newEventURL = NSURL(string: self.urlTextField.text!) { self.eventURL = newEventURL }
            if let newEventMemo = self.memoTextField.text { self.eventMemo = newEventMemo }
            
            if (EKEventStore.authorizationStatusForEntityType(.Event) != EKAuthorizationStatus.Authorized) {
                eventStore.requestAccessToEntityType(.Event, completion: {
                    granted, error in
                    if granted {
                        self.createEvent(eventStore)
                    } else {
                        self.failAlert()
                    }
                })
            } else {
                self.createEvent(eventStore)
            }

        }
    }
    
    
    var StartPickerRowHeight:CGFloat = 0.0
    var EndPickerRowHeight:CGFloat = 0.0
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath {
        case NSIndexPath(forRow: 1, inSection: 1):
            startDatePickerValue.setDate(self.eventStart, animated: false)
            if StartPickerRowHeight < 100 { StartPickerRowHeight = 210.0 }
            else { StartPickerRowHeight = 0.0 }
            self.tableView.reloadData()
        case NSIndexPath(forRow: 3, inSection: 1):
            endDatePickerValue.setDate(self.eventEnd, animated: false)
            if EndPickerRowHeight < 100 { EndPickerRowHeight = 210.0 }
            else { EndPickerRowHeight = 0.0 }
            self.tableView.reloadData()
        default:
            if indexPath != NSIndexPath(forRow: 2, inSection: 1) && indexPath != NSIndexPath(forRow: 4, inSection: 1) {
                StartPickerRowHeight = 0.0
                EndPickerRowHeight = 0.0
                self.tableView.reloadData()
            }
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        switch indexPath {
        case NSIndexPath(forRow: 2, inSection: 1):
            return StartPickerRowHeight
        case NSIndexPath(forRow: 4, inSection: 1):
            return EndPickerRowHeight
        case NSIndexPath(forRow: 1, inSection: 2):
            return 150.0
        default:
            return 44.0
        }
    }
    
    
    // Creates an event in the EKEventStore. The method assumes the eventStore is created and
    // accessible
    func createEvent(eventStore: EKEventStore) {
        let event = EKEvent(eventStore: eventStore)
        event.title = self.eventTitle
        event.allDay = self.eventIsAllDay
        event.startDate = self.eventStart
        event.endDate = self.eventEnd
        event.location = self.eventLocation
        event.notes = self.eventMemo
        event.URL = self.eventURL
        /*
         if let alarm = self.eventAlarm {
         event.alarms = [alarm]
         }
         */
        event.calendar = eventStore.defaultCalendarForNewEvents
        
        do {
            try eventStore.saveEvent(event, span: .ThisEvent)
        } catch {
            print("Bad things happened creating evnet")
        }
    }
    
    func failAlert() {
        let addAlert = UIAlertController(title: "\(self.eventTitle) 일정을 저장할 수 없습니다. DewDate가 캘린더에 접근할 수 있도록 허가해 주세요", message: nil, preferredStyle: .ActionSheet)
        let exitAction = UIAlertAction(title: "종료", style: .Cancel, handler: { (action:UIAlertAction) -> Void in
            print ("종료 선택")
            })
        addAlert.addAction(exitAction)
        self.presentViewController(addAlert, animated: true, completion: nil)
    }
    
}