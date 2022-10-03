//
//  ContactModel.swift
//  Contact
//
//  Created by Hang on 21/07/2022.
//

import Foundation

class Contact: Codable {
    var firstName: String?
    var lastName: String
    var phone: String
    var email: String?
    var company: String?
    var image: String?
    var isSelect: Bool
    
    init(firstName: String? = nil, lastName: String, phone: String, email: String? = nil, company: String? = nil, image: String? = nil, isSelect: Bool) {
        self.firstName = firstName
        self.lastName = lastName
        self.phone = phone
        self.email = email
        self.company = company
        self.image = image
        self.isSelect = false
    }
}

class ContactSession {
    var title = ""
    var contacts: [Contact] = []
    
    init(title: String, contacts: [Contact]) {
        self.title = title
        self.contacts = contacts
    }
}

class ContactRecents {
    var contacts: Contact
    var date: String
    var status: String

    
    init(contacts: Contact, date: String, status: String) {
        self.contacts = contacts
        self.date = date
        self.status = status
    }
}

 
