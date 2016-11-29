//
//  InitialTableViewController.swift
//  DewDate
//
//  Created by kang on 2016. 8. 18..
//  Copyright © 2016년 Koreauniv. All rights reserved.
//

import UIKit
import EventKit

var titles : [String] = []
var startDates : [NSDate] = []
var endDates : [NSDate] = []
var hasNotess : [String] = []


var number:Int = 0

class InitialTableViewController: UITableViewController {
    var myEvents:[Event] = []
    var another_number:Int = 0
    
    let colorArray = Array(arrayLiteral: UIColor.blackColor(), UIColor.redColor(), UIColor.orangeColor(), UIColor.blueColor(), UIColor.darkGrayColor())
    
    var temp : [String:[String:Int]] = ["MeetingRooms":["what":1,"Should":2],"Temp":["I":3,"write":4]]
    
    func readEvents() {
        let eventStore = EKEventStore()
        let calendars = eventStore.calendarsForEntityType(.Event)
        for calendar in calendars {
            let oneMonthAgo = NSDate(timeIntervalSinceNow: -90*24*3600)
            let oneMonthAfter = NSDate(timeIntervalSinceNow: +90*24*3600)
            
            let predicate = eventStore.predicateForEventsWithStartDate(oneMonthAgo, endDate: oneMonthAfter, calendars: [calendar])
            
            let events = eventStore.eventsMatchingPredicate(predicate)
            
            for event in events{
                if let url = event.URL, memo = event.notes {
                    
                    let newEvent = Event(title: event.title,location:event.location!, isAllDay: event.allDay, startDate: event.startDate, endDate: event.endDate,eventIdentifier: event.eventIdentifier, url: url, memo: memo)
                    myEvents += [newEvent]
                } else {
                    let newEvent = Event(title: event.title,location:event.location!, isAllDay: event.allDay, startDate: event.startDate, endDate: event.endDate,eventIdentifier: event.eventIdentifier, url: NSURL(string: "")!, memo:"")
                    myEvents += [newEvent]
                }
                
            }
        }
        myEvents.sortInPlace( { (older, recent) -> Bool in
            if older.startDate.compare(recent.startDate) == NSComparisonResult.OrderedAscending {
                return true
            } else {
                return false
            }
        })
        //print("myEvents.count: \(myEvents.count)")
    }


    //override func viewDidAppear(animated: Bool) {
    override func viewDidLoad() {
        myEvents = []
        let eventStore = EKEventStore()
        
        switch EKEventStore.authorizationStatusForEntityType(.Event) {
            case .Authorized:
                readEvents()
            case .Denied:
                print("Access denied")
            case .NotDetermined:
                eventStore.requestAccessToEntityType(.Event, completion: { (granted: Bool, NSError) -> Void in
                    if granted {
                        self.readEvents()
                    }
                    else{
                        print("Access denied")
                    }
                })
            default:
                print("Case Default")
            }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.myEvents.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
//        let values = Array(temp.values)[section]
        
        return 1
    }

        
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("EventCell", forIndexPath: indexPath) as! EventTableViewCell

        // Configure the cell...
        
//        let value = Array(temp.values)[indexPath.section]
//        
//        let var1 = Array(value.keys)[indexPath.row]
//        let var2 = Array(value.values )[indexPath.row]
//
//        
        
//        let eventTitles = [Events[0].name, Events[1].name]
//        let eventTitle = Events[indexPath.row].isAllDay
        
        //let eventTitles = ["교수님 면담", "iOS 수업"]
        //let eventTitle = ["하루 종일","하루종일"]

        
        /*선언할때 잘못해서
         sub_label과 title_label의 지정을 반대로 해버림*/
        

        /*시간 문자열 처리*/
        
        
//        let currentEvent:Event = myEvents[number]
//        print(currentEvent.title)
        
        if myEvents[indexPath.section].isAllDay {
            cell.sub_label.text = "하루종일"
            cell.anothersub_label.text = " "
        } else {
            var Stime = String(myEvents[indexPath.section].startDate)
            var StimeArr = Stime.characters.split(" ").map(String.init)
            Stime = StimeArr[1]
            StimeArr = Stime.characters.split(":").map(String.init)
            
            var Etime = String(myEvents[indexPath.section].endDate)
            var EtimeArr = Etime.characters.split(" ").map(String.init)
            Etime = EtimeArr[1]
            EtimeArr = Etime.characters.split(":").map(String.init)
            
            cell.sub_label.text = "\(StimeArr[0])시 \(StimeArr[1])분"
            cell.anothersub_label.text = "\(EtimeArr[0])시 \(EtimeArr[1])분"
        }
        
        cell.title_label.text = myEvents[indexPath.section].title
        
        cell.line_color.backgroundColor = colorArray[Int(arc4random())%5]
        number = number + 1

        return cell
        
        
        /*애플 공식 레퍼런스 코드(참고용)
         cell.nameLabel.text = meal.name
         cell.photoImageView.image = meal.photo
         cell.ratingControl.rating = meal.rating
         */
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 28.0
    }
    
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        var StimeArr:[String] = []
        var _Stime:[String] = []
        var Stime:String
        var SavedString:String? = nil
        
        
        Stime = String(myEvents[section].startDate)
        StimeArr = Stime.characters.split("-").map(String.init)
        _Stime = StimeArr[2].characters.split(" ").map(String.init)
        SavedString = String("\(StimeArr[1])월 \(_Stime[0])일")

        return SavedString
//        another_number = another_number+1
//        if another_number == myEvents.count{
//            another_number = another_number-1
//        }
        

//        return String(myEvents[section].StartDate)
        

    }
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func viewWillAppear(animated: Bool) {
        myEvents = []
        readEvents()
        self.tableView.reloadData()
    }
    
    
    @IBAction func toInitialTableView(unwind:UIStoryboardSegue) {
    }
    
    let eventStore = EKEventStore()

    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ToDetail" {
            let destVC = segue.destinationViewController as! EventDetailTableViewController
            let selectedIndex:NSIndexPath = self.tableView.indexPathForSelectedRow!
            let selected:Event = self.myEvents[selectedIndex.section]
            destVC.currentEvent = selected
        }
        
    }
    
    

}
