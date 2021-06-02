
import SwiftUI
import Foundation



struct MovieObject: Codable, Hashable {
   
    var objectId: String?
    var title: String?
    var description: String?
    var rating: String?
    var release_year: String?
    var created: Date?
    
}


// MARK: - Computers
struct ComputersElement: Codable, Hashable {
    var owner, phone: String?
    var created: Int?
    var osVersion, computersClass, model, serial_number: String?
    var ownerID: String?
    var updated: Int?
    var objectId, email: String?
}

typealias ComputerData = ComputersElement

struct ComputerObject: Codable, Hashable {
    var owner, phone: String?
    var created: Int?
    var osVersion, computersClass, model, serial_number: String?
    var ownerID: String?
    var updated: Int?
    var objectId, email: String?
}
