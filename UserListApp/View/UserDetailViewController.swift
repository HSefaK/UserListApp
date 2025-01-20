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

    // Kullanıcının detaylarını gösterebilmek için viewModel'i burada initialize ediyorum.
    init(user: User) {
        self.viewModel = UserDetailViewModel(user: user)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI() // Kullanıcı arayüzü ayarları.
    }

    private func setupUI() {
        view.backgroundColor = .white // Arka planı beyaz yapıyorum çünkü temiz bir görünüm sağlıyor.
        title = "User Details" // Ekranın başlığı.

        // TableView'i ekrana ekliyorum ve boyutlarını ekranla aynı olacak şekilde ayarlıyorum.
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.dataSource = self // TableView'in verilerini kendim yönetiyorum.
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DetailCell") // Hücreleri kaydediyorum.
        tableView.allowsSelection = false // Bu ekranda hücreler seçilebilir değil çünkü detay ekranı zaten statik bir liste.
    }

    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4 // Her kullanıcı için 4 satır göstereceğim: isim, e-posta, telefon ve web sitesi.
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath)

        // Burada hangi sırada hangi bilgiyi göstereceğimi kontrol ediyorum.
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

        cell.textLabel?.numberOfLines = 0 // Bilgilerin birden fazla satırda düzgün görünmesi için.
        return cell
    }
}
