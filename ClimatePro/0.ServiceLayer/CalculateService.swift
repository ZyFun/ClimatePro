//
//  CalculateService.swift
//  ClimatePro
//
//  Created by Дмитрий Данилин on 28.03.2025.
//

protocol ICalculateService: Sendable {
	/// Метод для установки цены длинны линии
	/// - Parameter price: цена за линию
	func setLengthPrice(_ price: Double) async

	/// Метод для установки цены за штробу пазогребневой плиты
	/// - Parameter price: цена за штробу
	func setChaseGrooveAndTonguePlatePrice(_ price: Double) async

	/// Метод для установки цены за штробу по кирпичу
	/// - Parameter price: цена за штробу
	func setChaseInBrickPrice(_ price: Double) async

	/// Метод для установки цены за штробу по монолиту
	/// - Parameter price: цена за штробу
	func setChaseInConcrete(_ price: Double) async

	/// Метод для установки цены за кронштейн
	/// - Parameter price: цена за кронштейн
	func setBracketPrice(_ price: Double) async

	/// Метод для установки цены за дополнительные выезды
	/// - Parameter price: цена за выезды
	func setAdditionalDeparturesPrice(_ price: Double) async

	/// Метод для рассчета финальной стоимости установки
	/// - Returns: Возвращает финальную цену
	func calculateTotalPrice() async -> Double
}

actor CalculateService: ICalculateService {
	private var lengthPrice: Double = 0
	private var chaseGrooveAndTonguePlatePrice: Double = 0
	private var chaseInBrickPrice: Double = 0
	private var chaseInConcrete: Double = 0
	private var additionalDeparturesPrice: Double = 0
	private var bracketPrice: Double = 0

	func setLengthPrice(_ price: Double) async {
		self.lengthPrice = price
	}

	func setChaseGrooveAndTonguePlatePrice(_ price: Double) async {
		self.chaseGrooveAndTonguePlatePrice = price
	}

	func setChaseInBrickPrice(_ price: Double) async {
		self.chaseInBrickPrice = price
	}

	func setChaseInConcrete(_ price: Double) async {
		self.chaseInConcrete = price
	}

	func setBracketPrice(_ price: Double) async {
		self.bracketPrice = price
	}

	func setAdditionalDeparturesPrice(_ price: Double) async {
		self.additionalDeparturesPrice = price
	}

	func calculateTotalPrice() async -> Double {
		lengthPrice
		+ chaseGrooveAndTonguePlatePrice
		+ chaseInBrickPrice
		+ chaseInConcrete
		+ bracketPrice
		+ additionalDeparturesPrice
	}
}
