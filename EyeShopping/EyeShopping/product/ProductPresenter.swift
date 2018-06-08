//
//  ProductPresenter.swift
//  EyeShopping
//
//  Created by Gleb Kalinichenko on 18.05.18.
//  Copyright © 2018 Gleb Kalinichenko. All rights reserved.
//

import Foundation

protocol IProductPresenter: class {
    func fetchItems(offset: Int, limit: Int)
    func openCamera()
    func openProductDetails()
}

class ProductPresenter: IProductPresenter {
    
    fileprivate var view: IProductViewController?
    var dataSource = ProductDataSource()
    var merchantId: CLong = 0
    
    func fetchItems(offset: Int, limit: Int) {
        dataSource.fetchItems(offset: offset, limit: limit, merchantId: merchantId) { itemsResponse in
            guard let view = self.view else {return}
            view.show(items: itemsResponse)
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
