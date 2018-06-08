//
//  AllProductViewController.swift
//  EyeShopping
//
//  Created by Gleb Kalinichenko on 18.05.18.
//  Copyright © 2018 Gleb Kalinichenko. All rights reserved.
//

import UIKit

protocol IAllProductViewController: class {
    func showItems(items: [Item])
    func show(error: String)
    func show(preloader: Bool)
    func back()
}

class AllProductViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var itemTableView: UITableView!
    fileprivate var itemsList: [Item] = [Item]()
    fileprivate var presenter = AllProductPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        itemTableView.delegate = self
        itemTableView.dataSource = self
        presenter.attachView(view: self)
        presenter.fetchItems(offset: 0, limit: 10)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        /*if (self.navigationController?.viewControllers.index(of: self) == NSNotFound) {
            let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController];
            self.navigationController!.popToViewController(viewControllers[viewControllers.count - 2], animated: true);
        }*/
        
        super.viewDidDisappear(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllItemCell", for: indexPath) as! ItemsTableViewCell
        cell.itemName.text = itemsList[indexPath.row].name
        cell.storeName.text = itemsList[indexPath.row].shop
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        TypeSingletion.sharedInstance.type = self.itemsList[indexPath.row].type
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "DirectViewController") as! DirectViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
        //let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController];
        //self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true);
    }
}

extension AllProductViewController: IAllProductViewController {
    func show(preloader: Bool) {
        /*if (preloader) {
            self.preloader.startAnimating()
            return
        }
        
        self.preloader.stopAnimating()*/
    }
    
    func showItems(items: [Item]) {
        self.itemsList += items
        self.itemTableView.reloadData()
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
