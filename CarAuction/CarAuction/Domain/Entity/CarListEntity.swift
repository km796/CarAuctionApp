//
//  CarListEntity.swift
//  CarAuction
//
//  Created by Kang Minsu on 4/12/24.
//

import Foundation

struct CarListEntity: Hashable {
    let uuid = UUID()
    let results: [CarEntity]
    let column: Column
    
    enum Column {
        case one
        case two
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
    
    static func == (lhs: CarListEntity, rhs: CarListEntity) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
}

struct CarEntity {
    let id: Int
    let name: String
    let imageUrl: String
    let mileage: String
    let city: String
    let year: Int
    
    let auctionEndAt: String
    let auctionExpireAt: String
}

