//
//  ViewController.swift
//  Digiplant2
//
//  Created by Will Blayney on 30/05/2020.
//  Copyright © 2020 Will Blayney. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UITableViewDataSource, AVCaptureMetadataOutputObjectsDelegate  {
    
    @IBOutlet weak var tableView: UITableView!

    var video = AVCaptureVideoPreviewLayer()
    
    var PlantNames = [String]() // plant names
    var Memberships = [String]()
    var GrowthLevel = [Float]()
    var PlantTypes = [String]()

    override var preferredStatusBarStyle: UIStatusBarStyle{
        return.lightContent
        
    }
    
    // new add new button, with RFID activation call
    @IBOutlet weak var NewAddNewPlant: UIButton!
    
    
    // runs when the app loads
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        initializeTable()

                
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return PlantNames.count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FreddieRawlins")!
        
        let text = PlantNames[indexPath.row]
        cell.textLabel?.textAlignment = NSTextAlignment.left
        cell.textLabel?.text = "                " + text
        
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
            self.addPlant(plant, "Debug", "Patio", 0.0)
        }
        alert.addAction(action)
        present(alert,animated: true)
        
    }
    
    func addPlant(_ plantName: String, _ plantType: String, _ Membership: String, _ GrowthLevel: Float){
        let index = PlantNames.count
        PlantNames.insert(plantName, at: index)
        
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: PlantNames.count - 1, section: 0)], with: .automatic)
        tableView.endUpdates()
        }
    
    func initializeTable(){
        // runs when the app launches
        
        var groupList: [String] = CoreDataUtils.shared.returnGroupList() ?? ["Default"] // Contains list of every group taken from storage
        
        // HUGH TODO. iterate through list of all plants, calling addPlant on them
        for plant in CoreDataUtils.shared.returnPlantList()! {
            var attributes = CoreDataUtils.shared.returnPlantAttributes(plantName: plant)!
            var (group, growthLevel, plantID, plantType, rfidReturn) = attributes
            addPlant(plant, plantType, group, growthLevel)
        }
        
    }
}


