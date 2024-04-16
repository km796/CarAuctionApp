//
//  CarSearchUseCase.swift
//  CarAuction
//
//  Created by Kang Minsu on 4/15/24.
//

import Foundation

protocol CarSearchUseCaseProtocol: AnyObject {
    func brandResults() async -> [SearchResult]?
    func carTypeResults(brandId: Int) async -> [SearchResult]?
    func carModelResults(carTypeId: Int) async -> [SearchResult]?
}

final class CarSearchUseCase: CarSearchUseCaseProtocol {
    private let carListReposiory: CarListRepositoryProtocol
    
    init(carListReposiory: CarListRepositoryProtocol = DIContainer.shared.inject(type: CarListRepositoryProtocol.self)!) {
        self.carListReposiory = carListReposiory
    }
    
    func brandResults() async -> [SearchResult]? {
        return await carListReposiory.fetchBrandResults()
    }
    
    func carTypeResults(brandId: Int) async -> [SearchResult]? {
        return await carListReposiory.fetchCarTypeResults(brandId: brandId)
    }
    
    func carModelResults(carTypeId: Int) async -> [SearchResult]? {
        return await carListReposiory.fetchCarModelResults(carTypeId: carTypeId)
    }
}
