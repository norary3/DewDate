//
//  ActionViewController.swift
//  AutoEventAddActionExt
//
//  Created by cscoi027 on 2016. 8. 18..
//  Copyright © 2016년 Koreauniv. All rights reserved.
//

import UIKit
import MobileCoreServices
import EventKit

extension String {
    public func indexOfCharacter(char: Character) -> Int? {
        if let idx = self.characters.indexOf(char) {
            return self.startIndex.distanceTo(idx)
        }
        return nil
    }
    
    func toDateTime() -> NSDate
    {
        //Create Date Formatter
        let dateFormatter = NSDateFormatter()
        
        //Specify Format of String to Parse
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
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
    
    func toTimeString() -> String
    {
        //Get Time String
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        let timeString = formatter.stringFromDate(self)
        
        //Return Time String
        return timeString
    }
}

let spaceSet = NSCharacterSet.whitespaceAndNewlineCharacterSet()

class ActionViewController: UIViewController {
    
    var convertingString: String?
    let cal = NSCalendar.currentCalendar()
    
    var eventTitle:String = ""
    var eventLocation = ""
    var eventStart:NSDate = NSDate()
    var eventEnd:NSDate = NSDate()
    var eventMemo = ""
    

    @IBOutlet weak var sampleTextView: UITextView!

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var startTextField: UITextField!
    @IBOutlet weak var endTextField: UITextField!
    @IBOutlet weak var memoTextField: UITextField!
    
