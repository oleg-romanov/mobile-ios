//
//  CategoryService.swift
//  EventMaker
//
//  Created by Олег Романов on 26.04.2022.
//
import Foundation
import Moya

enum CreateCategoryResult {
    case success(category: Category)
    case failure(error: Error)
}

enum GetAllCategoriesResult {
    case success(categories: [Category])
    case failure(error: Error)
}

protocol CategoryServiceProtocol {
    func createCategory(category: CategoryDto, completion: @escaping (CreateCategoryResult) -> Void)
    func getAllCategories(completion: @escaping (GetAllCategoriesResult) -> Void)
}

class CategoryService: CategoryServiceProtocol {
    let dataProvider = MoyaProvider<CategoryServiceApi>(plugins: [
        NetworkLoggerPlugin(),
    ])

    func createCategory(category: CategoryDto, completion: @escaping (CreateCategoryResult) -> Void) {
        print(category)
        dataProvider.request(.createCategory(category: category)) { result in
            switch result {
            case let .success(moyaResponse):
                guard (200 ... 299).contains(moyaResponse.statusCode)
                else {
                    let message = try? moyaResponse.map(String.self, atKeyPath: "message")
                    completion(.failure(error: CustomError(errorDescription: message)))
                    return
                }
                do {
                    let dataResponse = try moyaResponse.map(Category.self)
                    print(dataResponse)
                    completion(.success(category: dataResponse))
                } catch {
                    completion(.failure(error: error))
                }
            case let .failure(error):
                completion(.failure(error: error))
            }
        }
    }

    func getAllCategories(completion: @escaping (GetAllCategoriesResult) -> Void) {
        dataProvider.request(.getAllCategories) { result in
            switch result {
            case let .success(moyaResponse):
                guard (200 ... 299).contains(moyaResponse.statusCode)
                else {
                    let message = try? moyaResponse.map(String.self, atKeyPath: "message")
                    completion(.failure(error: CustomError(errorDescription: message)))
                    return
                }
                do {
                    let dataResponse = try moyaResponse.map([Category].self)
                    completion(.success(categories: dataResponse))
                } catch {
                    completion(.failure(error: error))
                }
            case let .failure(error):
                completion(.failure(error: error))
            }
        }
    }
}
