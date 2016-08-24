//
//  EventDetailTableViewController.swift
//  DewDate
//
//  Created by kang on 2016. 8. 19..
//  Copyright © 2016년 Koreauniv. All rights reserved.
//

import UIKit
import EventKit



class EventDetailTableViewController: UITableViewController{
    
    
//    @IBOutlet weak var Normal_tableView: UITableView!
    
//    var temp_Event:[Event] = []
//    var titles : [String] = []
//    var startDates : [NSDate] = []
//    var endDates : [NSDate] = []
//    var hasNotess : [String] = []
//    

    
//    override func viewDidAppear(animated: Bool) {
//        
//        let eventStore = EKEventStore()
//        
//        switch EKEventStore.authorizationStatusForEntityType(.Event) {
//        case .Authorized:
//            readEvents()
//        case .Denied:
//            print("Access denied")
//        case .NotDetermined:
//            
//            eventStore.requestAccessToEntityType(.Event, completion: { (granted: Bool, NSError) -> Void in
//                if granted {
//                    self.readEvents()
//                    
//                }else{
//                    print("Access denied")
//                }
//                
//                
//                
//            })
//        default:
//            print("Case Default")
//        }
//        self.tableView.reloadData()
//    }
//    
//    
//    
//    
//    
//    func readEvents() {
//        
//        
//        
//        
//        let eventStore = EKEventStore()
//        let calendars = eventStore.calendarsForEntityType(.Event)
//        
//        for calendar in calendars {
//            
//            let oneMonthAgo = NSDate(timeIntervalSinceNow: -30*24*3600)
//            let oneMonthAfter = NSDate(timeIntervalSinceNow: +30*24*3600)
//            
//            
//            let predicate = eventStore.predicateForEventsWithStartDate(oneMonthAgo, endDate: oneMonthAfter, calendars: [calendar])
//            
//            var events = eventStore.eventsMatchingPredicate(predicate)
//            
//            for event in events {
//                
//                titles.append(event.title)
//                startDates.append(event.startDate)
//                endDates.append(event.endDate)
//                
//            }
//
//        }
    

    func deleteEvent(eventStore: EKEventStore, eventIdentifier: String) {
        let eventToRemove = eventStore.eventWithIdentifier(eventIdentifier)
        if (eventToRemove != nil) {
            do {
                try eventStore.removeEvent(eventToRemove!, span: .ThisEvent)
            } catch {
                print("Bad things happened")
            }
        }
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    var currentEvent:Event = Event()
    var arrOfAddInfo:Array<(String, String)> = []

    @IBAction func deleteEvent(sender: AnyObject) {
        let eventStore = EKEventStore()
        
        if (EKEventStore.authorizationStatusForEntityType(.Event) != EKAuthorizationStatus.Authorized) {
            eventStore.requestAccessToEntityType(.Event, completion: { (granted, error) -> Void in
                self.deleteEvent(eventStore, eventIdentifier: self.currentEvent.eventIdentifier)
            })
        } else {
            deleteEvent(eventStore, eventIdentifier: currentEvent.eventIdentifier)
        }
    }
    override func viewDidLoad() {
        arrOfAddInfo = currentEvent.arrOfAddInfo()

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (currentEvent.arrOfAddInfo().count + 1)

    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        if indexPath.row == 0{
            return 90.0;
        }
        else{
            return 44.0;//Choose your custom row height
        }
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            //let cell: TopEventDetailTableViewCell = TopEventDetailTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "TopEventDetailTableViewCell")
            
            let cell = tableView.dequeueReusableCellWithIdentifier("TopEventDetailTableViewCell", forIndexPath: indexPath) as! TopEventDetailTableViewCell
            
            let dateFormatter = NSDateFormatter()
            let locationString:String
            
            if currentEvent.location == "" {
                print("if")
                locationString = ""
                cell.info_label!.numberOfLines = 2
                
            } else {
                print("else")
                locationString = currentEvent.location
                cell.info_label!.numberOfLines = 3
            }
            
            if currentEvent.isAllDay {
                dateFormatter.dateFormat = "yyyy년 M월 d일 EEEE"
                cell.info_label!.text = locationString + "\n" + currentEvent.startDate.toTimeString(dateFormatter) + "\n하루종일"
            } else {
                dateFormatter.dateFormat = "yyyy년 M월 d일 (E) a h:mm"
                cell.info_label!.text = locationString + "\n" + currentEvent.startDate.toTimeString(dateFormatter) + "부터\n" +
                    currentEvent.endDate.toTimeString(dateFormatter) + "까지"
            }
            
            cell.another_title.text = currentEvent.title
            return cell
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("EventDetailCell", forIndexPath: indexPath)
            cell.textLabel!.text = self.arrOfAddInfo[0].0
            cell.detailTextLabel!.text = self.arrOfAddInfo[0].1
            self.arrOfAddInfo.removeAtIndex(0)
            
            return cell
        }
    }
    
    
    //        if Top_tableView == self.Top_tableView{
    //            cell = tableView.dequeueReusableCellWithIdentifier("Top_EventDetailCell", forIndexPath: indexPath) as! Top_EventDetailTableViewCell
    //            cell!.textLabel!.text = Temp_Event[1].name
    //        }
    //
    //        if Normal_tableView == self.Normal_tableView{
    //            cell = tableView.dequeueReusableCellWithIdentifier("EventDetailCell", forIndexPath: indexPath) as! EventDetailTableViewCell
    //            cell!.textLabel!.text = Temp_Event[0].name
    //        }
    
    
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


