//
//  DTFullScreenBackgroundModifier.swift
//  ClimatePro
//
//  Created by Дмитрий Данилин on 01.04.2025.
//

import SwiftUI

struct DTFullScreenBackgroundModifier: ViewModifier {
	var color: Color

	func body(content: Content) -> some View {
		ZStack {
			color
				.edgesIgnoringSafeArea(.all)
			content
		}
	}
}

extension View {
	func dtFullScreenBackground(_ color: Color) -> some View {
		self.modifier(DTFullScreenBackgroundModifier(color: color))
	}
}
