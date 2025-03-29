//
//  ClimateProApp.swift
//  ClimatePro
//
//  Created by Дмитрий Данилин on 27.03.2025.
//

import SwiftUI

@main
struct ClimateProApp: App {
	private let sizeWindow: CGSize = .init(width: 550, height: 400)

	var body: some Scene {
		#if os(macOS)
		Window("Estimate", id: "estimate") {
			TabBarConfigurator().config()
				.frame(minWidth: sizeWindow.width, minHeight: sizeWindow.height)
				.toolbar(removing: .title)
				.toolbarBackgroundVisibility(.hidden, for: .windowToolbar)
		}
		.defaultWindowPlacement { _, _ in
			WindowPlacement(.center, size: sizeWindow)
		}
		#else
		WindowGroup {
			TabBarConfigurator().config()
		}
		#endif
	}
}
