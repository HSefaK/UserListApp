//
//  User.swift
//  UserListApp
//
//  Created by Hüseyin Sefa Küçük on 20.01.2025.
//

import Foundation

struct User: Decodable {
    let id: Int
    let name: String
    let email: String
    let phone: String
    let website: String
}
