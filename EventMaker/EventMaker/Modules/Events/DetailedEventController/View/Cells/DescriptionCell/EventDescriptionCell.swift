//
//  EventViewModelItems.swift
//  EventMaker
//
//  Created by Олег Романов on 25.04.2022.
//

import UIKit

class EventDescriptionCell: UITableViewCell {
    @IBOutlet var textView: UITextView!

    var item: EventViewModelItem? {
        didSet {
            guard let item = item as? EventViewModelDescriptionItem else {
                return
            }
            textView?.text = item.description
        }
    }
}
