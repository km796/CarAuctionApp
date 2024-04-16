//
//  CarDetailUseCase.swift
//  CarAuction
//
//  Created by Kang Minsu on 4/15/24.
//

import Foundation

protocol CarDetailUseCaseProtocol: AnyObject {
    func execute(id: Int) async -> CarDetailDTO?
}

final class CarDetailUseCase: CarDetailUseCaseProtocol {
    private let carDetailRepository: CarDetailRepositoryProtocol
    
    init(carDetailRepository: CarDetailRepositoryProtocol = DIContainer.shared.inject(type: CarDetailRepositoryProtocol.self)!) {
        self.carDetailRepository = carDetailRepository
    }
    
    func execute(id: Int) async -> CarDetailDTO? {
        return await carDetailRepository.fetchCarDetail(id: id)
    }
}
