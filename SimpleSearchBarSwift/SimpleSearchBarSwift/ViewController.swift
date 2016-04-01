//
//  ViewController.swift
//  SimpleSearchBarSwift
//
//  Created by Bronson Dupaix on 3/21/16.
//  Copyright © 2016 Bronson Dupaix. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource {
    
    var citiesArray = ["Magna", "Saint George", "Salt Lake City", "Cedar City", "Ogden", "Kearns", "San Franciso", "Saint Anthony", "San Antonio", "Swisher"]
    
    var resultsArray = [String]()

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.resultsArray = self.citiesArray
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return resultsArray.count
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
    let cell = tableView.dequeueReusableCellWithIdentifier("ProCell")
        
        cell?.textLabel?.text = resultsArray[indexPath.row]
        
            return cell!
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        
        searchBar.text = ""
        
        print("Cancelled button pressed")
    
        searchBar.resignFirstResponder()
        
        self.resultsArray = self.citiesArray
        
        self.tableView.reloadData() 
    }
    
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.resultsArray.removeAll()
        
        for city in self.citiesArray{
            
            if self.hasString(city, searchText: searchText) {
                self.resultsArray.append(city)
            }

        }
                print(resultsArray)
        
        self.tableView.reloadData()
        
        self.restoreSearchBar(searchText)
    }
    
    
    func restoreSearchBar(searchText: String) {
        
        if searchText == "" {
            
        self.resultsArray.removeAll()
        
        self.resultsArray = self.citiesArray
        
        self.tableView.reloadData()
        }
    }
    
    
    func hasString(str: String, searchText: String) -> Bool{
        
        let lowercaseString = str.lowercaseString
        
        let lowercaseSearchText = searchText.lowercaseString
        
        return lowercaseString.hasPrefix(lowercaseSearchText)
    }
}

