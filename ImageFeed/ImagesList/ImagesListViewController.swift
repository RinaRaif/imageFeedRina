//
//  ViewController.swift
//  ImageFeed
//
//  Created by Рина Райф on 16.05.2024.
//

import UIKit

class ImagesListViewController: UIViewController {
    @IBOutlet private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 200
    }
}

extension ImagesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ImagesListCell.reuseIdentifier, for: indexPath)
        // 1 Извлекаем ячейку cell из пула переиспользуемых ячеек таблицы с идентификатором заданным в imagesListCell.
        
        guard let imageListCell = cell as? ImagesListCell else {
            // 2 Выполняем проверку: можно ли привести ячейку к типу imagesListCell.
            return UITableViewCell()
        }
        
        configCell(for: imageListCell)
        // 3 Метод который настраивает содержимое ячейки.
        return imageListCell
        // 4 Возвращаем ячейку типа ImagesListCell
    }
}

extension ImagesListViewController {
    func configCell(for cell: ImagesListCell) { }
}

extension ImagesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}
}
