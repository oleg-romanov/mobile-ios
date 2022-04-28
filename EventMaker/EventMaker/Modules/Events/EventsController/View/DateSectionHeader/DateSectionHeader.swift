//
//  DateSectionHeader.swift
//  EventMaker
//
//  Created by Олег Романов on 23.04.2022.
//

import UIKit

final class DateSectionHeader: UIView {
    // MARK: - Properties

    lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = Assets.lightgray.color
        label.font = .systemFont(ofSize: 19, weight: .semibold)
        return label
    }()

    private let monthDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        return dateFormatter
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func commonInit() {
        addSubviews()
        makeConstraints()
        setupStyle()
    }

    private func setupStyle() {
        if #available(iOS 13.0, *) {
            backgroundColor = .systemBackground
        } else {
            backgroundColor = Assets.background1.color
        }
    }

    private func addSubviews() {
        addSubview(label)
    }

    private func makeConstraints() {
        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
        }
    }

    // MARK: - Internal methods

    func configure(date: Date) {
        label.text = monthDateFormatter.string(from: date).uppercased()
    }
}
