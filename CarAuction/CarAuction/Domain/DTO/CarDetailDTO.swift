//
//  CarDetailDTO.swift
//  CarAuction
//
//  Created by Kang Minsu on 4/15/24.
//

// MARK: - CarDetailDTO
struct CarDetailDTO: Decodable, Identifiable {
    var id: Int?
    var detail: Detail?
    var auction: Auction?

    enum CodingKeys: String, CodingKey {
        case id
        case detail
        case auction
    }
}

extension CarDetailDTO {
    // MARK: - Auction
    struct Auction: Decodable {
        let startedAt: String
        let endAt: String
        let expireAt: String
        let status: String
        let highestBidPrice: Int
        let bidsCount: Int
        
        enum CodingKeys: String, CodingKey {
            case startedAt = "started_at"
            case endAt = "end_at"
            case expireAt = "expire_at"
            case status
            case highestBidPrice = "highest_bid_price"
            case bidsCount = "bids_count"
        }
    }
    
    // MARK: - Detail
    struct Detail: Decodable {
        let name: String
        let model: Int
        let location: String
        let carNumber: String
        let year: Int
        let fuel: String
        let color: String
        let mileage: Int
        let transmission: String
        let initialRegistrationDate: String
        let images: [Image]
        
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
            case images
        }
    }
    
    // MARK: - Image
    struct Image: Decodable, Hashable {
        let url: String
        let isMain: Bool
        
        enum CodingKeys: String, CodingKey {
            case url
            case isMain = "is_main"
        }
    }
}
