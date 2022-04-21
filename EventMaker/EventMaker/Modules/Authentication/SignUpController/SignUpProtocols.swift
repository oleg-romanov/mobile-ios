//
//  SignUpProtocols.swift
//  EventMaker
//
//  Created by Олег Романов on 16.04.2022.
//

import Foundation

protocol SignUpInput: AnyObject {
    func showError(message: String)
    func presentEvents()
    func stopAnimating()
}

protocol SignUpOutput: AnyObject {
    func signUpWithEmail(email: String, password: String, name: String)
}
