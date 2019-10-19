//
//  ServiceLocator.swift
//  Otus_HW_7
//
//  Created by alex on 07/09/2019.
//  Copyright © 2019 Mezencev Aleksei. All rights reserved.
//

import Foundation

protocol ServiceLocating {
    func getService<T>() -> T?
}

final class ServiceLocator: ServiceLocating {
    
    private lazy var services: Dictionary<String, Any> = [:]
    
    private init() {
        addService(service: Services.feedDataProvider)
        addService(service: Services.layoutProvider)
        addService(service: Services.stringGenerator)
        addService(service: Services.algoProvider)
    }
    
    public static let shared = ServiceLocator()
    
    private func typeName(some: Any) -> String {
        return (some is Any.Type) ?
            "\(some)" : "\(type(of: some))"
    }
    
    func addService<T>(service: T) {
        let key = typeName(some: T.self)
        services[key] = service
    }
    
    func getService<T>() -> T? {
        let key = typeName(some: T.self)
        return services[key] as? T
    }
}
