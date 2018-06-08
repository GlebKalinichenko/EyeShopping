//
//  ProductViewController.swift
//  EyeShopping
//
//  Created by Gleb Kalinichenko on 18.05.18.
//  Copyright © 2018 Gleb Kalinichenko. All rights reserved.
//

import UIKit

protocol IProductViewController: class {
    func show(preloader: Bool)
    func show(items: [Item])
    func show(error: String)
    func back()
}

class ProductViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var itemsTableView: UITableView!
    @IBOutlet weak var preloader: UIActivityIndicatorView!
    var items: [Item] = [Item]()
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoreItemCell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row].name
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ProductViewController: IProductViewController {
    
    func show(preloader: Bool) {
        if (preloader) {
            self.preloader.startAnimating()
            return
        }
        
        self.preloader.stopAnimating()
    }
    
    func show(items: [Item]) {
        self.items += items
        self.itemsTableView.reloadData()
    }
    
    func show(error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func back() {
        navigationController?.popViewController(animated: true)
    }
}
