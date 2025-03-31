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

	@MainActor func config() -> MainScreen { // swiftlint:disable:this function_body_length
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
		let installationAndStartupViewModel = EstimatePickerCellViewModel(
			calculateService: calculateService,
			calculateCellType: .setupAndCommissioning,
			options: [
				.ourInstallation(price: 6700), // TODO: () Вынести цену в хранилище coreData
				.thirdPartyInstallation(price: 8500) // TODO: () Вынести цену в хранилище coreData
			]
		)

		let bracketSelectCellViewModel = EstimateToggleCellViewModel(
			calculateService: calculateService,
			pricePerUnit: 1000, // TODO: () Вынести цену в хранилище coreData
			cellType: .bracket
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
			chaseInBrickViewModel: chaseInBrick,
			chaseInConcreteViewModel: chaseInConcrete,
			installationAndStartupViewModel: installationAndStartupViewModel,
			bracketSelectCellViewModel: bracketSelectCellViewModel,
			additionalDeparturesCellViewModel: additionalDeparturesCellModel
		)
		return view
	}
}
