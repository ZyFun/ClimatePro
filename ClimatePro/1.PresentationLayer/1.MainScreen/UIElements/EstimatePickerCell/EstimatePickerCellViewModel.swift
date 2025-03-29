//
//  EstimatePickerCellViewModel.swift
//  ClimatePro
//
//  Created by Дмитрий Данилин on 30.03.2025.
//

import Observation
import SwiftUI

@Observable @MainActor
final class EstimatePickerCellViewModel {
	// MARK: - Dependencies

	private let calculateService: ICalculateService

	// MARK: - Internal Properties

	let options: [OptionsCell]
	var selectedOption: OptionsCell = .none
	/// Текущая выбранная валюта
	var currency: Currencies = .rub // TODO: () брать с настроек кор даты
	var pricePerUnit: Double = 0

	// MARK: - Private properties

	private let calculateCellType: CalculateCellType

	// MARK: - Initializer

	init (
		calculateService: ICalculateService,
		calculateCellType: CalculateCellType,
		options: [OptionsCell]
	) {
		self.calculateService = calculateService
		self.calculateCellType = calculateCellType
		self.options = options

		selectedOption = options.first ?? .none
	}

	// MARK: - Internal methods

	func setPrice() async {
		switch selectedOption {
		case .ourInstallation(price: let price): pricePerUnit = price
		case .thirdPartyInstallation(price: let price): pricePerUnit = price
		case .none: break
		}

		switch calculateCellType {
		case .setupAndCommissioning: await calculateService.setInstallationAndStartupPrice(pricePerUnit)
		}
	}
}

extension EstimatePickerCellViewModel {
	enum CalculateCellType {
		case setupAndCommissioning
	}
}

extension EstimatePickerCellViewModel {
	enum OptionsCell: Hashable {
		case ourInstallation(price: Double)
		case thirdPartyInstallation(price: Double)
		/// используется только для значения по умолчанию в случае, eсли не передали значения
		case none

		var value: LocalizedStringKey {
			switch self {
			case .ourInstallation: "Our"
			case .thirdPartyInstallation: "Third Party"
			case .none: "Not value"
			}
		}
	}
}
