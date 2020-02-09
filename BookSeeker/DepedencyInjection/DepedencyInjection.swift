//
//  DepedencyInjection.swift
//  BookSeeker
//
//  Created by Felipe Mendes on 09/02/20.
//  Copyright © 2020 CIT. All rights reserved.
//

import Swinject

public class DepedencyInjection {

    /// Registers and builds the dependency graph
    ///
    /// - Returns: Returns an array of assembly already registered
    public static func build() -> [Assembly] {
        return [
            FeatureAssembly(),
            ServiceAssembly()
        ]
    }
}
