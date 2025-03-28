//
//  EstimateCellView.swift
//  ClimatePro
//
//  Created by Дмитрий Данилин on 28.03.2025.
//

import SwiftUI

struct EstimateCellView: View {
	// MARK: - Property wrappers

	@Bindable var viewModel: EstimateCellViewModel

	let title: LocalizedStringKey
	let placeholder: LocalizedStringKey
	let unit: UnitLength?
	let pricePer: LocalizedStringKey

	// MARK: - Body

	var body: some View {
		buildCell()
	}

	// MARK: - View Builder Methods

	private func buildCell() -> some View {
		DTCell {
			VStack(alignment: .leading) {
				HStack(alignment: .lastTextBaseline) {
					Text(title) +
					Text(" " + viewModel.localizedUnitSymbol(for: unit))
						.foregroundColor(.secondary)
					Spacer()
					TextField(placeholder, text: $viewModel.enteredData)
						.keyboardType(.decimalPad)
						.textFieldStyle(.roundedBorder)
						.frame(maxWidth: 110)
						.onChange(of: viewModel.enteredData) { _, newValue in
							viewModel.enteredData = viewModel.validateInput(newValue)
							Task(priority: .userInitiated) {
								await viewModel.calculatePrice()
							}
						}
				}

				HStack(alignment: .lastTextBaseline) {
					Text("Price") +
					Text(" ") +
					Text(pricePer)
						.foregroundColor(.secondary) +
					Text(" ") +
					Text(String(format: "%.2f", viewModel.pricePerUnit))
						.foregroundColor(.secondary)

					Spacer()
					Text(
						viewModel.price,
						format: .currency(code: viewModel.currency.code)
					)
					.frame(maxWidth: 110, alignment: .leading)
				}
			}
		}
	}

	// MARK: - Private methods

}

// MARK: - Preview

#Preview {
	EstimateCellView(
		viewModel: .init(
			calculateService: CalculateService(),
			pricePerUnit: 1000,
			cellType: .lengthLine
		),
		title: "Length of the refrigerant line",
		placeholder: "distance",
		unit: .meters,
		pricePer: "per 1 m"
	)
}
