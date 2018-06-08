//
//  ViewController.swift
//  TestApp
//
//  Created by Gleb Kalinichenko on 08.03.18.
//  Copyright © 2018 Gleb Kalinichenko. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating, UISearchBarDelegate  {
    
    @IBOutlet var list_offers: UITableView!
    var searchController = UISearchController(searchResultsController: nil)
    var offers = ["offer 1", "offer 2"]
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        checkVideoPermissions()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return offers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "offer_item_cell", for: indexPath) as! OfferTableViewCell
        cell.name_offer.text = offers[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "offer_details_segue", sender: self)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}

extension ViewController {
    func setupTableView() {
        setupRefreshControl()
        setupSearchController()
        
        list_offers.delegate = self
        list_offers.dataSource = self
    }
    
    func setupRefreshControl() {
        list_offers.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshListOffers(_:)), for: .valueChanged)
        
        refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching Offers Data ...")
    }
}

extension ViewController {
    
    @objc private func refreshListOffers(_ sender: Any) {
        list_offers.reloadData()
        refreshControl.endRefreshing()
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = true
        
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search offer"
        searchController.searchBar.sizeToFit()
        
        // Place the search bar view to the tableview headerview.
        list_offers.tableHeaderView = searchController.searchBar
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
    private func checkVideoPermissions() {
        AVCaptureDevice.requestAccess(for: AVMediaType.video) { response in
            if response {
                //access granted
            } else {
                
            }
        }
    }
}

