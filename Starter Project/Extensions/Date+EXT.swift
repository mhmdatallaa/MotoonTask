//
//  Date+EXT.swift
//  Starter Project
//
//  Created by Mohamed Atallah on 29/03/2023.
//

import Foundation


extension Date {
    
    enum DateFormat: String {
        case MMMyyy, MMMyy, MMMdyyy
    }
    
    
    func changeDateFormat(to format: DateFormat) -> String {
        let dateFormatter = DateFormatter()
        var dateFormat = ""
        
        switch format {
        case .MMMyyy:
            dateFormat = "MMM yyy"
        case .MMMyy:
            dateFormat = "MMM yy"
        case .MMMdyyy:
            dateFormat = "MMMd yyy"
        }
        
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: self)
    }
    
}
