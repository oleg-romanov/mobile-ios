//
//  SlideCell.swift
//  EventMaker
//
//  Created by Олег Романов on 31.03.2022.
//

import UIKit

class SlideCell: UICollectionViewCell {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 25)
        label.textColor = .black

        return label
    }()

    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor(named: "Gray")
        label.numberOfLines = 0

        return label
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
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
    }

    private func setupStyle() {}

    private func addSubviews() {
        addSubview(titleLabel)
        addSubview(subtitleLabel)
    }

    private func makeConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-40)
        }

        subtitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }

    func configure(slide: Slide) {
        titleLabel.text = slide.title
        subtitleLabel.text = slide.subtitle
    }
}
