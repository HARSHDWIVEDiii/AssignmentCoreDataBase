//
//  User.swift
//  AssignmentCoreDataBase
//
//  Created by Mac on 16/01/24.
//

import Foundation
struct User{
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: Address
    let phone: String
    let website: String
    let company: Company
}

struct Address {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: Geo
}

struct Geo {
    let lat: String
    let lng: String
}

struct Company{
    let name: String
    let catchPhrase: String
    let bs: String
}
