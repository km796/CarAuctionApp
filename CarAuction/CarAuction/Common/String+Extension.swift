//
//  String+Extension.swift
//  CarAuction
//
//  Created by Kang Minsu on 4/16/24.
//

import Foundation

extension String {
    var toDate: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.date(from: self)
    }
}
