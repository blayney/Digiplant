//
//  ViewController.swift
//  Digiplant2
//
//  Created by Will Blayney on 30/05/2020.
//  Copyright © 2020 Will Blayney. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!

    var Plants = ["Item1", "Item2"]

    override var preferredStatusBarStyle: UIStatusBarStyle{
        return.lightContent
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return Plants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FreddieRawlins")!
        let text = Plants[indexPath.row]
        cell.textLabel?.text = text
        return cell
    }

    
    @IBAction func TappedAddPlant() {
        
        let alert = UIAlertController(title: "Add Plant", message: nil, preferredStyle: .alert)
        alert.addTextField { (UITextField) in
            UITextField.placeholder = "Enter Plant Name"
        }
        
        let action = UIAlertAction(title:"Add", style: .default) {
            (_) in guard let plant = alert.textFields?.first?.text else {return}
            print(plant)
            self.addPlant(plant)
        }
        alert.addAction(action)
        present(alert,animated: true)
        
    }
    
    func addPlant(_ plant: String){
        let index = 0
        Plants.insert(plant, at: index)
        
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: Plants.count - 1, section: 0)], with: .automatic)
        tableView.endUpdates()
        }
}


