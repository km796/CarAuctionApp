//
//  CarDetailRepository.swift
//  CarAuction
//
//  Created by Kang Minsu on 4/15/24.
//

import Foundation

protocol CarDetailRepositoryProtocol {
    func fetchCarDetail(id: Int) async -> CarDetailDTO?
}

final class CarDetailRepository: CarDetailRepositoryProtocol {
    private let host = "recruit.heydealer.com"
    private var baseComponent: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        return components
    }
    
    func fetchCarDetail(id: Int) async -> CarDetailDTO? {
        var components = baseComponent
        components.path = "/cars/\(id)"
        
        return await NetworkClient.shared.request(url: components.url!, modelType: CarDetailDTO.self)
    }
}
