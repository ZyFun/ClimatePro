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
	@State var dkcCableTrunkingCellViewModel: EstimateCellViewModel
	@State var chaseGrooveAndTonguePlateCellViewModel: EstimateCellViewModel
	@State var chaseInBrickViewModel: EstimateCellViewModel
	@State var chaseInConcreteViewModel: EstimateCellViewModel
	@State var installationAndStartupViewModel: EstimatePickerCellViewModel
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
						buildDKCCableTrunkingCell()
						buildChaseGrooveAndTonguePlateCell()
						buildChaseInBrickCell()
						buildChaseInConcreteCell()
						buildInstallationAndStartupCell()
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
		.dtFullScreenBackground(.backgroundMain)
		.toolbar {
			#if os(iOS)
			buildKeyboardToolbar()
			#endif
		}
	}

	// MARK: - View Builder Methods

	#if os(iOS)
	@ToolbarContentBuilder
	private func buildKeyboardToolbar() -> some ToolbarContent {

		ToolbarItemGroup(placement: .keyboard) {
			Spacer()
			Button("Done") {
				UIApplication.shared.sendAction(
					#selector(UIResponder.resignFirstResponder),
					to: nil,
					from: nil,
					for: nil
				)
			}
		}

	}
	#endif

	private func buildLineLengthCell() -> some View {
		EstimateCellView(
			viewModel: lengthCellViewModel,
			title: "Length of the refrigerant line",
			placeholder: "distance",
			unit: .meters,
			pricePer: "per 1 m"
		)
	}

	private func buildDKCCableTrunkingCell() -> some View {
		EstimateCellView(
			viewModel: dkcCableTrunkingCellViewModel,
			title: "DKC cable trunking",
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
			viewModel: chaseInBrickViewModel,
			title: "Chase in a brick",
			placeholder: "distance",
			unit: .meters,
			pricePer: "per 1 m"
		)
	}

	private func buildChaseInConcreteCell() -> some View {
		EstimateCellView(
			viewModel: chaseInConcreteViewModel,
			title: "Chase in concrete",
			placeholder: "distance",
			unit: .meters,
			pricePer: "per 1 m"
		)
	}

	private func buildInstallationAndStartupCell() -> some View {
		EstimatePickerCellView(
			viewModel: installationAndStartupViewModel,
			text: "Installation and startup"
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
