//
//  EventTypeController.swift
//  EventMaker
//
//  Created by Олег Романов on 28.04.2022.
//

import UIKit

class EventTypeCell: UITableViewCell {
    var id: Int?
    var name: String?

    @IBOutlet var nameLabel: UILabel!

    func configure(eventType: EventType) {
        id = eventType.id
        name = eventType.name
        nameLabel.text = name
    }

    func addEventTypeConfigure() {
        nameLabel.text = "Добавить тип события"
    }
}
