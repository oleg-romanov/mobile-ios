//
//  EnterEmailNextView.swift
//  EventMaker
//
//  Created by Олег Романов on 20.04.2022.
//

import SnapKit
import UIKit

class EnterEmailNextView: UIView {
    // MARK: - Properties

    private var textField: UILabel = {
        let label = UILabel()

        return label
    }()

    // MARK: - Init

    init() {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func commonInit() {}
}
