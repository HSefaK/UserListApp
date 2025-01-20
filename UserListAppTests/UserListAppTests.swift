//
//  UserListAppTests.swift
//  UserListAppTests
//
//  Created by Hüseyin Sefa Küçük on 20.01.2025.
//

import XCTest
@testable import UserListApp

final class UserListAppTests: XCTestCase {

    var networkManager: NetworkManagerProtocol! // Mock veya gerçek NetworkManager burada tutuluyor.
    var viewModel: UserListViewModel! // ViewModel'i burada test edeceğim.

    override func setUpWithError() throws {
        super.setUp()
        // Test için MockNetworkManager kullanıyorum çünkü gerçek API çağrılarına bağımlı olmak istemiyorum.
        networkManager = MockNetworkManager()
        viewModel = UserListViewModel()
    }

    override func tearDownWithError() throws {
        // Test bittikten sonra temizliğimi yapıyorum.
        networkManager = nil
        viewModel = nil
        super.tearDown()
    }

    func testFetchUsersSuccess() {
        // Burada kullanıcıları başarıyla çekip çekmediğimizi kontrol ediyorum.
        // Gerçek bir ağ bağlantısına bağımlı kalmak istemediğim için mock verilerle test ediyorum.
        let expectation = XCTestExpectation(description: "Users fetched successfully")
        
        networkManager.fetchUsers { result in
            switch result {
            case .success(let users):
                // Kullanıcılar boş olmamalı.
                XCTAssertNotNil(users, "Kullanıcı listesi boş olmamalı")
                // MockNetworkManager 2 kullanıcı döndürdüğü için bunu kontrol ediyorum.
                XCTAssertEqual(users.count, 2, "Beklenen kullanıcı sayısı yanlış")
                expectation.fulfill()
            case .failure(let error):
                // Eğer buraya düşüyorsak bir problem var demektir.
                XCTFail("Hata oluştu: \(error.localizedDescription)")
            }
        }
        
        // 5 saniye içinde sonuç bekliyorum, test burada takılırsa problem var.
        wait(for: [expectation], timeout: 5.0)
    }

    func testViewModelUserCount() {
        // Burada ViewModel'deki kullanıcı sayısının doğru şekilde tutulup tutulmadığını test ediyorum.
        // Yine mock verilerle çalışıyorum çünkü bu birim test.
        let mockUsers = [
            User(id: 1, name: "John Doe", email: "john.doe@example.com", phone: "1234567890", website: "johndoe.com"),
            User(id: 2, name: "Jane Doe", email: "jane.doe@example.com", phone: "9876543210", website: "janedoe.com")
        ]
        
        // Testler için ViewModel'e manuel olarak kullanıcıları ekliyorum.
        viewModel.injectUsers(mockUsers)
        
        // Kullanıcı sayısını kontrol ediyorum, 2 kullanıcı eklemiştim.
        XCTAssertEqual(viewModel.users.count, 2, "Beklenen kullanıcı sayısı yanlış")
    }
}
