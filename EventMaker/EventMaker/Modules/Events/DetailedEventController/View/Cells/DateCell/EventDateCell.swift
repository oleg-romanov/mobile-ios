//
//  EventViewModelItems.swift
//  EventMaker
//
//  Created by Олег Романов on 25.04.2022.
//

import UIKit

class EventDateCell: UITableViewCell {
    @IBOutlet var dateLabel: UILabel!

    var item: EventViewModelItem? {
        didSet {
            guard let item = item as? EventViewModelDateItem else {
                return
            }
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "d MMMM YYYY"
            dateFormatter.locale = Locale(identifier: "Ru")
            dateLabel.text = dateFormatter.string(from: item.date)
        }
    }
}
