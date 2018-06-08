//
//  AllProductPresenter.swift
//  EyeShopping
//
//  Created by Gleb Kalinichenko on 18.05.18.
//  Copyright © 2018 Gleb Kalinichenko. All rights reserved.
//

import Foundation

protocol IAllProductPresenter: class {
    func attachView(view: IAllProductViewController?) 
    func fetchItems(offset: Int, limit: Int)
    func openCamera()
    func openProductDetails()
}

class AllProductPresenter: IAllProductPresenter {
    fileprivate var view: IAllProductViewController?
    var dataSource = AllItemsDataSource()
    
    func attachView(view: IAllProductViewController?) {
        self.view = view
    }
    
    func fetchItems(offset: Int, limit: Int) {
        dataSource.fetchItems(offset: offset, limit: limit) { items in
            guard let view = self.view else {
                return
            }
            view.showItems(items: items)
        }
    }
    
    func openCamera() {
        guard let view = self.view else {return}
        view.back()
    }
    
    func openProductDetails() {
        openCamera()
    }
}
