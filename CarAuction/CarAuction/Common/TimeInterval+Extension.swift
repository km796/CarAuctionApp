//
//  TimeInterval+Extension.swift
//  CarAuction
//
//  Created by Kang Minsu on 4/16/24.
//

import Foundation

extension TimeInterval {
    var toTime: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: self)!
    }
}
