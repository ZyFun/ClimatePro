//
//  EstimatePickerCellView.swift
//  ClimatePro
//
//  Created by Дмитрий Данилин on 30.03.2025.
//

import SwiftUI

struct EstimatePickerCellView: View {
	// MARK: - Property wrappers

	@Bindable var viewModel: EstimatePickerCellViewModel

	let text: LocalizedStringKey

	// MARK: - Body

	var body: some View {
		buildCell()
	}

	// MARK: - View Builder Methods

	private func buildCell() -> some View {
		DTCell {
			VStack(alignment: .leading) {
				HStack {
					Text(text)
					Spacer()
					Picker("", selection: $viewModel.selectedOption) {
						ForEach(viewModel.options, id: \.self) { option in
							Text(option.value)
						}
					}
					.pickerStyle(.segmented)
					.frame(width: 200)
					.onAppear {
						Task(priority: .userInitiated) {
							await viewModel.setPrice()
						}
					}
					.onChange(of: viewModel.selectedOption) {
						Task(priority: .userInitiated) {
							await viewModel.setPrice()
						}
					}
				}

				Text(
					viewModel.pricePerUnit,
					format: .currency(code: viewModel.currency.code)
				)
				.foregroundStyle(.secondary)
				.frame(maxWidth: .infinity, alignment: .leading)
			}
		}
	}

	// MARK: - Private methods

}

// MARK: - Preview

#Preview {
	EstimatePickerCellView(
		viewModel: EstimatePickerCellViewModel(
			calculateService: CalculateService(),
			calculateCellType: .setupAndCommissioning,
			options: [
				.ourInstallation(price: 6700),
				.thirdPartyInstallation(price: 8500)
			]
		), text: "Installation and startup"
	)
}
