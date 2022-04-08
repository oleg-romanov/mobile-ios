//
//  OnboardingView.swift
//  EventMaker
//
//  Created by Олег Романов on 31.03.2022.
//

import SnapKit
import UIKit

final class OnboardingView: UIView {
    struct Appearance {
        static let heightOfButton: CGFloat = 44
        static let buttonWidth: CGFloat = UIScreen.main.bounds.width * 0.5 - 20
        static let bigButtonWidth: CGFloat = UIScreen.main.bounds.width - 32
        static let buttonsDistance: CGFloat = 8
        static let animationDuration: TimeInterval = 0.3
    }

    // MARK: - Properties

    lazy var logoImageView = UIImageView(image: Assets.logo.image)

    // как распологать элементы и их размер
    lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = UIScreen.main.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        return layout
    }()

    let skipButton = ButtonSecondary(title: Text.Onboarding.skip)
    let nextButton = ButtonDefault(title: Text.Onboarding.next)

    lazy var collectionView: UICollectionView = {
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = Assets.background1.color
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()

    lazy var pageControl: UIPageControl = {
        var pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = Assets.lightgray.color
        pageControl.currentPageIndicatorTintColor = Assets.blue.color
        pageControl.isUserInteractionEnabled = false
        return pageControl
    }()

    private var dataSource = SlidesDataSource()
    private var isLastPage: Bool = false

    // MARK: - Init

    init() {
        super.init(frame: UIScreen.main.bounds)
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
        backgroundColor = Assets.background1.color
        dataSource.setCollectionView(collectionView)
    }

    private func addSubviews() {
        addSubview(collectionView)
        addSubview(skipButton)
        addSubview(nextButton)
        addSubview(logoImageView)
        addSubview(pageControl)
    }

    private func makeConstraints() {
        skipButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.bottom.equalTo(safeAreaLayoutGuide).inset(40)
            make.height.equalTo(Appearance.heightOfButton)
            make.width.equalTo(Appearance.buttonWidth)
        }

        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(60)
            make.centerX.equalToSuperview()
            make.size.equalTo(100)
        }

        nextButton.snp.makeConstraints { make in
            make.leading.equalTo(skipButton.snp.trailing).offset(Appearance.buttonsDistance)
            make.centerY.equalTo(skipButton)
            make.height.equalTo(Appearance.heightOfButton)
            make.width.equalTo(Appearance.buttonWidth)
        }

        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        pageControl.snp.makeConstraints { make in
            make.bottom.equalTo(nextButton.snp.top).inset(-42)
            make.centerX.equalToSuperview()
        }
    }

    // MARK: - Action handlers

    private func addActionHandlers() {
        dataSource.pageChanged = { [weak self] page, numberOfPages in
            guard let self = self else { return }
            self.pageControl.currentPage = page
            if page == numberOfPages - 1, self.isLastPage == false {
                self.setLastPageAppearance()
                self.isLastPage = true
            } else if self.isLastPage {
                self.setDefaultPageAppearance()
                self.isLastPage = false
            }
        }
    }

    private func setLastPageAppearance() {
        nextButton.snp.updateConstraints { make in
            make.leading.equalTo(skipButton.snp.trailing).offset(0)
            make.width.equalTo(Appearance.bigButtonWidth)
        }
        skipButton.snp.updateConstraints { make in
            make.width.equalTo(0)
        }
        nextButton.setTitle(Text.Onboarding.start, for: .normal)
        UIView.animate(withDuration: Appearance.animationDuration) { [weak self] in
            guard let self = self else { return }
            self.layoutIfNeeded()
            self.skipButton.alpha = 0
        }
    }

    private func setDefaultPageAppearance() {
        nextButton.snp.updateConstraints { make in
            make.leading.equalTo(skipButton.snp.trailing).offset(Appearance.buttonsDistance)
            make.width.equalTo(Appearance.buttonWidth)
        }
        skipButton.snp.updateConstraints { make in
            make.width.equalTo(Appearance.buttonWidth)
        }
        nextButton.setTitle(Text.Onboarding.next, for: .normal)
        UIView.animate(withDuration: Appearance.animationDuration) { [weak self] in
            guard let self = self else { return }
            self.layoutIfNeeded()
            self.skipButton.alpha = 1
        }
    }

    // MARK: - Internal methods

    func updateData(_ data: [Slide]) {
        dataSource.updateData(data)
        pageControl.numberOfPages = data.count
    }

    func nextPage() {
        dataSource.nextPage()
    }

    func getIsLastPage() -> Bool {
        return isLastPage
    }
}
