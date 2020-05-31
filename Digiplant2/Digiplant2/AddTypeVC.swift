//
//  AddTypeVC.swift
//  Digiplant2
//
//  Created by Will Blayney on 31/05/2020.
//  Copyright © 2020 Will Blayney. All rights reserved.
//

import UIKit

class AddTypeVC: UIViewController,UITableViewDataSource {

    var RecentIndexSelected: Int = 0

    
    var PlantNames = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var tableView: UITableView!
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return PlantNames.count
    }
    var searchResults: [String] = []
    var searchTerm: String = ""
    @IBOutlet weak var SearchField: UITextField!
    @IBAction func PushSearch(_ sender: Any) {
        //let index = PlantNames.count
        searchTerm = SearchField.text!
        searchResults = CoreDataUtils.shared.searchNameString(searchTerm: searchTerm) ?? []
        for term in searchResults {
            PlantNames.append(term)
            initializeTable()
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FreddieRawlins")!
        
        let text = PlantNames[indexPath.row]
        cell.textLabel?.textAlignment = NSTextAlignment.left
        cell.textLabel?.text = "                  " + text
        
        return cell
    }
    @IBAction func GetRpw(_ sender: UIButton) {
        let buttonPostion = sender.convert(sender.bounds.origin, to: tableView)

        if let indexPath = tableView.indexPathForRow(at: buttonPostion) {
            let rowIndex =  indexPath.row
            RecentIndexSelected = (indexPath.row) + 1
            print(indexPath.row)
            
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier != "SetTypeTransfer"{
            let destVC = segue.destination as! AddPlantViewController
            destVC.PlantType = PlantNames[RecentIndexSelected]
            print("Set PlantType to " + PlantNames[RecentIndexSelected])
        }
    }
    
    func initializeTable(){
        tableView.dataSource = self
        tableView.allowsSelection = true
        //CoreDataUtils.shared.deleteAllPlants()
        //print("ran initialize table")
        // runs when the app launches
        print(PlantNames)
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: PlantNames.count - 1, section: 0)], with: .automatic)
        tableView.endUpdates()

        
        // Iterate through list of all plants, calling addPlant on them


        

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
}
