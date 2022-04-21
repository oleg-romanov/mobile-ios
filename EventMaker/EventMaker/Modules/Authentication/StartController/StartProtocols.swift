//
//  StartProtocols.swift
//  EventMaker
//
//  Created by Олег Романов on 03.04.2022.
//

import Foundation

protocol StartViewInput: AnyObject {}

protocol StartViewOutput: AnyObject {
    func signInWithEmailTapped()
}
