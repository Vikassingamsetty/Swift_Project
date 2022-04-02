//
//  String+Extension.swift
//  NewsApp
//
//  Created by Singamsetty Vikas on 01/04/22.
//
import Foundation

extension String {
    var asURL: URL? {
        return URL(string: self)
    }
    
    func dateToString() -> Self {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssz" //2020-08-12T12:53:53Z       "2020-09-03T08:52:31Z";
        let date = dateFormatter.date(from: self)
        dateFormatter.dateFormat = "EEE, MMM yy, hh:mm a"
        return  dateFormatter.string(from: date!)
    }
    
    func convertToUTC() -> Self {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssz"
        let convertedDate = formatter.date(from: self)
        formatter.timeZone = TimeZone(identifier: "UTC")
        return formatter.string(from: convertedDate!)
    }
}
