//
//  StartPresenter.swift
//  EventMaker
//
//  Created by Олег Романов on 03.04.2022.
//

import Foundation

final class StartPresenter {
    private weak var view: StartViewInput?

    init(view: StartViewInput) {
        self.view = view
    }
}

extension StartPresenter: StartViewOutput {
    func signInWithEmailTapped() {}
}
