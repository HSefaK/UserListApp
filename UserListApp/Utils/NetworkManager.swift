//
//  NetworkManager.swift
//  UserListApp
//
//  Created by Hüseyin Sefa Küçük on 20.01.2025.
//

import Foundation

protocol NetworkManagerProtocol {
    func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void)
}

class NetworkManager: NetworkManagerProtocol {
  static let shared = NetworkManager()
    
    private init() {} // Singleton yapıyorum çünkü bu sınıfın birden fazla instance'ına gerek yok.

    func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        // JSONPlaceholder'dan kullanıcı listesini alıyorum.
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            // URL yanlışsa buraya düşer. Bu durumu test etmeliyim.
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                // Hata oluştuğunda burayı kullanıyorum.
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                // Veri yoksa bu hata oluşacak.
                completion(.failure(NSError(domain: "No Data", code: -1, userInfo: nil)))
                return
            }
            
            do {
                // Gelen JSON verisini decode ediyorum.
                let users = try JSONDecoder().decode([User].self, from: data)
                completion(.success(users))
            } catch {
                // JSON hatalıysa buraya düşecek.
                completion(.failure(error))
            }
        }.resume()
    }
}

class MockNetworkManager: NetworkManagerProtocol {
    func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        let mockUsers = [
            User(id: 1, name: "John Doe", email: "john.doe@example.com", phone: "1234567890", website: "johndoe.com"),
            User(id: 2, name: "Jane Doe", email: "jane.doe@example.com", phone: "9876543210", website: "janedoe.com")
        ]
        completion(.success(mockUsers))
    }
}
