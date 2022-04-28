//
//  CategoryProtocols.swift
//  EventMaker
//
//  Created by Олег Романов on 26.04.2022.
//

import Foundation

protocol CategoryViewInput: AnyObject {
    func reloadCategories()
    func loadCategories(categories: [Category])
    func presentAddCategory()
}

protocol CategoryViewOutput: AnyObject {
    func getAllCategories()
    func createCategory(category: Category)
}