    var savedEventId : String = ""
    // Creates an event in the EKEventStore. The method assumes the eventStore is created and
    // accessible
    func createEvent(eventStore: EKEventStore, title: String, location: String, startDate: NSDate, endDate: NSDate, note: String) {
        let event = EKEvent(eventStore: eventStore)
        
        event.title = title
        event.startDate = startDate
        event.endDate = endDate
        event.location = location
        event.notes = note
        event.calendar = eventStore.defaultCalendarForNewEvents
        do {
            try eventStore.saveEvent(event, span: .ThisEvent)
            savedEventId = event.eventIdentifier
        } catch {
            print("Bad things happened")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
   
        /*
         모든 익스텐션 뷰 컨트롤러는 NSExtensionContext 클래스의 인스턴스 형태로 연결된 익스텐션 콘텍스트(extension context)를 갖는다. 익스텐션 콘텍스트의 참조체는 뷰 컨트롤러의 extensionContext 속성을 통해 접근할 수 있다. 익스텐션 콘텍스트는 객체들을 포함하고 있는 배열의 형태인 inputi
         */
        // 각각의 NSExtensionItem객체는 attachment객체들의 배열을 갖는다. attachment객체는 NSItemProvider 타입이며, 호스트앱의 데이터에 접근할 수 있다. attachment객체의 참조체를 얻었으면 익스텐션이 지원하는 타입의 데이터를 호스트 애플리케이션이 가지고 있는지 검증하기 위하여 attachment 객체의 hasItemConformingToTypeIdentifier 메서드를 호출할 수 있다.
        let textItem: NSExtensionItem = extensionContext?.inputItems[0] as! NSExtensionItem
        let textItemProvider = textItem.attachments![0] as! NSItemProvider
        // 핸들러 지정(string이라는 이름의 NSSecureCoding 변수와 error라는 이름의 NSError변수를 전달받아 처리하는 익명함수 선언)
        let handlerCompletion: (NSSecureCoding?, NSError)->Void = { string, error in
            // 핸들러 매개변수로 전달받은 변수를 String형태로 형변환하여 저장
            self.convertingString = string as? String
            if let parsingString = self.convertingString {
                // 전달받은 텍스트 데이터를 Parsing
                /* 전달 받는 텍스트 예시
                 제목:놀이공원 데이트
                 위치:롯데월드
                 시작:2016년 8월 20일 10:00
                 종료:2016년 8월 20일 17:00
                */
                
                var titleFlag = false
                var locationFlag = false
                var startFlag = false
                var endFlag = false
                var memoFlag = false
                
                let lines = parsingString.componentsSeparatedByString("\n")
                for line in lines {
                    if line != "" {
                        let front = line.substringToIndex(line.startIndex.advancedBy(2))
                        let back = line.substringFromIndex(line.startIndex.advancedBy(3))
                        switch front {
                        case "제목" :
                            titleFlag = true
                            self.eventTitle = back
                        case "위치",
                             "장소" :
                            locationFlag = true
                            self.eventLocation = back
                        case "시작" :
                            startFlag = true
                            var rest = back
                            let year:Int
                            let month:Int
                            let day:Int
                            let hour:Int
                            let minute:Int
                            
                            // parsiing year
                            if let intIndex = rest.indexOfCharacter("년"), let yearFromStirng = Int(rest.substringToIndex(rest.startIndex.advancedBy(intIndex))) {
                                year = yearFromStirng
                                rest = rest.substringFromIndex(rest.startIndex.advancedBy(intIndex+1)).stringByTrimmingCharactersInSet( spaceSet )
                            } else {
                                year = NSDate().year()
                            }
                            // parsing month
                            if let intIndex = rest.indexOfCharacter("월"), let monthFromStirng = Int(rest.substringToIndex(rest.startIndex.advancedBy(intIndex))) {
                                month = monthFromStirng
                                rest = rest.substringFromIndex(rest.startIndex.advancedBy(intIndex+1)).stringByTrimmingCharactersInSet( spaceSet )
                            } else {
                                month = NSDate().month()
                            }
                            // parsing day
                            if let intIndex = rest.indexOfCharacter("일"), let dayFromStirng = Int(rest.substringToIndex(rest.startIndex.advancedBy(intIndex))) {
                                day = dayFromStirng
                                rest = rest.substringFromIndex(rest.startIndex.advancedBy(intIndex+1)).stringByTrimmingCharactersInSet( spaceSet )
                            } else {
                                day = NSDate().day()
                            }
                            // parsing hour
                            if let intIndex = rest.indexOfCharacter(":"), let hourFromStirng = Int(rest.substringToIndex(rest.startIndex.advancedBy(intIndex))) {
                                hour = hourFromStirng
                                rest = rest.substringFromIndex(rest.startIndex.advancedBy(intIndex+1)).stringByTrimmingCharactersInSet( spaceSet )
                            } else {
                                hour = NSDate().hour()
                            }
                            // parsing minute
                            if let minuteFromString = Int(rest) {
                                minute = minuteFromString
                            } else { minute = 0}
                            /*
                             if let intIndex = rest.indexOfCharacter("분") {
                             minute = rest.substringToIndex(rest.startIndex.advancedBy(intIndex))
                             } else {
                             minute = "\(NSDate().minute())"
                             }
                             */
                            
                            // "yyyy-MM-dd hh:mm"
                            let startString = String(format: "%04d", year) + "-" + String(format: "%02d", month) + "-" + String(format: "%02d", day) + " " + String(format: "%02d", hour) + ":" + String(format: "%02d", minute)
                            self.eventStart = startString.toDateTime()
                        case "종료" :
                            endFlag = true
                            var rest = back
                            let year:Int
                            let month:Int
                            let day:Int
                            let hour:Int
                            let minute:Int
                            
                            // parsiing year
                            if let intIndex = rest.indexOfCharacter("년"), let yearFromStirng = Int(rest.substringToIndex(rest.startIndex.advancedBy(intIndex))) {
                                year = yearFromStirng
                                rest = rest.substringFromIndex(rest.startIndex.advancedBy(intIndex+1)).stringByTrimmingCharactersInSet( spaceSet )
                            } else {
                                year = NSDate().year()
                            }
                            // parsing month
                            if let intIndex = rest.indexOfCharacter("월"), let monthFromStirng = Int(rest.substringToIndex(rest.startIndex.advancedBy(intIndex))) {
                                month = monthFromStirng
                                rest = rest.substringFromIndex(rest.startIndex.advancedBy(intIndex+1)).stringByTrimmingCharactersInSet( spaceSet )
                            } else {
                                month = NSDate().month()
                            }
                            // parsing day
                            if let intIndex = rest.indexOfCharacter("일"), let dayFromStirng = Int(rest.substringToIndex(rest.startIndex.advancedBy(intIndex))) {
                                day = dayFromStirng
                                rest = rest.substringFromIndex(rest.startIndex.advancedBy(intIndex+1)).stringByTrimmingCharactersInSet( spaceSet )
                            } else {
                                day = NSDate().day()
                            }
                            // parsing hour
                            if let intIndex = rest.indexOfCharacter(":"), let hourFromStirng = Int(rest.substringToIndex(rest.startIndex.advancedBy(intIndex))) {
                                hour = hourFromStirng
                                rest = rest.substringFromIndex(rest.startIndex.advancedBy(intIndex+1)).stringByTrimmingCharactersInSet( spaceSet )
                            } else {
                                hour = NSDate().hour()
                            }
                            // parsing minute
                            if let minuteFromString = Int(rest) {
                                minute = minuteFromString
                            } else { minute = 0}
                            /*
                             if let intIndex = rest.indexOfCharacter("분") {
                             minute = rest.substringToIndex(rest.startIndex.advancedBy(intIndex))
                             } else {
                             minute = "\(NSDate().minute())"
                             }
                             */
                            
                            // "yyyy-MM-dd hh:mm"
                            let endString = String(format: "%04d", year) + "-" + String(format: "%02d", month) + "-" + String(format: "%02d", day) + " " + String(format: "%02d", hour) + ":" + String(format: "%02d", minute)
                            self.eventEnd = endString.toDateTime()
                        default:
                            memoFlag = true
                            self.eventMemo += line + "\n"
                        }
                        if endFlag == false {
                            self.eventEnd = self.cal.dateByAddingUnit(.NSHourCalendarUnit, value: 2, toDate: self.eventStart, options: .WrapComponents)!
                        }
                    }
                }
                
                // 메인스레드를 통하여 화면의 TextView에 갱신처리
                dispatch_async(dispatch_get_main_queue()){
                    self.sampleTextView.text = parsingString
                    self.titleTextField.text = self.eventTitle
                    self.locationTextField.text = self.eventLocation
                    self.startTextField.text = self.eventStart.toTimeString()
                    self.endTextField.text = self.eventEnd.toTimeString()
                    self.memoTextField.text = self.eventMemo
                }
            }
        }
        // 호스트 앱이 원하고자 하는 타입의 데이터를 가지고 있다면 익스텐션이 지원하는 UTI 컨텐츠 타입인자로 다시 전달되는 loadItemForTypeIdentifier 메서드 호출을 통하여 그 데이터가 익스텐션에 로드될수 있다. 호스트앱의 데이터를 로딩하는 것은 비동기적으로 수행하므로 데이터 로딩 과정이 완료될때 호출되는 완료 핸들러를 지정해야 한다.
        if textItemProvider.hasItemConformingToTypeIdentifier(kUTTypeText as NSString as String) {
            textItemProvider.loadItemForTypeIdentifier(
                kUTTypeText as String,      // 텍스트 타입의 데이터를 수신할 것으로 지정
                options: nil,
                // viewDidLoad에 선언한 handlerCompletion 변수를 통하여 핸들러를 지정하여 처리하도록 전달한다.
                // Swift 2.0에서는 unsafeBitCast함수를 이용하도록 변경되었다.
                completionHandler: unsafeBitCast(handlerCompletion, NSItemProviderCompletionHandler.self)
            )
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    @IBAction func done() {
        // Return any edited content to the host app.
        // This template doesn't do anything, so we just echo the passed in items.
        self.extensionContext!.completeRequestReturningItems(self.extensionContext!.inputItems, completionHandler: nil)
    }
    */
    
    
    @IBAction func add(sender: AnyObject) {
        let eventStore = EKEventStore()
        if let newEventTitle = self.titleTextField.text { self.eventTitle =  newEventTitle }
        if let newEventLocation = self.locationTextField.text { self.eventLocation = newEventLocation }
        if let newEventStart = self.startTextField.text?.toDateTime() { self.eventStart = newEventStart }
        if let newEventEnd = self.endTextField.text?.toDateTime() { self.eventEnd = newEventEnd }
        if let newEventMemo = self.memoTextField.text { self.eventMemo = newEventMemo }
        
        if (EKEventStore.authorizationStatusForEntityType(.Event) != EKAuthorizationStatus.Authorized) {
            eventStore.requestAccessToEntityType(.Event, completion: {
                granted, error in
                self.createEvent(eventStore, title: self.eventTitle, location: self.eventLocation, startDate: self.eventStart, endDate: self.eventEnd, note: self.eventMemo)
            })
        } else {
            createEvent(eventStore, title: self.eventTitle, location: self.eventLocation, startDate: self.eventStart, endDate: self.eventEnd, note: self.eventMemo)
        }
        // show adding has done as actionSheet
        let addAlert = UIAlertController(title: "\(self.eventTitle) 일정이 캘린더에 추가되었습니다.", message: nil, preferredStyle: .ActionSheet)
        
        /*  // only today wiget open its containing app
        let moveToCalAction = UIAlertAction(title: "DewDate로 이동", style: .Default, handler: { (action:UIAlertAction) -> Void in
            print ("캘린더로 이동 선택")
            // TODO : move to Event Table
            self.goToDewDateCal()
            
        })
        */
        
        let exitAction = UIAlertAction(title: "종료", style: .Cancel, handler: { (action:UIAlertAction) -> Void in
            print ("종료 선택")
            self.extensionContext!.completeRequestReturningItems(self.extensionContext!.inputItems, completionHandler: nil)
        })
        
        //addAlert.addAction(moveToCalAction)
        
        addAlert.addAction(exitAction)
        self.presentViewController(addAlert, animated: true, completion: nil)

        
        
        
    }
    
    @IBAction func cancel(sender: AnyObject) {
        // 이 함수는 입력 아이템을 unpacking하는 과정을 반대로 한다. 첫번째로 수정된 컨텐츠(convertedString)와 컨텐츠 타입 식별자(여기서는 kUTTypeText)로 구성한 새로운 NSItemProvider인스턴스를 생성한다.
        //let returnProvider = NSItemProvider(item:convertingString, typeIdentifier: kUTTypeText as NSString as String)
        // 새로운 NSExtensionItem인스턴스를 생성하고 NSItemProvider 객체를 attachments에 할당한다.(호스트 앱으로 다시 전달하기 위하여 갱신된 정보를 저장)
        //let returnItem = NSExtensionItem()
        //returnItem.attachments = [returnProvider]
        
        // 익스텐션 콘텍스트의 completeRequestReturningItems 메서드에 NSExtensionItem 인스턴스를 인자로 전달하며 호출
        //extensionContext!.completeRequestReturningItems([returnItem], completionHandler: nil)
        self.extensionContext!.completeRequestReturningItems(self.extensionContext!.inputItems, completionHandler: nil)
    }
    
    // only today wiget open its containing app
    func goToDewDateCal() {
        let DewDateCal = "DewDate://"
        
        let DewDateCalURL = NSURL(string: DewDateCal)
        self.extensionContext?.openURL(DewDateCalURL!, completionHandler: nil)
    }

}
