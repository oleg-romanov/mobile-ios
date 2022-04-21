//
//  MDTextField.swift
//  EventMaker
//
//  Created by Олег Романов on 08.04.2022.
//

import MDFoundation
import UIKit

final class MDTextField: UITextField {
    private struct Appearance {
        static let animationDuration: TimeInterval = 0.3
        static let lineViewHeight: CGFloat = 1
    }

    // MARK: - Properties

    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = Assets.errorRed.color
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        label.alpha = 0
        return label
    }()

    private lazy var placeholderLabel: UILabel = {
        let label = UILabel()
        label.textColor = Assets.lightgray.color
        label.textAlignment = .left
        label.center = .zero
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()

    private lazy var lineView = UIView()

    @IBInspectable
    var isFloatingPlaceholder: Bool = false
    var isFloatingErrorLabel: Bool = true
    var automaticallyResetError: Bool = true

    private var isErrorShowing: Bool = false

    @IBInspectable
    override var placeholder: String? {
        get {
            return placeholderLabel.text
        }
        set {
            placeholderLabel.text = newValue
            handleTextChanged()
        }
    }

    var upperPlaceholderColor: UIColor = Assets.gray.color {
        didSet {
            guard isUpper else { return }
            placeholderLabel.textColor = upperPlaceholderColor
        }
    }

    var placeholderColor: UIColor = Assets.lightgray.color {
        didSet {
            guard !isUpper else { return }
            placeholderLabel.textColor = placeholderColor
        }
    }

    var upperPlaceholderFont = UIFont.systemFont(ofSize: 12, weight: .regular) {
        didSet {
            guard isUpper else { return }
            placeholderLabel.font = upperPlaceholderFont
        }
    }

    var placeholderFont = UIFont.systemFont(ofSize: 16, weight: .regular) {
        didSet {
            guard !isUpper else { return }
            placeholderLabel.font = placeholderFont
        }
    }

    override var text: String? {
        get {
            return super.text
        }
        set {
            super.text = newValue
            handleTextChanged()
        }
    }

    private var isUpper: Bool = false

    private var isEmpty: Bool = true

    // MARK: - Init

    init() {
        super.init(frame: .zero)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        setupStyle()
        addSubviews()
        makeConstraints()
        addActionHandlers()
    }

    private func setupStyle() {
        font = UIFont.systemFont(ofSize: 18, weight: .regular)
        lineView.backgroundColor = Assets.lightgray.color
    }

    private func addSubviews() {
        addSubview(lineView)
        addSubview(errorLabel)
        addSubview(placeholderLabel)
    }

    private func makeConstraints() {
        placeholderLabel.snp.makeConstraints { make in
            make.centerY.leading.equalToSuperview()
        }
        lineView.snp.makeConstraints { make in
            make.centerX.width.equalToSuperview()
            make.height.equalTo(Appearance.lineViewHeight)
            make.centerY.equalToSuperview().offset(25)
        }
        errorLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(3)
            make.leading.trailing.equalTo(lineView)
        }
    }

    // MARK: - Internal methods

    func showError(_ text: String?) {
        guard let text = text else { return }
        isErrorShowing = true
        errorLabel.text = text
        lineView.backgroundColor = .red
        if isFloatingErrorLabel {
            lineView.snp.updateConstraints { make in
                make.centerY.equalToSuperview().offset(18)
            }
        }
        UIView.animate(withDuration: Appearance.animationDuration) { [weak self] in
            self?.errorLabel.alpha = 1
            if self?.isFloatingErrorLabel == true {
                self?.layoutIfNeeded()
            }
        }
    }

    func resetError(animated: Bool = true) {
        isErrorShowing = false
        updateFirstResponderAppearance()
        if isFloatingErrorLabel {
            lineView.snp.updateConstraints { make in
                make.centerY.equalToSuperview().offset(25)
            }
        }
        if animated {
            UIView.animate(withDuration: Appearance.animationDuration) { [weak self] in
                self?.errorLabel.alpha = 0
                if self?.isFloatingErrorLabel == true {
                    self?.layoutIfNeeded()
                }
            }
        } else {
            errorLabel.alpha = 0
            if isFloatingErrorLabel == true {
                layoutIfNeeded()
            }
        }
    }

    // MARK: - Overriden methods

    override func becomeFirstResponder() -> Bool {
        super.becomeFirstResponder()
        if automaticallyResetError {
            resetError()
        } else {
            updateFirstResponderAppearance()
        }
        return true
    }

    @discardableResult
    override func resignFirstResponder() -> Bool {
        super.resignFirstResponder()
        if automaticallyResetError {
            resetError()
        } else {
            updateFirstResponderAppearance()
        }
        return true
    }

    // MARK: - Action handlers

    func addActionHandlers() {
        addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }

    @objc func textFieldDidChange(_ textField: UITextField) {
        if automaticallyResetError {
            resetError()
        }
        handleTextChanged()
    }

    // MARK: - Private methods

    private func updateFirstResponderAppearance() {
        if isErrorShowing {
            lineView.backgroundColor = Assets.errorRed.color
        } else if isFirstResponder {
            lineView.backgroundColor = Assets.blue.color
        } else {
            lineView.backgroundColor = Assets.lightgray.color
        }
    }

    private func movePlaceholderUpper() {
        placeholderLabel.snp.updateConstraints { make in
            make.centerY.equalToSuperview().offset(-20)
        }
        placeholderLabel.textColor = upperPlaceholderColor // Assets.gray.color
        placeholderLabel.font = upperPlaceholderFont // Fonts.SFUIDisplay.regular.font(size: 12)
        isUpper = true
    }

    private func movePlaceholderToDefaultPosition() {
        placeholderLabel.snp.updateConstraints { make in
            make.centerY.equalToSuperview()
        }
        placeholderLabel.textColor = placeholderColor // Assets.text.color
        placeholderLabel.font = placeholderFont
        isUpper = false
    }

    private func textFieldBecameEmpty() {
        if isFloatingPlaceholder {
            movePlaceholderToDefaultPosition()
        } else {
            placeholderLabel.isHidden = false
        }
    }

    private func textFieldBecameFilled() {
        if isFloatingPlaceholder {
            movePlaceholderUpper()
        } else {
            placeholderLabel.isHidden = true
        }
    }

    private func handleTextChanged() {
        if text?.isEmpty == true, isEmpty == false {
            isEmpty = true
            textFieldBecameEmpty()
        } else if text?.isEmpty == false, isEmpty {
            isEmpty = false
            textFieldBecameFilled()
        }
    }
}

extension MDTextField {
    func addDoneButtonOnKeyboard() {
        let doneToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonAction))

        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()

        inputAccessoryView = doneToolbar
    }

    @objc private func doneButtonAction() {
        resignFirstResponder()
    }
}
