//
//  Date+Extension.swift
//  WeatherApp
//
//  Created by Евгений Беляков on 25.03.2024.
//

import Foundation

extension Date{
    func compareWithCurrent(onlyByDate: Bool) -> Bool{
        let dateFormatter = DateFormatter()
        if !onlyByDate {
            dateFormatter.dateFormat = "yyyy-MM-dd HH:00"
            return dateFormatter.string(from: Date.now) == dateFormatter.string(from: self)
        }
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: Date.now) == dateFormatter.string(from: self)
    }
}
