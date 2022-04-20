//
//  EnterEmailView.swift
//  EventMaker
//
//  Created by Олег Романов on 20.04.2022.
//

import SnapKit
import UIKit

class EnterEmailView: UIView {
    // MARK: Properties

    @IBOutlet var textLabel: UILabel!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var emailTextField: MDTextField!
    lazy var confirmButton = ButtonDefault(title: "Подтвердить")

    // MARK: Init

    override func awakeFromNib() {
        super.awakeFromNib()
        setupStyle()
        addSubview(confirmButton)
        makeConstraints()
        addActionHandlers()
    }

    private func setupStyle() {
        textLabel.text = "Пожалуйста, введите email адрес. \nМы отправим вам инструкции для восстановления пароля."
    }

    private func makeConstraints() {
        confirmButton.snp.makeConstraints { make in
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
        confirmButton.snp.updateConstraints { make in
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
