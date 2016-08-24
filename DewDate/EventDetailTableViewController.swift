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
    
        
//        print(titles)
//        print(startDates)
//        print(endDates)
        
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return titles.count
        
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
        
        
        if indexPath.row == 0 {
            //            let cell: TopEventDetailTableViewCell = TopEventDetailTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "TopEventDetailTableViewCell")
            
            let cell = tableView.dequeueReusableCellWithIdentifier("TopEventDetailTableViewCell", forIndexPath: indexPath) as! TopEventDetailTableViewCell
            cell.another_title.text = titles[indexPath.row]
            cell.info_label!.text = "From: \(startDates[indexPath.row]) Until: \(endDates[indexPath.row])"
            cell.another_info_label!.text = "하루종일"
            return cell
            
            
        }
            
            
            
        else {
            let cell = tableView.dequeueReusableCellWithIdentifier("EventDetailCell", forIndexPath: indexPath)
            
            cell.textLabel!.text = "From: \(startDates[indexPath.row])"
            cell.detailTextLabel!.text = "Until: \(endDates[indexPath.row])"
            
            cell.textLabel!.text = "asahsa"
            cell.detailTextLabel!.text = "deeeetaiilll"
            
            
            
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


