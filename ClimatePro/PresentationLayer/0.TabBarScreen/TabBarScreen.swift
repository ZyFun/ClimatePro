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
			}.tabViewStyle(.sidebarAdaptable)
		} else {
			TabView {
				buildMainScreen()
			}
		}
	}

	// MARK: - View Builder Methods

	private func buildMainScreen() -> some View {
		MainScreenConfigurator().config()
			.tabItem {
				Image(systemName: "doc.text")
				Text("Estimate")
			}
	}

	// MARK: - Private methods

}

// MARK: - Preview

#Preview {
	TabBarConfigurator().config()
}
