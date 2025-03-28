//
//  TabBarConfigurator.swift
//  ClimatePro
//
//  Created by Дмитрий Данилин on 28.03.2025.
//

final class TabBarConfigurator {
	// MARK: - Private properties

	// MARK: - Initializer

	init() {}

	// MARK: - Internal methods

	@MainActor func config() -> TabBarScreen {
		let model = TabBarViewModel()
		let view = TabBarScreen(viewModel: model)
		return view
	}
}
