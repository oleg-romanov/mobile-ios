//
//  AddEventTypeProtocols.swift
//  EventMaker
//
//  Created by Олег Романов on 28.04.2022.
//

import Foundation

protocol AddEventTypeInput: AnyObject {}

protocol AddEventTypeOutput: AnyObject {
    func createEventType(eventType: EventTypeDto, complition: @escaping (Result<Void, Error>) -> Void)
}
