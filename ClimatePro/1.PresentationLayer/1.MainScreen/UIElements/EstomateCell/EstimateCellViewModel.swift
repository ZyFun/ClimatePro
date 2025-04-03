//
//  EstimateCellViewModel.swift
//  ClimatePro
//
//  Created by Дмитрий Данилин on 28.03.2025.
//

import SwiftUI
import Observation
import RegexBuilder

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
		let enteredDataValue = Double(enteredData) ?? 0
		price = enteredDataValue * pricePerUnit

		switch calculateCellType {
		case .lengthLine:
			await calculateService.setLengthPrice(price)
		case .dkcCableTrunking:
			if price != 0 {
				price += 1000 // TODO: () Вынести цену в настройку как доп элементы к коробу.
			}
			await calculateService.setDKCCableTrunkingPrice(price)
		case .chaseGrooveAndTonguePlate:
			await calculateService.setChaseGrooveAndTonguePlatePrice(price)
		case .chaseInBrick:
			await calculateService.setChaseInBrickPrice(price)
		case .chaseInConcrete:
			await calculateService.setChaseInConcrete(price)
		case .additionalDepartures:
			await calculateService.setAdditionalDeparturesPrice(price)
		}
	}

	/// Метод для ограничения ввода символов и точек с запятыми
	/// - меняет запятую на точку
	func validateInput(_ text: String) -> String {
		let normalizedText = text.replacingOccurrences(of: ",", with: ".")

		let firstDigits = Repeat(1...6) { CharacterClass(.digit) }
		let fractionDigits = Repeat(0...2) { CharacterClass(.digit) }
		let decimalPart = Optionally { "."; fractionDigits }

		let regex = Regex {
			Anchor.startOfLine
			firstDigits
			decimalPart
			Anchor.endOfLine
		}

		if normalizedText.firstMatch(of: regex) != nil {
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
		case dkcCableTrunking
		case chaseGrooveAndTonguePlate
		case chaseInBrick
		case chaseInConcrete
		case additionalDepartures
	}
}
