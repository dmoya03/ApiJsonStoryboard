//
//  ViewController.swift
//  JsonUiKit
//
//  Created by Daniel Moya on 15/1/24.
//

import UIKit

class cell_item: UITableViewCell {
    
    @IBOutlet weak var image_: UIImageView!
    @IBOutlet weak var name_: UILabel!
    @IBOutlet weak var email_: UILabel!
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.delegate = self
        table.dataSource = self
        
        ModelViewModel.shared.fetch{done in 
            if done {
                self.table.reloadData()
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ModelViewModel.shared.dataModel.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! cell_item
        let user = ModelViewModel.shared.dataModel.data[indexPath.row]
        cell.name_.text = user.first_name
        cell.email_.text = user.email
        guard let imageURL = URL(string: user.avatar) else { fatalError("Without image") }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                cell.image_.image = image
                self.table.reloadData()
            }
        }
        
        return cell
    }
}

