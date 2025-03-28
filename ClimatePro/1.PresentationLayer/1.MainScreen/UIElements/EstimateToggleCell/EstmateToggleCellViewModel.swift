//
//  EstimateToggleCellViewModel.swift
//  ClimatePro
//
//  Created by Дмитрий Данилин on 29.03.2025.
//

import Observation

@Observable @MainActor
final class EstimateToggleCellViewModel {
	// MARK: - Dependencies

	private let calculateService: ICalculateService

	// MARK: - Internal Properties

	var isSelected: Bool = false
	/// Текущая выбранная валюта
	var currency: Currencies = .rub // TODO: () брать с настроек кор даты
	let pricePerUnit: Double

	// MARK: - Private properties

	// MARK: - Initializer

	init (
		calculateService: ICalculateService,
		pricePerUnit: Double
	) {
		self.calculateService = calculateService
		self.pricePerUnit = pricePerUnit
	}

	// MARK: - Internal methods

	func toggleDidChangeValue() async {
		await calculateService.setBracketPrice(isSelected ? pricePerUnit : 0)
	}
}
