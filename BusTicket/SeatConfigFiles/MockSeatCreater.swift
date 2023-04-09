//
//  MockSeatCreater.swift
//  BusTicket
//
//  Created by Batuhan Demircioğlu on 6.04.2023.
//

import Foundation

struct SeatStub {
    let id: String
    let number: Int
    var salable: Bool
    var gender: Bool
    let hall: Bool
}

class MockSeatCreater {
    
    func create(count: Int) -> [SeatStub] {
        
        var list = [SeatStub]()
        (1...count).forEach { (count) in
            let isHall = (count - 2) % 5 == 1
            let stub = SeatStub(id: UUID().uuidString,
                                number: count,
                                salable: true,
                                gender: Bool.random(),
                                hall: isHall)
            list.append(stub)
        }
        return list
    }
    
}

