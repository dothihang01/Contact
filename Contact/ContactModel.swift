//
//  ContactModel.swift
//  Contact
//
//  Created by Hang on 21/07/2022.
//

import Foundation
//class Contacts {
//    var arrayContacts: [(name: String, phone: String)] = [("Bao","039485764"),("Hai","093475757"),("Hoa","039857485"),("Anh","029438457")]
//}
//let array = Contacts()

class Contact {
    var name: String
    var phone: String
    var address: String?
    
    var listPhone: [String] = []
    
    init(name: String, phone: String, address: String? = nil) {
        self.name = name
        self.phone = phone
        self.address = address
    }
}

class ContactSession: Contact {
    var title = ""
    var contacts: [Contact] = []
    func getSession() {
       
    }
}


