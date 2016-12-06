//
//  LunarSolarConverterMain.swift
//  LunarSolarConverter
//
//  Created by isee15 on 15/1/17.
//  Copyright (c) 2015年 isee15. All rights reserved.
//

import Foundation

func getLunarDate(solarDate: NSDate) -> String {
    let formatter = DateFormatter()
    formatter.locale = NSLocale(localeIdentifier: "zh-Tw_POSIX") as Locale!
    formatter.dateStyle = .short
    formatter.dateFormat = "MM/dd"
    let Cal = NSCalendar(calendarIdentifier: NSCalendar.Identifier.chinese)
    formatter.calendar = Cal as Calendar!
    return formatter.string(from: solarDate as Date)

}

func dateFrom(year: Int, month: Int, day: Int) -> NSDate {
    let calendar = NSCalendar(identifier:
        NSCalendar.Identifier.gregorian)
    let components = NSDateComponents()
    components.year = year
    components.month = month
    components.day = day
    components.hour = 12
    components.minute = 0
    components.second = 0
    components.timeZone = NSTimeZone(name: "GMT+0800") as TimeZone?

    let swSolar = calendar?.date(from: components as DateComponents)
    return swSolar! as NSDate
}

//var solar = Solar(solarYear: 2263, solarMonth: 2, solarDay: 7)
//var lunar = LunarSolarConverter.SolarToLunar(solar)
//print("lunar: \(lunar.lunarYear) \(lunar.lunarMonth) \(lunar.lunarDay) \(lunar.isleap)")
//solar = LunarSolarConverter.LunarToSolar(lunar);
//print("solar: \(solar.solarYear) \(solar.solarMonth) \(solar.solarDay)")

func check() -> Void {
    var begin = dateFrom(year: 1900, month: 1, day: 1);
    let end = dateFrom(year: 2300, month: 1, day: 1);

    let calendar = NSCalendar(identifier: NSCalendar.Identifier.gregorian)
    let lunarCal = NSCalendar(calendarIdentifier: NSCalendar.Identifier.chinese)

    var yy = 0;
    while begin.compare(end as Date) == ComparisonResult.orderedAscending {
        let unitFlags: NSCalendar.Unit = [.day, .month, .year]
        let swLunar = lunarCal!.components(unitFlags, from: begin as Date)

        let components = calendar?.components(unitFlags, from: begin as Date);
        var solar = Solar(solarYear: (components?.year)!, solarMonth: (components?.month)!, solarDay: (components?.day)!)
        let lunar = LunarSolarConverter.SolarToLunar(solar: solar)
        if ((components?.year)! > yy) {
            yy = (components?.year)!;
            print("year: \(yy)");
        }
        let formatter = DateFormatter()
        //formatter.locale = NSLocale(localeIdentifier: "zh-Tw_POSIX")
        formatter.dateStyle = .medium
        formatter.calendar = lunarCal as Calendar!
        let lunarString = formatter.string(from: begin as Date)
        let lunarYear = lunarString.substring(to: lunarString.index(lunarString.startIndex, offsetBy: 4))
        // swLunar.year is like 甲子
        if (lunar.lunarYear != Int(lunarYear) || lunar.lunarMonth != swLunar.month || lunar.lunarDay != swLunar.day || lunar.isleap != swLunar.isLeapMonth) {
            print("swlunar: \(lunarYear) \(swLunar.month) \(swLunar.day) \(swLunar.isLeapMonth)")
            print("lunar: \(lunar.lunarYear) \(lunar.lunarMonth) \(lunar.lunarDay) \(lunar.isleap)")
            solar = LunarSolarConverter.LunarToSolar(lunar: lunar);
            print("solar: \(solar.solarYear) \(solar.solarMonth) \(solar.solarDay)")
        }
        begin = begin.addingTimeInterval(60 * 60 * 24);
    }

    print("done");
}

/*
print(getLunarDate(solarDate: dateFrom(year: 2097, month: 8, day: 7)))
print(getLunarDate(solarDate: dateFrom(year: 2057, month: 9, day: 28)))
print(getLunarDate(solarDate: dateFrom(year: 1900, month: 1, day: 30)))
print(getLunarDate(solarDate: dateFrom(year: 1900, month: 1, day: 31)))
print(getLunarDate(solarDate: dateFrom(year: 1901, month: 1, day: 20)))


//generate lunarMonth and solar11 data
let gen = GenSourceData()
gen.genData(beginY: 1900, endY: 2300);

check()
*/

