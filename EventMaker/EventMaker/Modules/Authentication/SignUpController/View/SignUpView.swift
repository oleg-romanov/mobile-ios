//
//  SignUpView.swift
//  EventMaker
//
//  Created by Олег Романов on 16.04.2022.
//

import UIKit

class SignUpView: UIView {
    // MARK: - Properties

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var nameTextField: MDTextField!
    @IBOutlet var emailTextField: MDTextField!
    @IBOutlet var passwordTextField: MDTextField!
    @IBOutlet var confirmPassTextField: MDTextField!
    @IBOutlet var spinner: UIActivityIndicatorView!

    lazy var signUpButton = ButtonDefault(title: "Зарегистрироваться")

    // MARK: - Init

    override func awakeFromNib() {
        setupStyle()
        addSubview(signUpButton)
        makeContraints()
        addActionHandlers()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    private func setupStyle() {
        nameTextField.autocapitalizationType = .words
        spinner.isHidden = true
    }

    private func makeContraints() {
        signUpButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(20)
            make.width.equalTo(UIScreen.main.bounds.width - 32)
            make.height.equalTo(50)
        }
    }

    // MARK: - Action Handlers

    private func addActionHandlers() {
        let defaultNotificationCenter = NotificationCenter.default
        defaultNotificationCenter.addObserver(
            self,
            selector: #selector(keyboardWillShow(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        defaultNotificationCenter.addObserver(
            self,
            selector: #selector(keyboardWillHide(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
        let tapGestureRecognizer = UITapGestureRecognizer(
            target: self, action: #selector(onViewTap)
        )
        addGestureRecognizer(tapGestureRecognizer)
    }

    @objc private func onViewTap() {
        endEditing(true)
    }

    // MARK: - Private methods

    private func adjustContentInset(_ contentInset: CGFloat) {
        scrollView.contentInset.bottom = contentInset
        signUpButton.snp.updateConstraints { make in
            make.bottom.equalToSuperview().inset(contentInset + 20)
        }
        UIView.animate(withDuration: 0.1) {
            self.layoutIfNeeded()
        }
    }

    // MARK: - Keyboard action notification

    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]
            as? NSValue
        else {
            return
        }

        let keyboardSize = keyboardFrame.cgRectValue.size
        adjustContentInset(keyboardSize.height)
    }

    @objc private func keyboardWillHide(notification _: NSNotification) {
        adjustContentInset(.zero)
    }
}
