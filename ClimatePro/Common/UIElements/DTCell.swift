//
//  DTCell.swift
//  ClimatePro
//
//  Created by Дмитрий Данилин on 29.03.2025.
//

import SwiftUI

struct DTCell<Content: View>: View {
	@ViewBuilder let content: () -> Content
	var body: some View {
		VStack(spacing: 0) {
			content()
				.frame(maxWidth: .infinity)
				.padding()
				.background(.backgroundMainElement)
				.clipShape(RoundedRectangle(cornerRadius: 10))
				.shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: 0)
		}
	}
}

#Preview {
	DTCell {
		Text("Hello, World!")
	}
}
