//
//  ViewController.swift
//  ImageFeed
//
//  Created by Рина Райф on 16.05.2024.
//

import UIKit

class ImagesListViewController: UIViewController {
    @IBOutlet private var tableView: UITableView!
    
    private let photosName: [String] = Array(0..<20).map{ "\($0)" }
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 200
        tableView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
    }
}

extension ImagesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photosName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ImagesListCell.reuseIdentifier, for: indexPath)
        // 1 Извлекаем ячейку cell из пула переиспользуемых ячеек таблицы с идентификатором заданным в imagesListCell.
        
        guard let imageListCell = cell as? ImagesListCell else {
            return UITableViewCell()
            // 2 Выполняем проверку: можно ли привести ячейку к типу imagesListCell.
        }
        
        configCell(for: imageListCell, with: indexPath)
        // 3 Метод который настраивает содержимое ячейки.
        return imageListCell
        // 4 Возвращаем ячейку типа ImagesListCell
    }
}

extension ImagesListViewController {
    func configCell(for cell: ImagesListCell, with indexPath: IndexPath) {
        guard let image = UIImage(named: photosName[indexPath.row]) else {
            return
        } // 1 Извлекаем изображение по имени их массива по индексу через метод .row, иначе возвращаем nil.
        
        cell.cellImage.image = image // 2 Устанавливаем изображение для свойства image у ячейки cell.
        cell.dateLabel.text = dateFormatter.string(from: Date()) // 3 Форматируем дату и устанавливаем как текст в DateLabel.
        
        if indexPath.row % 2 == 0 {
            cell.likeButton.setImage(UIImage(named: "like_button_on"), for: .normal)
        } else {
            cell.likeButton.setImage(UIImage(named: "like_button_off"), for: .normal)
        } // 4 Используем конструкцию if-else для установки изображения кнопки "лайк" в зависимости от четности индекса строки.
    }
}
    extension ImagesListViewController: UITableViewDelegate {
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            guard let image = UIImage(named: photosName[indexPath.row]) else {
                return 0
            }
            
            let imageInsets = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
            let imageViewWidth = tableView.bounds.width - imageInsets.left - imageInsets.right
            let imageWidth = image.size.width
            let scale = imageViewWidth / imageWidth
            let cellHeight = image.size.height * scale + imageInsets.top + imageInsets.bottom
            return cellHeight
        }
    }

