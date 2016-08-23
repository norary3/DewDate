//
//  InitialTableViewController.swift
//  DewDate
//
//  Created by kang on 2016. 8. 18..
//  Copyright © 2016년 Koreauniv. All rights reserved.
//

import UIKit
import EventKit
var Events:[Event] = []



class InitialTableViewController: UITableViewController {
    
    var temp : [String:[String:Int]] = ["MeetingRooms":["what":1,"Should":2],"Temp":["I":3,"write":4]]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dummy1 = Event(name:"교수님면담",isAllDay:true)
        let dummy2 = Event(name:"점심약속",isAllDay:false)
        Events += [dummy1,dummy2]
        
        


        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return temp.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        let values = Array(temp.values)[section]
        
        return values.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("EventCell", forIndexPath: indexPath) as! EventTableViewCell

        // Configure the cell...
        
        let value = Array(temp.values)[indexPath.section]
        
        let var1 = Array(value.keys)[indexPath.row]
        let var2 = Array(value.values )[indexPath.row]

        
        
//        let eventTitles = [Events[0].name, Events[1].name]
//        let eventTitle = Events[indexPath.row].isAllDay
        
        //let eventTitles = ["교수님 면담", "iOS 수업"]
        //let eventTitle = ["하루 종일","하루종일"]


        cell.sub_label.text = var1
        cell.title_label.text = "\(var2)"
        cell.line_color.backgroundColor = UIColor.blackColor()
        return cell
        
        
        
        /*애플 공식 레퍼런스 코드(참고용)
         cell.nameLabel.text = meal.name
         cell.photoImageView.image = meal.photo
         cell.ratingControl.rating = meal.rating
         */
    }
    
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return Array(temp.keys)[section]
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
    
    @IBAction func toInitialTableView(unwind:UIStoryboardSegue) {
        
    }
    
    
    
    let eventStore = EKEventStore()
    
    func requestCalendarEntity() {
        eventStore.requestAccessToEntityType(.Event, completion: {
            (granted, error) in
            
            if (granted) && (error == nil) {
                /// 캘린더 목록 가져오기
                let calenders = self.eventStore.calendarsForEntityType(EKEntityType.Event)
                for calender in calenders  {
                    print(calender.title)
                }

            }
            
        })
    }

}
