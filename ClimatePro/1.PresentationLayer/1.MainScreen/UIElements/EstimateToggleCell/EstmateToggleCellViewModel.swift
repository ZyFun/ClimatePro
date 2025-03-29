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

	private let calculateCellType: CalculateCellType

	// MARK: - Initializer

	init (
		calculateService: ICalculateService,
		pricePerUnit: Double,
		cellType: CalculateCellType
	) {
		self.calculateService = calculateService
		self.pricePerUnit = pricePerUnit
		self.calculateCellType = cellType
	}

	// MARK: - Internal methods

	func toggleDidChangeValue() async {
		switch calculateCellType {
		case .bracket: await calculateService.setBracketPrice(isSelected ? pricePerUnit : 0)
		}
	}
}

extension EstimateToggleCellViewModel {
	enum CalculateCellType {
		case bracket
	}
}
