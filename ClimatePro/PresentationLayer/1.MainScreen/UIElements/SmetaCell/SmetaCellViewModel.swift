//
//  SmetaCellViewModel.swift
//  ClimatePro
//
//  Created by Дмитрий Данилин on 28.03.2025.
//

import SwiftUI
import Observation

@Observable @MainActor
final class SmetaCellViewModel {
	// MARK: - Dependencies

	// MARK: - Internal Properties

	var enteredData: String = "" {
		didSet { calculatePrice() }
	}
	var price: Double = 0.0
	var pricePerUnit: Double

	/// Текущая выбранная валюта
	var currency: Currencies = .rub // TODO: () брать с настроек кор даты

	// MARK: - Private properties

	// MARK: - Initializer

	init(pricePerUnit: Double) {
		self.pricePerUnit = pricePerUnit
	}

	// MARK: - Internal methods

	private func calculatePrice() {
		guard let enteredDataValue = Double(enteredData) else { return }
		price = enteredDataValue * pricePerUnit
	}
}
