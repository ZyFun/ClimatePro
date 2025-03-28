//
//  ClimateProApp.swift
//  ClimatePro
//
//  Created by Дмитрий Данилин on 27.03.2025.
//

import SwiftUI

@main
struct ClimateProApp: App {
	var body: some Scene {
		WindowGroup {
			#if os(macOS)
				TabBarConfigurator().config()
					.frame(minWidth: 550, minHeight: 400)
			#else
				TabBarConfigurator().config()
			#endif
		}
	}
}
