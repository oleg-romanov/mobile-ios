//
//  StartController.swift
//  EventMaker
//
//  Created by Олег Романов on 03.04.2022.
//

import UIKit

class StartController: UIViewController {
    // MARK: - Properties

    lazy var customView: StartView? = StartView()

    var presenter: StartViewOutput?

    // MARK: - Life cycle

    override func loadView() {
        view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addActionHandlers()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    // MARK: - Action handlers

    private func addActionHandlers() {
        customView?.signInWithEmail.addTarget(self, action: #selector(signInWithEmailTapped), for: .touchUpInside)
    }

    @objc private func signInWithEmailTapped() {
        let signInVC = SignInController()
        let signInPresenter = SignInPresenter(view: signInVC)
        signInVC.presenter = signInPresenter
        navigationController?.pushViewController(signInVC, animated: true)
        navigationItem.backButtonTitle = ""
    }
}
