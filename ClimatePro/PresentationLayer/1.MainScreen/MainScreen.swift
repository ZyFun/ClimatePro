//
//  MainScreen.swift
//  ClimatePro
//
//  Created by Дмитрий Данилин on 28.03.2025.
//

import SwiftUI

struct MainScreen: View {
	// MARK: - Property wrappers

	@State var viewModel: MainScreenViewModel
	@State var lengthCellViewModel: SmetaCellViewModel
	@State var additionalDeparturesCellViewModel: SmetaCellViewModel

	// MARK: - Body

	var body: some View {
		ScrollView {
			Text("Main parameters")
				.font(.title)
			VStack(alignment: .leading, spacing: 16) {
				buildLineLength()
				buildAdditionalDepartures()
				Spacer()
				Divider()
				buildTotalPrice()
			}
			.padding()
		}
	}

	// MARK: - View Builder Methods

	private func buildLineLength() -> some View {
		SmetaCellView(
			viewModel: lengthCellViewModel,
			title: "Length of the refrigerant line",
			placeholder: "3",
			unitMeasurement: "m",
			pricePer: "per 1 m"
		)
	}

	private func buildAdditionalDepartures() -> some View {
		SmetaCellView(
			viewModel: additionalDeparturesCellViewModel,
			title: "Count of additional departures",
			placeholder: "1",
			unitMeasurement: "",
			pricePer: "per departure"
		)
	}

	private func buildTotalPrice() -> some View {
		HStack {
			Text("Total price:")
			// TODO: () брать текущую валюту из базы
			Text(viewModel.totalPrice, format: .currency(code: "RUB"))
			Spacer()
			Button("Calculate") {
				calculateTotalPrice()
			}.buttonStyle(.borderedProminent)
		}
	}

	// MARK: - Private methods

	// TODO: () Вынести подсчет в отдельный менеджер, где будут хранится все введенные суммы
	private func calculateTotalPrice() {
		let totalPrice = lengthCellViewModel.price
		+ additionalDeparturesCellViewModel.price
		viewModel.totalPrice = totalPrice
	}

}

// MARK: - Preview

#Preview {
	MainScreenConfigurator().config()
}
