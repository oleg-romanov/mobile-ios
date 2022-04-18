//
//  SignUpController.swift
//  EventMaker
//
//  Created by Олег Романов on 16.04.2022.
//

import UIKit

class SignUpController: UIViewController {
    // MARK: - Properties

    lazy var customView: SignUpView? = view as? SignUpView

    var presenter: SignUpOutput?

    // MARK: - Init

    init() {
        super.init(nibName: "SignUpView", bundle: Bundle(for: SignUpView.self))
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        presenter = SignUpPresenter(view: self)
    }

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Регистрация"
        addActionHandlers()
    }

    // MARK: - Action handlers

    private func addActionHandlers() {
        customView?.signUpButton.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
    }

    @objc private func signUpTapped() {
        guard
            let name = customView?.nameTextField.text,
            let email = customView?.emailTextField.text,
            let password = customView?.passwordTextField.text
        else { return }
        if customView?.passwordTextField.text != customView?.confirmPassTextField.text {
            print("Пароли не совпадают...")
            return
        }
        customView?.spinner.isHidden = false
        customView?.spinner.startAnimating()
        presenter?.signUpWithEmail(email: email, password: password, name: name)
    }
}

extension SignUpController: SignUpInput {
    func stopAnimating() {
        customView?.spinner.stopAnimating()
    }

    func presentEvents() {
        // TODO: Переход на экран с событиями
    }

    func showError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

