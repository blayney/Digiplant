//
//  SetTypeVC.swift
//  Digiplant2
//
//  Created by Will Blayney on 31/05/2020.
//  Copyright © 2020 Will Blayney. All rights reserved.
//

import UIKit

class SetTypeVC: UIViewController, UITableViewDataSource {
    // Three constructors
    @IBOutlet weak var tableView: UITableView!
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return IndexedResults.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "APICallCells")!
        let text = IndexedResults[indexPath.row]
        cell.textLabel?.textAlignment = NSTextAlignment.left
        cell.textLabel?.text = "                  " + text
        return cell
    }
    
    @IBOutlet weak var SearchField: UITextField!
    var SearchResults = [String]()
    var IndexedResults = [String]()
    override func viewDidLoad() {
          super.viewDidLoad()
          // Do any additional setup after loading the view.
      }
    var searchTerm: String = ""
    
    @IBAction func PressSearch(_ sender: UIButton) {
        searchTerm = SearchField.text!
            SearchResults = CoreDataUtils.shared.searchNameString(searchTerm: searchTerm) ?? []
            print(SearchResults)
        for result in SearchResults{
            addResult(result)
        }
        
    }
    
    func addResult(_ Type: String){
        let index = IndexedResults.count
        IndexedResults.insert(Type, at: index)
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: IndexedResults.count - 1, section: 0)], with: .automatic)
        tableView.endUpdates()

        
    }
    
    
    
    


}
