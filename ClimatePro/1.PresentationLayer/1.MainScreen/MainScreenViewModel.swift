//
//  MainScreenViewModel.swift
//  ClimatePro
//
//  Created by Дмитрий Данилин on 28.03.2025.
//

import SwiftUI
import Observation

@Observable @MainActor
final class MainScreenViewModel {
	// MARK: - Dependencies

	let calculateService: ICalculateService

	// MARK: - Internal Properties

	var totalPrice: Double = 0

	// MARK: - Private properties

	// MARK: - Initializer

	init(
		calculateService: ICalculateService
	) {
		self.calculateService = calculateService
	}

	// MARK: - Internal methods

	func calculateButtonPressed() async {
		totalPrice = await calculateService.calculateTotalPrice()
	}

	// MARK: - Navigation

}
