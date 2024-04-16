//
//  Array+Extension.swift
//  CarAuction
//
//  Created by Kang Minsu on 4/12/24.
//

import Foundation

extension Array {
    public subscript(safe idx: Int?) -> Element? {
        guard let idx,
              indices ~= idx
        else { return nil }
        
        return self[idx]
    }
}
