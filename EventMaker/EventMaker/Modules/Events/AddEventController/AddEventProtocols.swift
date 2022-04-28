//
//  AddEventProtocols.swift
//  EventMaker
//
//  Created by Олег Романов on 26.04.2022.
//

import Foundation

protocol AddEventViewInput: AnyObject {
    func showError(error: Error)
    func stopAnimating()
}

protocol AddEventViewOutput: AnyObject {
    func createEvent(event: EventDto, complition: @escaping (Result<Event, Error>) -> Void)
}
