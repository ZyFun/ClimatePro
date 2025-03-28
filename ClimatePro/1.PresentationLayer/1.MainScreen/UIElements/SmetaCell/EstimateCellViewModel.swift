//
//  EstimateCellViewModel.swift
//  ClimatePro
//
//  Created by Дмитрий Данилин on 28.03.2025.
//

import SwiftUI
import Observation

@Observable @MainActor
final class EstimateCellViewModel {
	// MARK: - Dependencies

	private let calculateService: ICalculateService

	// MARK: - Internal Properties

	var enteredData: String = "" {
		didSet {
			Task(priority: .userInitiated) {
				await calculatePrice()
			}
		}
	}
	var price: Double = 0.0
	var pricePerUnit: Double

	/// Текущая выбранная валюта
	var currency: Currencies = .rub // TODO: () брать с настроек кор даты

	// MARK: - Private properties

	private let calculateCellType: CalculateCellType

	// MARK: - Initializer

	init(
		calculateService: ICalculateService,
		pricePerUnit: Double,
		cellType: CalculateCellType
	) {
		self.calculateService = calculateService
		self.pricePerUnit = pricePerUnit
		self.calculateCellType = cellType
	}

	// MARK: - Internal methods

	func localizedUnitSymbol(for unit: UnitLength?) -> String {
		guard let unit else { return "" }
		let formatter = MeasurementFormatter()
		formatter.unitOptions = .providedUnit
		formatter.locale = Locale(identifier: Locale.current.identifier)
		return formatter.string(from: unit)
	}

	private func calculatePrice() async {
		guard let enteredDataValue = Double(enteredData) else { return }
		price = enteredDataValue * pricePerUnit

		switch calculateCellType {
		case .lengthLine: await calculateService.setLengthPrice(price)
		case .chaseGrooveAndTonguePlate: await calculateService.setChaseGrooveAndTonguePlatePrice(price)
		case .additionalDepartures: await calculateService.setAdditionalDeparturesPrice(price)
		}
	}
}

// MARK: - CalculateCellType

extension EstimateCellViewModel {
	enum CalculateCellType {
		case lengthLine
		case chaseGrooveAndTonguePlate
		case additionalDepartures
	}
}
