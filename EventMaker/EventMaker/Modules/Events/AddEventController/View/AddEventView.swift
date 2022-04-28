//
//  AddEventController.swift
//  EventMaker
//
//  Created by Олег Романов on 27.04.2022.
//

import SPAlert
import UIKit

class AddEventView: UIView {
    // MARK: - Properties

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var birthdayLabel: UILabel!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var arrowImageViewCategory: UIImageView!
    @IBOutlet var arrowImageViewType: UIImageView!
    @IBOutlet var categoryButton: UIButton!
    @IBOutlet var typeButton: UIButton!
    @IBOutlet var descriptionTextView: UITextView!
    @IBOutlet var spinner: UIActivityIndicatorView!

    lazy var doneButton = UIBarButtonItem(
        title: Text.AddEvent.done, style: .done, target: nil, action: nil
    )

    // MARK: - Init

    override func awakeFromNib() {
        addActionHandlers()
        setupStyle()
    }

    private func setupStyle() {
        spinner.isHidden = true
        descriptionTextView.delegate = self
        descriptionTextView.text = "Нажмите, чтобы добавить описание"
        descriptionTextView.textColor = .lightGray
        descriptionTextView.textContainer.maximumNumberOfLines = 8
        descriptionTextView.sizeToFit()
        descriptionTextView.isScrollEnabled = false
        arrowImageViewCategory.image = Assets.arrowIcon.image
        arrowImageViewType.image = Assets.arrowIcon.image
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - Action handlers

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

    // MARK: - Private methods

    private func adjustContentInset(_ contentInset: CGFloat) {
        scrollView.contentInset.bottom = contentInset
    }
}

extension AddEventView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if descriptionTextView.textColor == .lightGray {
            UIView.transition(with: descriptionTextView, duration: 0.3, options: .transitionCrossDissolve) {
                self.descriptionTextView.text = nil
            }
            descriptionTextView.textColor = .black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if descriptionTextView.text.isEmpty {
            UIView.transition(with: descriptionTextView, duration: 0.3, options: .transitionCrossDissolve) {
                self.descriptionTextView.text = "Нажмите, чтобы добавить описание (Не более 200 символов)"
            }
            descriptionTextView.textColor = .lightGray
        }
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else {
            SPAlert.present(message: "Описание не должго превышать 200 символов", haptic: SPAlertHaptic.warning)
            return false
        }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
        if updatedText.count == 200 {
            SPAlert.present(message: "Описание не должно превышать 200 символов", haptic: SPAlertHaptic.warning)
        }
        return updatedText.count <= 200
    }
}
