//
//  BrandDTO.swift
//  CarAuction
//
//  Created by Kang Minsu on 4/15/24.
//

import Foundation

struct BrandDTO: Decodable {
    let id: Int
    let name: String
    let auctionsCount: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case auctionsCount = "auctions_count"
    }
}

struct CarTypeDTO: Decodable {
    let id: Int
    let name: String
    let brand: Int
    let auctionsCount: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case brand
        case auctionsCount = "auctions_count"
    }
}

struct CarModelDTO: Decodable {
    let id: Int
    let name: String
    let auctionsCount: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case auctionsCount = "auctions_count"
    }
}

extension [BrandDTO] {
    var toEntity: [SearchResult] {
        self.map { .init(id: $0.id, name: $0.name, count: $0.auctionsCount)}
    }
}

extension [CarTypeDTO] {
    var toEntity: [SearchResult] {
        self.map { .init(id: $0.id, name: $0.name, count: $0.auctionsCount)}
    }
}

extension [CarModelDTO] {
    var toEntity: [SearchResult] {
        self.map { .init(id: $0.id, name: $0.name, count: $0.auctionsCount)}
    }
}
