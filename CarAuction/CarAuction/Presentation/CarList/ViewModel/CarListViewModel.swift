//
//  CarListViewModel.swift
//  CarAuction
//
//  Created by Kang Minsu on 4/11/24.
//

import Foundation

class CarListViewModel: ObservableObject {
    @Published var carListEntities: [CarListEntity] = []
    @Published var isCurrentlyRefreshing = false
    
    private let carListUseCase: CarListUseCaseProtocol
    
    var nextPageUrl: String?
    
    init(carListUseCase: CarListUseCaseProtocol = DIContainer.shared.inject(type: CarListUseCaseProtocol.self)!) {
        self.carListUseCase = carListUseCase
    }
    
    func getCars(id: Int? = nil) async {
        if let fetchedCars = await carListUseCase.execute(id: id) {
            await MainActor.run {
                nextPageUrl = fetchedCars.next
                carListEntities = fetchedCars.results.map { $0.toEntity }.forList
            }
        }
    }
    
    func loadNext() {
        guard let nextPageUrl = self.nextPageUrl else { return }
        Task {
            if let fetchedCars = await NetworkClient.shared.request(urlString: nextPageUrl, modelType: CarsDTO.self) {
                self.nextPageUrl = fetchedCars.next
                await MainActor.run {
                    let nextResults = fetchedCars.results.map { $0.toEntity }.forList
                    carListEntities.append(contentsOf: nextResults)
                }
            }
        }
    }
    
    func refresh(id: Int? = nil) {
        guard !isCurrentlyRefreshing else { return }
        isCurrentlyRefreshing = true
        Task {
            await getCars(id: id)
            await MainActor.run { isCurrentlyRefreshing = false }
        }
    }
}

extension [CarEntity] {
    var forList: [CarListEntity] {
        var res: [CarListEntity] = []
        var idx = 0
        while idx < self.count {
            if idx == 0 || idx % 5 == 0 {
                let singleColEntity = CarListEntity(results: [self[idx]], column: .one)
                res.append(singleColEntity)
                idx += 1
            } else {
                var temp = [self[idx]]
                if let element = self[safe: idx+1] {
                    temp.append(element)
                }
                let twoColEntity = CarListEntity(results: temp, column: .two)
                res.append(twoColEntity)
                idx += 2
            }
        }
        return res
    }
}
