//
//  CarsDTO.swift
//  CarAuction
//
//  Created by Kang Minsu on 4/11/24.
//

import Foundation

// MARK: - CarsDTO
struct CarsDTO: Codable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [Result]
    
    // MARK: - Result
    struct Result: Codable, Hashable {
        let uuid = UUID()
        let id: Int?
        let detail: Detail?
        let auction: Auction?

        enum CodingKeys: String, CodingKey {
            case id
            case detail
            case auction
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
        
        static func == (lhs: CarsDTO.Result, rhs: CarsDTO.Result) -> Bool {
            lhs.hashValue == rhs.hashValue
        }
    }

    // MARK: - Auction
    struct Auction: Codable {
        let startedAt: String?
        let endAt: String?
        let expireAt: String?
        let status: Status?
        let highestBidPrice: Int?
        let bidsCount: Int?

        enum CodingKeys: String, CodingKey {
            case startedAt = "started_at"
            case endAt = "end_at"
            case expireAt = "expire_at"
            case status
            case highestBidPrice = "highest_bid_price"
            case bidsCount = "bids_count"
        }
    }

    enum Status: String, Codable {
        case approved = "approved"
        case ended = "ended"
        case expired = "expired"
    }

    // MARK: - Detail
    struct Detail: Codable {
        let name: String?
        let model: Int?
        let location: String?
        let carNumber: String?
        let year: Int?
        let fuel: Fuel?
        let color: String?
        let mileage: Int?
        let transmission: Transmission?
        let initialRegistrationDate: String?
        let mainImage: MainImage?

        enum CodingKeys: String, CodingKey {
            case name
            case model
            case location
            case carNumber = "car_number"
            case year
            case fuel
            case color
            case mileage
            case transmission
            case initialRegistrationDate = "initial_registration_date"
            case mainImage = "main_image"
        }
    }

    enum Fuel: String, Codable {
        case diesel = "diesel"
        case gasoline = "gasoline"
        case lpg = "lpg"
        case electric = "electric"
        case hybrid = "hybrid"
        case bifuel = "bifuel"
    }

    // MARK: - MainImage
    struct MainImage: Codable {
        let url: String?
        let isMain: Bool?

        enum CodingKeys: String, CodingKey {
            case url
            case isMain = "is_main"
        }
    }

    enum Transmission: String, Codable {
        case auto = "auto"
        case manual = "manual"
    }
}

extension CarsDTO.Result {
    var toEntity: CarEntity {
        let mileage = (detail?.mileage ?? 0) / 10000
        
        return .init(
            id: id ?? 0,
            name: detail?.name ?? "",
            imageUrl: detail?.mainImage?.url ?? "",
            mileage: "\(mileage)만",
            city: detail?.location ?? "",
            year: detail?.year ?? 0,
            auctionEndAt: auction?.endAt ?? "",
            auctionExpireAt: auction?.expireAt ?? ""
        )
    }
}
