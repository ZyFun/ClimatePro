//
//  MainScreenConfigurator.swift
//  ClimatePro
//
//  Created by Дмитрий Данилин on 28.03.2025.
//

final class MainScreenConfigurator {
	// MARK: - Private properties

	// MARK: - Initializer

	init() {}

	// MARK: - Internal methods

	@MainActor func config() -> MainScreen {
		let model = MainScreenViewModel()
		let lengthCellViewModel = SmetaCellViewModel(pricePerUnit: 1450) // TODO: () Вынести цену в хранилище coreData
		let additionalDeparturesCellModel = SmetaCellViewModel(pricePerUnit: 1000) // TODO: () Вынести цену в хранилище coreData
		let view = MainScreen(
			viewModel: model,
			lengthCellViewModel: lengthCellViewModel,
			additionalDeparturesCellViewModel: additionalDeparturesCellModel
		)
		return view
	}
}
