//
//  UserListViewModel.swift
//  UserListApp
//
//  Created by Hüseyin Sefa Küçük on 20.01.2025.
//

import Foundation

class UserListViewModel {
    private(set) var users: [User] = []
    var reloadTableView: (() -> Void)?
    
    func fetchUsers() {
        NetworkManager.shared.fetchUsers { [weak self] result in
            switch result {
            case .success(let users):
                self?.users = users
                self?.reloadTableView?()
            case .failure(let error):
                print("Error fetching users: \(error.localizedDescription)")
            }
        }
    }
  // Testler için kullanıcı verilerini manuel olarak eklemek için
  func injectUsers(_ mockUsers: [User]) {
      self.users = mockUsers
  }
}
