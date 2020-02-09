//
//  ServiceAssembly.swift
//  BookSeeker
//
//  Created by Felipe Mendes on 09/02/20.
//  Copyright © 2020 CIT. All rights reserved.
//

import Swinject

public class ServiceAssembly: Assembly {

    public func assemble(container: Container) {

        // MARK: - ServiceManager

        container.register(ServiceManager.self) { _ in
            return ServiceManager()
        }
    }
}
