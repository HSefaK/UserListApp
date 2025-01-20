//
//  UserListViewController.swift
//  UserListApp
//
//  Created by Hüseyin Sefa Küçük on 20.01.2025.
//

import Foundation
import UIKit

class UserListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private let tableView = UITableView()
    private let viewModel = UserListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI() // Kullanıcı arayüzü ayarlarını yapıyorum.
        bindViewModel() // ViewModel ile bağlantıyı kuruyorum.
        viewModel.fetchUsers() // Kullanıcıları API'den çekiyorum.
    }

    private func setupUI() {
        title = "Users" // Ekranın başlığı.
        
        // TableView'i ekrana ekliyorum ve tam ekran olacak şekilde ayarlıyorum.
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UserCell") // Hücreleri kaydediyorum.
    }

    private func bindViewModel() {
        // ViewModel'den gelen güncelleme çağrısını dinliyorum.
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                // ViewModel'de kullanıcılar güncellendiğinde TableView'i yeniliyorum.
                self?.tableView.reloadData()
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // ViewModel'den gelen kullanıcı sayısı kadar satır göstereceğim.
        return viewModel.users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath)
        let user = viewModel.users[indexPath.row]
        
        // Her hücrede kullanıcının adını ve e-posta adresini göstereceğim.
        cell.textLabel?.numberOfLines = 0 // Çok satırlı gösterim için.
        cell.textLabel?.text = "\(user.name)\n\(user.email)"
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = viewModel.users[indexPath.row]
        let detailVC = UserDetailViewController(user: user)
        
        // Hücrenin highlight (seçili) durumunu kaldırıyorum.
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Kullanıcı detay ekranına geçiş yapıyorum.
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
