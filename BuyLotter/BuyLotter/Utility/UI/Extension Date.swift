//
//  Extension Date.swift
//  SocialApp
//
//  Created by HieuTT on 06/08/2018.
//  Copyright © 2018 CNCVN. All rights reserved.
//

import Foundation
extension Date {
    func toStringWithInitTimeZone()->String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS Z"
        dateFormatter.timeZone = TimeZone.init(abbreviation: "UTC")
        return dateFormatter.string(from: self)
    }

    func toStringWithCurrentTimeZone()->String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS Z"
        return dateFormatter.string(from: self)
    }

    func displayDateByTextForMessage() -> String {
        let dateFormatter = DateFormatter()
        let distanceTime = Date().timeIntervalSince(self)

        if distanceTime < 5 {
            return "vừa xong"
        } else if distanceTime < 60 {
            return "\(Int(distanceTime)) giây"
        } else if distanceTime < 3600 {
            return "\(Int(distanceTime / 60)) phút"
        } else if distanceTime < 43200 {
            return "\(Int(distanceTime / 3600)) giờ"
        } else if distanceTime < 86400 {
            dateFormatter.dateFormat = "HH:mm"
            return dateFormatter.string(from: self)
        } else if distanceTime < 172800 {
            dateFormatter.dateFormat = "HH:mm"
            return dateFormatter.string(from: self)
        } else if distanceTime < 31536000 {
            dateFormatter.dateFormat = "dd MMMM"
            return dateFormatter.string(from: self)
        } else {
            dateFormatter.dateFormat = "MM/dd/yyyy"
            return dateFormatter.string(from: self)
        }
    }

    func displayDateTimeByTextForHistory () -> String {
        let dateFormatter = DateFormatter()
        let numberDay = Int(self.timeIntervalSince1970 / 86400)

        // số lượng ngày nếu tính từ đầu năm sau  hiện tại đến 1970
        let dayNewYear = Int(Date().timeIntervalSince1970 / 86400) - (Int(Date().timeIntervalSince1970 / 86400) % 365)

        let currentDay = Int(Date().timeIntervalSince1970 / 86400)
        if numberDay ==  currentDay {
            dateFormatter.dateFormat = "'Hôm nay' HH:mm"
            return dateFormatter.string(from: self)
        } else if numberDay ==  currentDay - 1 {
            dateFormatter.dateFormat = "'Hôm qua' HH:mm"
            return dateFormatter.string(from: self)
        } else if numberDay ==  currentDay - 2 {
            dateFormatter.dateFormat = "'Hôm kia' HH:mm"
            return dateFormatter.string(from: self)
        } else if numberDay > dayNewYear {
            dateFormatter.dateFormat = "dd/MM HH:mm"
            return dateFormatter.string(from: self)
        } else {
            dateFormatter.dateFormat = "MM/dd/yy"
            return dateFormatter.string(from: self)
        }
    }

    func displayDateByTextForHistory () -> String {
        let dateFormatter = DateFormatter()
        let numberDay = Int(self.timeIntervalSince1970 / 86400)

        // số lượng ngày nếu tính từ đầu năm sau  hiện tại đến 1970
        let dayNewYear = Int(Date().timeIntervalSince1970 / 86400) - (Int(Date().timeIntervalSince1970 / 86400) % 365)

        if numberDay > dayNewYear {
            dateFormatter.dateFormat = "dd/MM"
            return dateFormatter.string(from: self)
        } else {
            dateFormatter.dateFormat = "MM/dd/yy"
            return dateFormatter.string(from: self)
        }
    }
}
