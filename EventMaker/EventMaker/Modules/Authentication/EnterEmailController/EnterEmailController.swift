//
//  EnterEmailController.swift
//  EventMaker
//
//  Created by Олег Романов on 20.04.2022.
//

import UIKit

class EnterEmailController: UIViewController {
    // MARK: - Properties

    lazy var customView: EnterEmailView? = view as? EnterEmailView

    // MARK: - Init

    init() {
        super.init(nibName: "EnterEmailView", bundle: Bundle(for: EnterEmailView.self))
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        addActionHandlers()
        title = "Сброс пароля"
    }

    // MARK: - Action handlers

    private func addActionHandlers() {
        customView?.confirmButton.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
    }

    @objc private func confirmButtonTapped() {
        guard
            let email = customView?.emailTextField.text
        else {
            print("Почта не введена")
            return
        }
    }
}
