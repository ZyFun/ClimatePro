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
				.background()
				.clipShape(RoundedRectangle(cornerRadius: 10))
				.shadow(color: .black.opacity(0.2), radius: 10)
		}
	}
}

#Preview {
	DTCell {
		Text("Hello, World!")
	}
}
