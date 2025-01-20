//
//  UserDetailViewController.swift
//  UserListApp
//
//  Created by Hüseyin Sefa Küçük on 20.01.2025.
//

import Foundation
import UIKit

class UserDetailViewController: UIViewController, UITableViewDataSource {
    private let viewModel: UserDetailViewModel
    private let tableView = UITableView()

    init(user: User) {
        self.viewModel = UserDetailViewModel(user: user)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .white
        title = "User Details"

        // TableView Ayarları
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DetailCell")
        tableView.allowsSelection = false
    }

    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4 // Gösterilecek 4 bilgi: İsim, e-posta, telefon, web sitesi
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath)

        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Name: \(viewModel.name)"
        case 1:
            cell.textLabel?.text = "Email: \(viewModel.email)"
        case 2:
            cell.textLabel?.text = "Phone: \(viewModel.phone)"
        case 3:
            cell.textLabel?.text = "Website: \(viewModel.website)"
        default:
            cell.textLabel?.text = ""
        }

        cell.textLabel?.numberOfLines = 0 // Çok satırlı metin için
        return cell
    }
}
