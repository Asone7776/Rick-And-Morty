//
//  Common.swift
//  Rick And Morty
//
//  Created by Uzkassa on 25/03/23.
//

import Foundation



extension Date {
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}
