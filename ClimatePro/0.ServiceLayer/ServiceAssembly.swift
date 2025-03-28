//
//  ServiceAssembly.swift
//  ClimatePro
//
//  Created by Дмитрий Данилин on 28.03.2025.
//

final class ServiceAssembly {
	lazy var calculateService: ICalculateService = {
		return CalculateService()
	}()
}
