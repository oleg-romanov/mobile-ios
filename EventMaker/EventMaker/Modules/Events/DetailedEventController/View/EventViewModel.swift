//
//  EventViewModel.swift
//  EventMaker
//
//  Created by Олег Романов on 24.04.2022.
//

import Foundation

import UIKit

class EventViewModel: NSObject {
    var items = [EventViewModelItem]()

    init(event: Event) {
        super.init()

        let date = EventViewModelDateItem(date: event.date)
        items.append(date)

//        let participants = EventViewModelParticipantItem(participants: event.participants)
//        items.append(participants)

        let description = EventViewModelDescriptionItem(description: event.description)
        items.append(description)
    }
}

extension EventViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items[section].rowCount
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.section]
        switch item.type {
        case .date:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "DateCell", for: indexPath) as? EventDateCell {
                cell.item = item
                return cell
            }
//        case .participants:
//            if let item = item as? EventViewModelParticipantItem, let cell = tableView.dequeueReusableCell(withIdentifier: "ParticipantCell", for: indexPath) as? EventParticipantsCell {
//                let participant = item.participants[indexPath.row]
//                cell.item = participant
//                return cell
//            }
        case .description:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionCell", for: indexPath) as? EventDescriptionCell {
                cell.item = item
                return cell
            }
        }
        // возвращаем ячейку по умолчанию, если ничего из вышеперечисленного не удалось
        return UITableViewCell()
    }
}

extension EventViewModel: UITableViewDelegate {
    func tableView(_: UITableView, heightForHeaderInSection _: Int) -> CGFloat {
        return 40
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let title = items[section].sectionTitle
        let view = HeaderForSections()
        view.configure(title: title)
        return view
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
