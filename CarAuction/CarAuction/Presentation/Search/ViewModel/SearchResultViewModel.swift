//
//  SearchResultViewModel.swift
//  CarAuction
//
//  Created by Kang Minsu on 4/15/24.
//

import Foundation

class SearchResultViewModel: ObservableObject {
    @Published var brandResults: [SearchResult] = []
    @Published var carTypeResults: [SearchResult] = []
    @Published var carModelResults: [SearchResult] = []
    
    private let carSearchUseCase: CarSearchUseCaseProtocol
    
    init(carSearchUseCase: CarSearchUseCaseProtocol = DIContainer.shared.inject(type: CarSearchUseCaseProtocol.self)!) {
        self.carSearchUseCase = carSearchUseCase
    }
    
    func getBrandResults() {
        Task {
            if let fetchResults = await carSearchUseCase.brandResults() {
                await MainActor.run { brandResults = fetchResults.filter { $0.count > 0 } }
            }
        }
    }
    
    func getCarTypeResults(brandId: Int) {
        Task {
            if let fetchResults = await carSearchUseCase.carTypeResults(brandId: brandId) {
                await MainActor.run { carTypeResults = fetchResults.filter { $0.count > 0 }  }
            }
        }
    }
    
    func getCarModelResults(carTypeId: Int) {
        Task {
            if let fetchResults = await carSearchUseCase.carModelResults(carTypeId: carTypeId) {
                await MainActor.run { carModelResults = fetchResults.filter { $0.count > 0 }  }
            }
        }
    }
}
