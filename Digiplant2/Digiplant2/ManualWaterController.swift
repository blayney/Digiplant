//
//  ManualWaterController.swift
//  Digiplant2
//
//  Created by Will Blayney on 31/05/2020.
//  Copyright © 2020 Will Blayney. All rights reserved.
//

import UIKit

class ManualWaterController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        initializeTable()
        // Do any additional setup after loading the view.
    }
    override var preferredStatusBarStyle: UIStatusBarStyle{
         return.lightContent
         
     }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return PlantNames.count
    }
    func addPlant(_ plantName: String, _ plantType: String, _ Membership: String, _ GrowthLevel: Float){
        let index = PlantNames.count
        PlantNames.insert(plantName, at: index)
        Memberships.insert(Membership, at: index)
        GrowthLevels.insert(GrowthLevel, at: index)
        PlantTypes.insert(plantType, at: index)
        LastWateredDate.insert("Never", at: index)

        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: PlantNames.count - 1, section: 0)], with: .automatic)
        tableView.endUpdates()
        }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FreddieRawlins")!
        
        let text = PlantNames[indexPath.row]
        cell.textLabel?.textAlignment = NSTextAlignment.left
        cell.textLabel?.text = "                  " + text
        
        return cell
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    var PlantNames = [String]() // plant names
    var Memberships = [String]()
    var GrowthLevels = [Float]()
    var PlantTypes = [String]()
    var LastWateredDate = [String]()
    func initializeTable(){
        tableView.dataSource = self
        tableView.allowsSelection = true
        //CoreDataUtils.shared.deleteAllPlants()
        print(CoreDataUtils.shared.returnPlantList()!)
        //print("ran initialize table")
        // runs when the app launches
        
        var groupList: [String] = CoreDataUtils.shared.returnGroupList() ?? ["Default"] // Contains list of every group taken from storage
        
        // Iterate through list of all plants, calling addPlant on them
        for plant in CoreDataUtils.shared.returnPlantList()! {
            var attributes = CoreDataUtils.shared.returnPlantAttributes(plantName: plant)!
            var (group, growthLevel, plantID, plantType, rfidReturn) = attributes
            addPlant(plant, plantType, group, growthLevel)
        }

        
    }
}
