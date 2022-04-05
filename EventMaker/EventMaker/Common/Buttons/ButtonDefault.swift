//
//  ButtonDefault.swift
//  EventMaker
//
//  Created by Олег Романов on 05.04.2022.
//

import UIKit

class ButtonDefault: UIButton {
    init(title: String) {
        super.init(frame: .zero)
        setupStyle(title: title)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupStyle(title: String) {
        setTitle(title, for: .normal)
        setTitleColor(Assets.background1.color, for: .normal)
        backgroundColor = Assets.blue.color
        layer.cornerRadius = 14
    }
}
