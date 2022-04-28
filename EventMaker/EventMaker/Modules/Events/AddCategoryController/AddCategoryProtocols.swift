//
//  AddCategoryProtocols.swift
//  EventMaker
//
//  Created by Олег Романов on 27.04.2022.
//

import Foundation

protocol AddCategoryInput: AnyObject {}

protocol AddCategoryOutput: AnyObject {
    func createCategory(category: CategoryDto, complition: @escaping (Result<Void, Error>) -> Void)
}
