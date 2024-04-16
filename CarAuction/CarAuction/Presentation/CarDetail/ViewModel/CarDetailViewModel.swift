//
//  CarDetailViewModel.swift
//  CarAuction
//
//  Created by Kang Minsu on 4/16/24.
//

import Foundation

class CarDetailViewModel: ObservableObject {
    @Published var carDetail = CarDetailDTO()
    @Published var untilEnd: TimeInterval = 0
    @Published var untilExpire: TimeInterval = 0
    
    private let carDetailUseCase: CarDetailUseCaseProtocol
    
    init(carDetailUseCase: CarDetailUseCaseProtocol = DIContainer.shared.inject(type: CarDetailUseCaseProtocol.self)!) {
        self.carDetailUseCase = carDetailUseCase
    }
    
    func getDetail(id: Int) async {
        guard let detail = await carDetailUseCase.execute(id: id) else { return }
        await MainActor.run { carDetail = detail }
        await updateRemainingTime()
    }
    
    @MainActor
    func updateRemainingTime() {
        guard let endAt = carDetail.auction?.endAt.toDate,
              let expireAt = carDetail.auction?.expireAt.toDate
        else { return }
        untilEnd = max(endAt.timeIntervalSinceNow, 0)
        untilExpire = max(expireAt.timeIntervalSinceNow, 0)
    }
    
    private func timeConverter(time: String?) -> Date? {
        guard let time else { return nil }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.date(from: time)
    }
}
