//
//  MainScreenConfigurator.swift
//  ClimatePro
//
//  Created by Дмитрий Данилин on 28.03.2025.
//

final class MainScreenConfigurator {
	// MARK: - Private properties

	private let calculateService: ICalculateService

	// MARK: - Initializer

	init(
		calculateService: ICalculateService
	) {
		self.calculateService = calculateService
	}

	// MARK: - Internal methods

	@MainActor func config() -> MainScreen {
		let model = MainScreenViewModel(
			calculateService: calculateService
		)
		let lengthCellViewModel = EstimateCellViewModel(
			calculateService: calculateService,
			pricePerUnit: 1450, // TODO: () Вынести цену в хранилище coreData
			cellType: .lengthLine
		)
		let chaseGrooveAndTonguePlateCellViewModel = EstimateCellViewModel(
			calculateService: calculateService,
			pricePerUnit: 950, // TODO: () Вынести цену в хранилище coreData
			cellType: .chaseGrooveAndTonguePlate
		)
		let chaseInBrick = EstimateCellViewModel(
			calculateService: calculateService,
			pricePerUnit: 1400, // TODO: () Вынести цену в хранилище coreData
			cellType: .chaseInBrick
		)
		let chaseInConcrete = EstimateCellViewModel(
			calculateService: calculateService,
			pricePerUnit: 1800, // TODO: () Вынести цену в хранилище coreData
			cellType: .chaseInConcrete
		)
		let bracketSelectCellViewModel = EstimateToggleCellViewModel(
			calculateService: calculateService,
			pricePerUnit: 1000 // TODO: () Вынести цену в хранилище coreData
		)
		let additionalDeparturesCellModel = EstimateCellViewModel(
			calculateService: calculateService,
			pricePerUnit: 1000, // TODO: () Вынести цену в хранилище coreData
			cellType: .additionalDepartures
		)
		let view = MainScreen(
			viewModel: model,
			lengthCellViewModel: lengthCellViewModel,
			chaseGrooveAndTonguePlateCellViewModel: chaseGrooveAndTonguePlateCellViewModel,
			chaseInBrick: chaseInBrick,
			chaseInConcrete: chaseInConcrete,
			bracketSelectCellViewModel: bracketSelectCellViewModel,
			additionalDeparturesCellViewModel: additionalDeparturesCellModel
		)
		return view
	}
}
