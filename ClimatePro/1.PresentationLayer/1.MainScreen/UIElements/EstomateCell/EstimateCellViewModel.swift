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

	var enteredData: String = ""
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

	func calculatePrice() async {
		guard let enteredDataValue = Double(enteredData) else { return }
		price = enteredDataValue * pricePerUnit

		switch calculateCellType {
		case .lengthLine: await calculateService.setLengthPrice(price)
		case .chaseGrooveAndTonguePlate: await calculateService.setChaseGrooveAndTonguePlatePrice(price)
		case .chaseInBrick: await calculateService.setChaseInBrickPrice(price)
		case .chaseInConcrete: await calculateService.setChaseInConcrete(price)
		case .additionalDepartures: await calculateService.setAdditionalDeparturesPrice(price)
		}
	}

	/// Метод для ограничения ввода символов и точек с запятыми
	/// - меняет запятую на точку
	func validateInput(_ text: String) -> String {
		let normalizedText = text.replacingOccurrences(of: ",", with: ".")
		let regex = "^[0-9]{1,6}([.][0-9]{0,2})?$"
		if normalizedText.range(of: regex, options: .regularExpression) != nil {
			return normalizedText
		} else {
			return String(text.dropLast())
		}
	}
}

// MARK: - CalculateCellType

extension EstimateCellViewModel {
	enum CalculateCellType {
		case lengthLine
		case chaseGrooveAndTonguePlate
		case chaseInBrick
		case chaseInConcrete
		case additionalDepartures
	}
}
