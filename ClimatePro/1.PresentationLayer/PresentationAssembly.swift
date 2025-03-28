//
//  PresentationAssembly.swift
//  ClimatePro
//
//  Created by Дмитрий Данилин on 28.03.2025.
//

final class PresentationAssembly {
	private let serviceAssembly = ServiceAssembly()

	private let calculateService: ICalculateService

	init() {
		calculateService = serviceAssembly.calculateService
	}

	lazy var mainScreen: MainScreenConfigurator = {
		return MainScreenConfigurator(
			calculateService: calculateService
		)
	}()
}
