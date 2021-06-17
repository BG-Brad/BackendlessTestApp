
import SwiftUI
import Foundation
import Combine


class UserSettings : ObservableObject {
    @Published var username: String {
        didSet {
            UserDefaults.standard.set(username, forKey: "username")
        }
    }
    
    @Published var password: String {
        didSet {
            UserDefaults.standard.set(password, forKey: "password")
        }
    }
    
    init() {
        self.username = UserDefaults.standard.object(forKey: "username") as? String ?? "Username"
        self.password = UserDefaults.standard.object(forKey: "password") as? String ?? "Password"
    }
}

class ObservedObjectes : ObservableObject {
    
    @Published var isAuthenticatedUser = false
    @Published var apiToken = "277f777777757e257a33272f7a45ca34ef75d35d7cad5522de465553a673fca6"
    @Published var message = "Please Log In"
    
}

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


