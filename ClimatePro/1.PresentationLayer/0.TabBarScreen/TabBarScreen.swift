//
//  TabBarScreen.swift
//  ClimatePro
//
//  Created by Дмитрий Данилин on 28.03.2025.
//

import SwiftUI

struct TabBarScreen: View {
	// MARK: - Property wrappers

	@State var viewModel: TabBarViewModel

	// MARK: - Body

	var body: some View {
		if #available(iOS 18.0, *) {
			TabView {
				buildMainScreen()
				buildSettingsScreen()
			}
			.tabViewStyle(.sidebarAdaptable)
			.dynamicTypeSize(.xSmall ... .xxxLarge)
		} else {
			TabView {
				buildMainScreen()
				buildSettingsScreen()
			}
			.dynamicTypeSize(.xSmall ... .xxxLarge)
		}
	}

	// MARK: - View Builder Methods

	private func buildMainScreen() -> some View {
		PresentationAssembly().mainScreen.config()
			.tabItem {
				Image(systemName: "doc.text")
				Text("Estimate")
			}
	}

	private func buildSettingsScreen() -> some View {
		Text("Экран на стадии разработки")
			.tabItem {
				Image(systemName: "gear")
				Text("Settings")
			}
	}

	// MARK: - Private methods

}

// MARK: - Preview

#Preview {
	TabBarConfigurator().config()
}
