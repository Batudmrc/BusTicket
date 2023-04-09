//
//  Ticket.swift
//  BusTicket
//
//  Created by Batuhan Demircioğlu on 1.04.2023.
//

import Foundation

struct Ticket {
    var passenger: Passenger?
    var date: TicketDate?
    var clock: String?
    var price: Int?
    var from: String?
    var to: String?
    var selectedChairCount: Int?
    var selectedChairs: [Int]?
    var seatInfo: [SeatStub]?
}
