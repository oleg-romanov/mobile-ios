//
//  EventCell.swift
//  EventMaker
//
//  Created by Олег Романов on 23.04.2022.
//

import UIKit

final class EventCell: UITableViewCell {
    // MARK: - Properties

    var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        return label
    }()

    var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = Assets.gray.color
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()

    var categoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = Assets.lightgray.color
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()

    private let dayAndMonthDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM"
        dateFormatter.locale = Locale(identifier: "Ru")
        return dateFormatter
    }()

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func commonInit() {
        setupStyle()
        addSubviews()
        makeConstraints()
    }

    private func setupStyle() {
        accessoryType = .disclosureIndicator
    }

    private func addSubviews() {
        addSubview(nameLabel)
        addSubview(dateLabel)
        addSubview(categoryLabel)
    }

    private func makeConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(16)
            make.top.equalTo(13)
            make.trailing.equalTo(16)
        }

        dateLabel.snp.makeConstraints { make in
            make.leading.equalTo(16)
            make.top.equalTo(nameLabel.snp.bottom).offset(7)
            make.bottom.equalToSuperview().inset(13)
        }

        categoryLabel.snp.makeConstraints { make in
            make.bottom.equalTo(dateLabel.snp.bottom)
            make.trailing.equalToSuperview().inset(40)
        }
    }

    // MARK: - Internal methods

    func configure(cell: Event) {
        nameLabel.text = cell.name
        dateLabel.text = dayAndMonthDateFormatter.string(for: cell.date)
        categoryLabel.text = cell.category.name
    }
}
