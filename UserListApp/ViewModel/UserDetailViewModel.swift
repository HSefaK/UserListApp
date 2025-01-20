//
//  UserDetailViewModel.swift
//  UserListApp
//
//  Created by Hüseyin Sefa Küçük on 20.01.2025.
//

import Foundation

class UserDetailViewModel {
    private let user: User
    
    var name: String {
        user.name
    }
    
    var email: String {
        user.email
    }
    
    var phone: String {
        user.phone
    }
    
    var website: String {
        user.website
    }
    
    init(user: User) {
        self.user = user
    }
}
