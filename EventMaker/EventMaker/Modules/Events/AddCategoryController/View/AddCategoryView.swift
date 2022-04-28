//
//  AddCategoryPresenter.swift
//  EventMaker
//
//  Created by Олег Романов on 27.04.2022.
//

import SnapKit
import UIKit

class AddCategoryView: UIView {
    // MARK: - Properties

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var addCategoryNameField: MDTextField!

    lazy var doneButton = UIBarButtonItem(
        title: Text.AddEvent.done, style: .done, target: nil, action: nil
    )

    // MARK: - Init

    override func awakeFromNib() {
        setup()
        addActionHandlers()
    }

    private func setup() {
        addCategoryNameField.placeholder = "Название категории"
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
