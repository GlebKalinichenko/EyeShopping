    //
//  StorageViewController.swift
//  EyeShopping
//
//  Created by Gleb Kalinichenko on 18.05.18.
//  Copyright © 2018 Gleb Kalinichenko. All rights reserved.
//

import UIKit

protocol IStorageViewController: class {
    func show(preloader: Bool)
    func show(stores: [Store])
}

class StorageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var stores: UITableView!
    var storesList: [Store] = [Store]()
    fileprivate var presenter = StoragePresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stores.delegate = self
        stores.dataSource = self
        presenter.attachView(view: self)
        presenter.fetchStores(offset: 0, limit: 10)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storesList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoreCell", for: indexPath) as! StoreCellTableViewCell
        cell.storeName.text = storesList[indexPath.row].storeName
        cell.addressLine.text = storesList[indexPath.row].addressLine1
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /*let mainStoryboard = UIStoryboard(name: "Storyboard", bundle: Bundle.main)
        let vc : ProductViewController = mainStoryboard.instantiateViewController(withIdentifier: "StoreItemScreen") as! ProductViewController
        self.present(vc, animated: true, completion: nil)*/
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
    
extension StorageViewController: IStorageViewController {
    
    func show(preloader: Bool) {
        /*if (preloader) {
            activityIndicator.startAnimating()
            return
        }
        
        activityIndicator.stopAnimating()*/
    }
    
    func show(stores: [Store]) {
        storesList += stores
        self.stores.reloadData()
    }
}
    

