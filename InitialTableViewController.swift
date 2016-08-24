//
//  InitialTableViewController.swift
//  DewDate
//
//  Created by kang on 2016. 8. 18..
//  Copyright © 2016년 Koreauniv. All rights reserved.
//

import UIKit
import EventKit
import EventKitUI


var titles : [String] = []
var startDates : [NSDate] = []
var endDates : [NSDate] = []
var hasNotess : [String] = []


var number:Int = 0





class InitialTableViewController: UITableViewController, EKEventEditViewDelegate {
    
    var myEvents:[Event] = []
    var another_number:Int = 0

    
    let colorArray = Array(arrayLiteral: UIColor.blackColor(), UIColor.redColor(), UIColor.orangeColor(), UIColor.blueColor(), UIColor.darkGrayColor())
    
    var temp : [String:[String:Int]] = ["MeetingRooms":["what":1,"Should":2],"Temp":["I":3,"write":4]]


    //override func viewDidAppear(animated: Bool) {
    override func viewDidLoad() {
        
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
        self.tableView.reloadData()
    }
    
    
    
    
    
    func readEvents() {
        
        
        
        
        let eventStore = EKEventStore()
        let calendars = eventStore.calendarsForEntityType(.Event)
        
        for calendar in calendars {
            
            let oneMonthAgo = NSDate(timeIntervalSinceNow: -30*24*3600)
            let oneMonthAfter = NSDate(timeIntervalSinceNow: +60*24*3600)
            
            
            let predicate = eventStore.predicateForEventsWithStartDate(oneMonthAgo, endDate: oneMonthAfter, calendars: [calendar])
            
            var events = eventStore.eventsMatchingPredicate(predicate)
            
            for event in events{
                
            
            let newEvent = Event(title: event.title,location:event.location!, StartDate: event.startDate, EndDate: event.endDate)
                print ("newEventReadTitle = \(event.title)\nnewEventWriteTitle=\(newEvent.title)")
            myEvents += [newEvent]
                
//            print("read Event = \(event) \nwriteEvent = \(newEvent.title)")
//                titles.append(event.title)
//                startDates.append(event.startDate)
//                endDates.append(event.endDate)
            
                
            }
        }
        
    }
    
    
    
    
        

        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return myEvents.count
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
        
        
        let currentEvent:Event = myEvents[number]
        print(currentEvent.title)
        
        var Stime = String(myEvents[number].StartDate)
        var StimeArr = Stime.characters.split(" ").map(String.init)
        Stime = StimeArr[1]
        StimeArr = Stime.characters.split(":").map(String.init)

        
        
        var Etime = String(myEvents[number].EndDate)
        var EtimeArr = Etime.characters.split(" ").map(String.init)
        Etime = EtimeArr[1]
        EtimeArr = Etime.characters.split(":").map(String.init)
        
        cell.sub_label.text = "\(StimeArr[0])시 \(StimeArr[1])분"
        cell.title_label.text = myEvents[number].title
        cell.anothersub_label.text = "\(EtimeArr[0])시 \(EtimeArr[1])분"
    
        
        cell.line_color.backgroundColor = colorArray[random()%5]
        
        number = number+1
        
        return cell
        
        
        /*애플 공식 레퍼런스 코드(참고용)
         cell.nameLabel.text = meal.name
         cell.photoImageView.image = meal.photo
         cell.ratingControl.rating = meal.rating
         */
    }
    
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        var StimeArr:[String] = []
        var _Stime:[String] = []
        var Stime:String
        var SavedString:String? = nil
        

        Stime = String(myEvents[section].StartDate)
        StimeArr = Stime.characters.split("-").map(String.init)
        _Stime = StimeArr[2].characters.split(" ").map(String.init)
        print("\(StimeArr[1])월 \(_Stime[0])일")
        SavedString = String("\(StimeArr[1])월 \(_Stime[1])일")
        print(SavedString!)
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
    
    
    
    @IBAction func toInitialTableView(unwind:UIStoryboardSegue) {
        self.tableView.reloadData()
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
    
    func addButton() {
        let controller:EKEventEditViewController = EKEventEditViewController()
        controller.editViewDelegate = self;
        presentViewController(controller, animated: true, completion: nil)
        
        
        let eventController = EKEventEditViewController()
        let store = EKEventStore()
        eventController.eventStore = store
        eventController.editViewDelegate = self
        //self.dismissViewControllerAnimated(true, completion: nil)
        
        
        var event = EKEvent(eventStore: store)
        event.title = "dd"
        eventController.event = event
        
        
        let status = EKEventStore.authorizationStatusForEntityType(.Event)
        switch status {
        case .Authorized:
            //self.setNavBarAppearanceStandard()
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.presentViewController(eventController, animated: true, completion: nil)
            })
            
        case .NotDetermined:
            store.requestAccessToEntityType(.Event, completion: { (granted, error) -> Void in
                if granted == true {
                    //self.setNavBarAppearanceStandard()
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.presentViewController(eventController, animated: true, completion: nil)
                    })
                }
            })
        case .Denied, .Restricted:
            let addAlert = UIAlertController(title: "Access Denied", message: "DewDate가 캘린더에 접근할 수 있도록 허가해 주세요", preferredStyle: .Alert)
            self.presentViewController(addAlert, animated: true, completion: nil)
            return
        }
        
    }
    
    func eventEditViewController(controller: EKEventEditViewController,
                                 didCompleteWithAction action: EKEventEditViewAction){
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
        let destVC 
    
    }
    
    

}
