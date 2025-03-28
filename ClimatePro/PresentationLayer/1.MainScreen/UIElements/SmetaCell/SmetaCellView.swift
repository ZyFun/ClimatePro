//
//  SmetaCellView.swift
//  ClimatePro
//
//  Created by Дмитрий Данилин on 28.03.2025.
//

import SwiftUI

struct SmetaCellView: View {
	// MARK: - Property wrappers

	@Bindable var viewModel: SmetaCellViewModel

	let title: LocalizedStringKey
	let placeholder: LocalizedStringKey
	let unitMeasurement: LocalizedStringKey
	let pricePer: LocalizedStringKey

	// MARK: - Body

	var body: some View {
		buildCell()
	}

	// MARK: - View Builder Methods

	private func buildCell() -> some View {
		VStack(alignment: .leading) {
			HStack {
				Text(title)
					.multilineTextAlignment(.leading)
				Text(unitMeasurement)
					.foregroundColor(.secondary)

				Spacer()
				TextField(placeholder, text: $viewModel.enteredData)
					.textFieldStyle(.roundedBorder)
					.frame(maxWidth: 100)
			}

			HStack {
				Text("Price")
					.multilineTextAlignment(.leading)
				Text(pricePer)
					.foregroundColor(.secondary)
				Text(String(format: "%.2f", viewModel.pricePerUnit))
					.foregroundColor(.secondary)

				Spacer()
				Text(
					viewModel.price,
					format: .currency(code: viewModel.currency.code)
				)
				.frame(maxWidth: 100, alignment: .leading)
			}
		}
		.padding()
		.background()
		.clipShape(RoundedRectangle(cornerRadius: 10))
		.shadow(color: .black.opacity(0.2), radius: 10)
	}

	// MARK: - Private methods

}

// MARK: - Preview

#Preview {
	SmetaCellView(
		viewModel: .init(pricePerUnit: 1000),
		title: "Length of the refrigerant line",
		placeholder: "m",
		unitMeasurement: "m",
		pricePer: "per 1 m"
	)
}
