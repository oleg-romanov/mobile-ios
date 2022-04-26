//
//  EventViewModelItems.swift
//  EventMaker
//
//  Created by Олег Романов on 25.04.2022.
//

import UIKit

class EventParticipantsCell: UITableViewCell {
    @IBOutlet var participantNameLabel: UILabel!

    var item: User? {
        didSet {
            guard let item = item else {
                return
            }
            participantNameLabel?.text = item.name
        }
    }
}
