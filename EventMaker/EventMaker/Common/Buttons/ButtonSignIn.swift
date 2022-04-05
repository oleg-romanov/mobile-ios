//
//  ButtonSignIn.swift
//  EventMaker
//
//  Created by Олег Романов on 05.04.2022.
//

import UIKit

class ButtonSignIn: UIButton {
    init(title: String, buttonColor: UIColor, logo: UIImage) {
        super.init(frame: .zero)
        setupStyle(title: title, buttonColor: buttonColor, logo: logo)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupStyle(title: String, buttonColor: UIColor) {
        setTitle(title, for: .normal)
        setTitleColor(.white, for: .normal)
        backgroundColor = buttonColor
        layer.cornerRadius = 20
    }

    private func setupStyle(title: String, buttonColor: UIColor, logo: UIImage) {
        titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        setTitle(title, for: .normal)
        setTitleColor(.white, for: .normal)
        backgroundColor = buttonColor
        layer.cornerRadius = 20
        setImage(logo, for: .normal)
        imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
    }
}
