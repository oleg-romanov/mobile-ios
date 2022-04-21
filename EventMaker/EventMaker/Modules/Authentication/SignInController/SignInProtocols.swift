//
//  SignInProtocols.swift
//  EventMaker
//
//  Created by Олег Романов on 06.04.2022.
//

import Foundation

protocol SignInViewInput: AnyObject {
    func showError(message: String)
    func presentEvents()
    func stopAnimating()
}

protocol SignInViewOutput: AnyObject {
    func signInWithEmail(email: String, password: String)
}
