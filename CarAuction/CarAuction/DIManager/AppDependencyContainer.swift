//
//  AppDependencyContainer.swift
//  CarAuction
//
//  Created by Kang Minsu on 4/15/24.
//

import Foundation

protocol DIContainerProtocol {
    func register<Service>(type: Service.Type, component: Any)
    func inject<Service>(type: Service.Type) -> Service?
}

final class DIContainer: DIContainerProtocol {
    
    static let shared = DIContainer()
    
    private init() {}
    
    var services: [String: Any] = [:]
    
    func register<Service>(type: Service.Type, component service: Any) {
        services["\(type)"] = service
    }
    
    func inject<Service>(type: Service.Type) -> Service? {
        return services["\(type)"] as? Service
    }
}

extension DIContainer {
    func registration() {
        // Repositories
        register(type: CarListRepositoryProtocol.self, component: CarListRepository())
        register(type: CarDetailRepositoryProtocol.self, component: CarDetailRepository())
        
        // UseCases
        register(type: CarListUseCaseProtocol.self, component: CarListUseCase())
        register(type: CarSearchUseCaseProtocol.self, component: CarSearchUseCase())
        register(type: CarDetailUseCaseProtocol.self, component: CarDetailUseCase())
    }
}
