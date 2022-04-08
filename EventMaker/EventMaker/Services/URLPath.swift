//
//  URLPath.swift
//  EventMaker
//
//  Created by Олег Романов on 07.04.2022.
//

import Foundation

enum URLPath: String {
    case localhost = "http://localhost:8080"
    case ip1 = "http://192.168.1.6:8080"

    static let path = URLPath.ip1.rawValue
}
