//
//  StartView.swift
//  EventMaker
//
//  Created by Олег Романов on 04.04.2022.
//

import SnapKit
import UIKit

class StartView: UIView {
    struct Appearance: Grid {
        static let titleText: String = "EventMaker"
        static let titleFontWeight: UIFont.Weight = .bold
        static let subTitleText: String = "Списки событий"
        static let subTitleFontWeight: UIFont.Weight = .regular
        static let heightOfButton: CGFloat = 40
        static let buttonWidth: CGFloat = UIScreen.main.bounds.width - 80
        static let lineViewWidth: CGFloat = UIScreen.main.bounds.width - 64
        static let bottomPaddingLastButton: CGFloat = 83
    }

    // MARK: - Properties

    var appearance: Appearance

    private lazy var logoImageView = UIImageView(image: Assets.logo.image)

    lazy var signInWithEmail = ButtonSignInWithEmail(title: Text.SignIn.continueWithEmail)

    lazy var signInWithGoogle = ButtonSignIn(title: Text.SignIn.continueWithGoogle, buttonColor: Assets.googleRed.color, logo: Assets.googleLogo.image)

    lazy var signInWithApple = ButtonSignIn(title: Text.SignIn.continueWithApple, buttonColor: .black, logo: Assets.appleLogo.image)

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = Appearance.titleText
        label.font = .systemFont(ofSize: appearance.mSpace, weight: Appearance.titleFontWeight)
        return label
    }()

    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = Appearance.subTitleText
        label.font = .systemFont(ofSize: Appearance.xxxl, weight: Appearance.subTitleFontWeight)
        label.textColor = Assets.gray.color
        return label
    }()

    private lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = Assets.lightgray.color
        return view
    }()

    // как распологать элементы и их размер
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = UIScreen.main.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        return layout
    }()

    init(appearance: Appearance = Appearance()) {
        self.appearance = appearance
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func commonInit() {
        setupStyle()
        addSubviews()
        makeConstraints()
    }

    private func setupStyle() {
        backgroundColor = Assets.background1.color
    }

    private func addSubviews() {
        addSubview(logoImageView)
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        addSubview(signInWithEmail)
        addSubview(signInWithGoogle)
        addSubview(signInWithApple)
        addSubview(lineView)
    }

    private func makeConstraints() {
        titleLabel.snp.makeConstraints { make in
            if ScreenSize.current != .sizeIPhoneSE {
                make.top.equalToSuperview().inset(appearance.xxxlSpace + appearance.xxsSpace)
            } else {
                make.top.equalToSuperview().inset(appearance.xlSpace)
            }
            make.centerX.equalToSuperview()
        }
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(appearance.sSpace)
            make.centerX.equalToSuperview()
            make.size.equalTo(100)
        }
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(appearance.sSpace)
            make.centerX.equalToSuperview()
        }
        signInWithEmail.snp.makeConstraints { make in
            if ScreenSize.current != .sizeIPhoneSE {
                make.bottom.equalToSuperview().inset(appearance.xxxlSpace + appearance.xxsSpace)
            } else {
                make.bottom.equalToSuperview().inset(appearance.mSpace - appearance.xxxsSpace)
            }
            // на se коэфф: 0,5; на 7: 0,7 на 10: 1
            make.centerX.equalToSuperview()
            make.height.equalTo(Appearance.heightOfButton)
            make.width.equalTo(Appearance.buttonWidth)
        }
        signInWithGoogle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(Appearance.heightOfButton)
            make.width.equalTo(Appearance.buttonWidth)
            if ScreenSize.current != .sizeIPhoneSE {
                make.bottom.equalTo(signInWithEmail.snp.top).inset(-appearance.xxxlSpace)
            } else {
                make.bottom.equalTo(signInWithEmail.snp.top).inset(-appearance.xxlSpace)
            }
        }
        signInWithApple.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(Appearance.heightOfButton)
            make.width.equalTo(Appearance.buttonWidth)
            if ScreenSize.current != .sizeIPhoneSE {
                make.bottom.equalTo(signInWithGoogle.snp.top).inset(-appearance.sSpace)
            } else {
                make.bottom.equalTo(signInWithGoogle.snp.top).inset(-appearance.sSpace)
            }
        }
        lineView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.width.equalTo(Appearance.lineViewWidth)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(signInWithEmail.snp.top).inset(-appearance.xlSpace)
        }
    }
}
