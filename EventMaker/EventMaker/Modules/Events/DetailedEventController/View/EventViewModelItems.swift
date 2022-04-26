//
//  EventViewModelItems.swift
//  EventMaker
//
//  Created by Олег Романов on 25.04.2022.
//

import Foundation

class EventViewModelDateItem: EventViewModelItem {
    var type: EventViewModelItemType {
        return .date
    }

    var sectionTitle: String {
        return "Дата"
    }

    var date: Date

    init(date: Date) {
        self.date = date
    }
}

// class EventViewModelParticipantItem: EventViewModelItem {
//    var type: EventViewModelItemType {
//        return .participants
//    }
//
//    var sectionTitle: String {
//        return ""
//    }
//
//    var participants: [User]
//
//    var rowCount: Int {
//        return participants.count
//    }
//
//    init(participants: [User]) {
//        self.participants = participants
//    }
// }

class EventViewModelDescriptionItem: EventViewModelItem {
    var type: EventViewModelItemType {
        return .description
    }

    var sectionTitle: String {
        return "Описание"
    }

    var description: String

    init(description: String) {
        self.description = description
    }
}

