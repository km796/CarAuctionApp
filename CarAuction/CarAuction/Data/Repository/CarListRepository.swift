//
//  CarListRepository.swift
//  CarAuction
//
//  Created by Kang Minsu on 4/15/24.
//

import Foundation

protocol CarListRepositoryProtocol {
    func fetchCarList(id: Int?) async -> CarsDTO?
    
    func fetchBrandResults() async -> [SearchResult]?
    func fetchCarTypeResults(brandId: Int) async -> [SearchResult]?
    func fetchCarModelResults(carTypeId: Int) async -> [SearchResult]?
}

final class CarListRepository: CarListRepositoryProtocol {
    private let host = "recruit.heydealer.com"
    private var baseComponent: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        return components
    }
    
    func fetchCarList(id: Int?) async -> CarsDTO? {
        var components = baseComponent
        components.path = "/cars"
        if let id {
            components.queryItems = [.init(name: "model", value: "\(id)")]
        }
        
        let url = components.url
        return await NetworkClient.shared.request(url: url!, modelType: CarsDTO.self)
    }

    func fetchBrandResults() async -> [SearchResult]? {
        var components = baseComponent
        components.path = "/car_meta/brands"
        
        let url = components.url
        guard let dto = await NetworkClient.shared.request(url: url!, modelType: [BrandDTO].self)
        else { return nil }
        return dto.toEntity
    }
    
    func fetchCarTypeResults(brandId: Int) async -> [SearchResult]? {
        var components = baseComponent
        components.path = "/car_meta/brands/\(brandId)/model_groups"
        
        let url = components.url
        guard let dto = await NetworkClient.shared.request(url: url!, modelType: [CarTypeDTO].self)
        else { return nil }
        return dto.toEntity
    }
    
    func fetchCarModelResults(carTypeId: Int) async -> [SearchResult]? {
        var components = baseComponent
        components.path = "/car_meta/model_groups/\(carTypeId)/models"
    
        let url = components.url
        guard let dto = await NetworkClient.shared.request(url: url!, modelType: [CarModelDTO].self)
        else { return nil }
        return dto.toEntity
    }
}
