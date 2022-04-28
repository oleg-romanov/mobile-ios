// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum Text {
    internal enum Onboarding {
        /// Далее
        internal static let next = Text.tr("Localizable", "Onboarding.Next")
        /// Пропустить
        internal static let skip = Text.tr("Localizable", "Onboarding.Skip")
        /// Начать
        internal static let start = Text.tr("Localizable", "Onboarding.Start")
    }
    
    internal enum AddEvent {
        /// Добавить
        internal static let add = Text.tr("Localizable", "AddEvent.Add")
        /// Готово
        internal static let done = Text.tr("Localizable", "AddEvent.Done")
    }

    internal enum Events {
        /// Готово
        internal static let done = Text.tr("Localizable", "Events.Done")
        /// добавлен в список
        internal static let message = Text.tr("Localizable", "Events.Message")
        /// Люди
        internal static let title = Text.tr("Localizable", "Events.Title")
    }

    internal enum Categories {
        /// Категории
        internal static let title = Text.tr("Localizable", "Categories.Title")
    }

    internal enum EventTypes {
        /// Типы событий
        internal static let title = Text.tr("Localizable", "EventTypes.Title")
    }

    internal enum EventsModel {
        /// Друзья
        internal static let category = Text.tr("Localizable", "EventsModel.Category")
    }

    internal enum SignIn {
        internal static let continueWithGoogle = Text.tr("Localizable", "SignIn.WithGoogle")
        internal static let continueWithEmail = Text.tr("Localizable", "SignIn.WithEmail")
        internal static let continueWithApple = Text.tr("Localizable", "SignIn.WithApple")
    }
}

// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Text {
    private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
        let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
        return String(format: format, locale: Locale.current, arguments: args)
    }
}

// swiftlint:disable convenience_type
private final class BundleToken {
    static let bundle = Bundle(for: BundleToken.self)
}

// swiftlint:enable convenience_type

