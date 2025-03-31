//
//  EstimateToggleCell.swift
//  ClimatePro
//
//  Created by Дмитрий Данилин on 29.03.2025.
//

import SwiftUI

struct EstimateToggleCellView: View {
	// MARK: - Property wrappers

	@Bindable var viewModel: EstimateToggleCellViewModel

	let text: LocalizedStringKey

	// MARK: - Body

	var body: some View {
		buildCell()
	}

	// MARK: - View Builder Methods

	private func buildCell() -> some View {
		DTCell {
			VStack(alignment: .leading) {
				Toggle(text, isOn: $viewModel.isSelected)
					.onChange(of: viewModel.isSelected) {
						Task(priority: .userInitiated) {
							await viewModel.toggleDidChangeValue()
						}
					}
				Text(
					viewModel.pricePerUnit,
					format: .currency(code: viewModel.currency.code)
				)
				.dynamicTypeSize(.xSmall ... .xxLarge)
				.foregroundStyle(.secondary)
				.frame(maxWidth: .infinity, alignment: .leading)
			}
		}
	}

	// MARK: - Private methods

}

// MARK: - Preview

#Preview {
	EstimateToggleCellView(
		viewModel: .init(
			calculateService: CalculateService(),
			pricePerUnit: 1000,
			cellType: .bracket
		), text: "bracket"
	)
}
