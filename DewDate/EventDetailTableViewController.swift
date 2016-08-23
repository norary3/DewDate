//
//  EventDetailTableViewController.swift
//  DewDate
//
//  Created by kang on 2016. 8. 19..
//  Copyright © 2016년 Koreauniv. All rights reserved.
//

import UIKit

class EventDetailTableViewController: UITableViewController{
    

    //@IBOutlet weak var Normal_tableView: UITableView!
    
    var temp_Event:[Event] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dummy1 = Event(name:"교수님면담",isAllDay:true)
        let dummy2 = Event(name:"점심약속",isAllDay:false)
        temp_Event += [dummy1,dummy2]
        
        //Top_tableView.dataSource = self
        //Top_tableView.delegate = self
        //Top_tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Top_EventDetailTableViewCell")
        
//        Normal_tableView.dataSource = self
//        Normal_tableView.delegate = self
//        Normal_tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "EventDetailCell")
 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
        
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
            
            cell.another_title.text = "asdasdfsdffsaf"
            cell.info_label.text="info"
            return cell
            
            
        }
        
            
            
        else {
            let cell = tableView.dequeueReusableCellWithIdentifier("EventDetailCell", forIndexPath: indexPath)
            
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


