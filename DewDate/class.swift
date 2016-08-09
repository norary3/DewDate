//
//  class.swift
//  DewDate
//
//  Created by STEP on 2016. 8. 9..
//  Copyright © 2016년 Koreauniv. All rights reserved.
//

import Foundation

typealias time = (year:Int, mon:Int, day:Int, h:Int, m:Int)

enum repeat_interval {
    case none, evr_day,evr_week, evr_2week, evr_mon,evr_year
}

enum move_time {
    case min5, min15, min30, min60, min90, min120
}

class Event{
    var name:String
    var location:String?
    var isAllDay:Bool = false
    var start:time
    var end:time
    var repeat_interval:repeat_interval //= ["안함":false,"매일":false,"매주":false,"2주마다":false,"매월":false,"매년":false]
    var move_time:move_time // = ["5분":false,"15분":false,"30분":false,"1시간":false,"1시간,30분":false,"2시간":false]
    var alarm:[String:Bool] = ["이동 시간 시작 시":false, "이동 시간 5분 전":false]
    
    init(name:String, start:time, end:time) {
        self.name = name
        self.start = start
        self.end = end
        
    }
    
    init(name:String, start:time, end:time, location:String) {
        self.name = name
        self.start = start
        self.end = end
        self.location = location
        
    }
    

}

