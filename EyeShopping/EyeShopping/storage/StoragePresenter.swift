//
//  StoragePresenter.swift
//  EyeShopping
//
//  Created by Gleb Kalinichenko on 18.05.18.
//  Copyright © 2018 Gleb Kalinichenko. All rights reserved.
//

import Foundation

protocol IStoragePresenter {
    func fetchStores(offset: Int, limit: Int)
    func attachView(view: IStorageViewController?)
}

class StoragePresenter : IStoragePresenter {
    fileprivate var view: IStorageViewController?
    var dataSource = StorageDataSource()
    
    func attachView(view: IStorageViewController?) {
        self.view = view
    }
    
    func fetchStores(offset: Int, limit: Int) {
        dataSource.fetchStores(offset: offset, limit: limit) {stores in
            guard let view = self.view else {
                return 
            }
            view.show(stores: stores)
        }
    }
}
