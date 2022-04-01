//
//  OnboardingModel.swift
//  EventMaker
//
//  Created by Олег Романов on 31.03.2022.
//

import UIKit

struct Slide {
    var title: String
    var subtitle: String

    static func generateSlides() -> [Slide] {
        let slide1 = Slide(
            title: "Добро пожаловать!",
            subtitle: "В EventMaker"
        )
        let slide2 = Slide(
            title: "EventMaker",
            subtitle: "Это упорядоченный список запланированных событий, которыми можно поделиться с кем угодно"
        )
        let slide3 = Slide(
            title: "Регистрация",
            subtitle: "Для того, чтобы начать полноценно пользоваться приложением, необходимо зарегистрироваться. После успешной регистрации Вы попадете на экран где сможете создать свое первое событие!"
        )
        let slide4 = Slide(
            title: "Нет времени ждать",
            subtitle: "Приступим!"
        )

        return [slide1, slide2, slide3, slide4]
    }
}
