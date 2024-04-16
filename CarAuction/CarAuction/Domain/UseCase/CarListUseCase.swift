//
//  CarListUseCase.swift
//  CarAuction
//
//  Created by Kang Minsu on 4/15/24.
//

import Foundation

protocol CarListUseCaseProtocol: AnyObject {
    func execute(id: Int?) async -> CarsDTO?
}

final class CarListUseCase: CarListUseCaseProtocol {
    private let carListReposiory: CarListRepositoryProtocol
    
    init(carListReposiory: CarListRepositoryProtocol = DIContainer.shared.inject(type: CarListRepositoryProtocol.self)!) {
        self.carListReposiory = carListReposiory
    }
    
    func execute(id: Int?) async -> CarsDTO? {
        return await carListReposiory.fetchCarList(id: id)
    }
}
