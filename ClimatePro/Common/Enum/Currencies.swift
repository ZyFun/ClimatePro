//
//  Currencies.swift
//  ClimatePro
//
//  Created by Дмитрий Данилин on 28.03.2025.
//

enum Currencies {
	case rub
	case usd

	var symbol: String {
		switch self {
		case .rub: "₽"
		case .usd: "$"
		}
	}

	var code: String {
		switch self {
		case .rub: "RUB"
		case .usd: "USD"
		}
	}
}
