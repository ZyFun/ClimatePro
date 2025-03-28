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
	@State var lengthCellViewModel: EstimateCellViewModel
	@State var chaseGrooveAndTonguePlateCellViewModel: EstimateCellViewModel
	@State var chaseInBrick: EstimateCellViewModel
	@State var chaseInConcrete: EstimateCellViewModel
	@State var bracketSelectCellViewModel: EstimateToggleCellViewModel
	@State var additionalDeparturesCellViewModel: EstimateCellViewModel

	private let padding: CGFloat = 16

	// MARK: - Body

	var body: some View {
		ScrollView {
			Section(
				content: {
					VStack(alignment: .leading, spacing: padding) {
						buildLineLengthCell()
						buildChaseGrooveAndTonguePlateCell()
						buildChaseInBrickCell()
						buildChaseInConcreteCell()
						buildBracketSelectCell()
						buildAdditionalDeparturesCell()
					}
				}, header: {
					Text("Main parameters")
						.frame(maxWidth: .infinity, alignment: .leading)
						.font(.title2)
						.padding(.top, padding)
				}
			)
			.padding(.horizontal, padding)

			Group {
				Divider()
					.padding(.top, padding)
				buildTotalPrice()
			}
			.padding(.horizontal, padding)
		}
	}

	// MARK: - View Builder Methods

	private func buildLineLengthCell() -> some View {
		EstimateCellView(
			viewModel: lengthCellViewModel,
			title: "Length of the refrigerant line",
			placeholder: "distance",
			unit: .meters,
			pricePer: "per 1 m"
		)
	}

	private func buildChaseGrooveAndTonguePlateCell() -> some View {
		EstimateCellView(
			viewModel: chaseGrooveAndTonguePlateCellViewModel,
			title: "Chase in a tongue-and-groove panel",
			placeholder: "distance",
			unit: .meters,
			pricePer: "per 1 m"
		)
	}

	private func buildChaseInBrickCell() -> some View {
		EstimateCellView(
			viewModel: chaseInBrick,
			title: "Chase in a brick",
			placeholder: "distance",
			unit: .meters,
			pricePer: "per 1 m"
		)
	}

	private func buildChaseInConcreteCell() -> some View {
		EstimateCellView(
			viewModel: chaseInConcrete,
			title: "Chase in concrete",
			placeholder: "distance",
			unit: .meters,
			pricePer: "per 1 m"
		)
	}

	private func buildBracketSelectCell() -> some View {
		EstimateToggleCellView(
			viewModel: bracketSelectCellViewModel,
			text: "Bracket"
		)
	}

	private func buildAdditionalDeparturesCell() -> some View {
		EstimateCellView(
			viewModel: additionalDeparturesCellViewModel,
			title: "Count of additional departures",
			placeholder: "count",
			unit: nil,
			pricePer: "per departure"
		)
	}

	@ViewBuilder
	private func buildTotalPrice() -> some View {
		HStack {
			Text("Total price:")
			// TODO: () брать текущую валюту из базы
			Text(viewModel.totalPrice, format: .currency(code: "RUB"))
			Spacer()
			Button("Calculate") {
				Task(priority: .userInitiated) {
					await viewModel.calculateButtonPressed()
				}
			}.buttonStyle(.borderedProminent)
		}
		Spacer(minLength: 30)
	}
}

// MARK: - Preview

#Preview {
	PresentationAssembly().mainScreen.config()
}
