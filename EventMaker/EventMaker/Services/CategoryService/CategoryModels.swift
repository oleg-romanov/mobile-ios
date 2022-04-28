//
//  CategoryModels.swift
//  EventMaker
//
//  Created by Олег Романов on 26.04.2022.
//

import Foundation

struct CreateCategoryRequest: Encodable {
    let name: String
}

struct CategoryResponse: Decodable {
    let id: Int
    let name: String
}

struct GetAllCategoriesResponse: Decodable {
    let categories: [Category]
}

struct CategoryDto: Encodable {
    let name: String
}
