//
//  ButtonSignInWithEmail.swift
//  EventMaker
//
//  Created by Олег Романов on 05.04.2022.
//

import UIKit

class ButtonSignInWithEmail: UIButton {
    init(title: String) {
        super.init(frame: .zero)
        setupStyle(title: title)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupStyle(title: String) {
        titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        setTitle(title, for: .normal)
        setTitleColor(.black, for: .normal)
        backgroundColor = Assets.background1.color
        layer.cornerRadius = 20
        layer.borderWidth = 1
        layer.borderColor = Assets.blue.color.cgColor
    }
}
