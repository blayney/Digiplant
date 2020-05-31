//
//  DetailsViewController.swift
//  Digiplant2
//
//  Created by Will Blayney on 31/05/2020.
//  Copyright © 2020 Will Blayney. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    var NewPlantNameLocal: String = "Null"
    var NewPlantTypeLocal: String = "Debug"
    var NewGroupLocal: String = "Debug"
    var NewGrowthLevelLocal: Float = 0.00
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        DrawContent(NewPlantName: NewPlantNameLocal, NewPlantType: NewPlantTypeLocal, NewGroup: NewGroupLocal, NewGrowthLevel: NewGrowthLevelLocal)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return.lightContent
        
    }
    
    @IBOutlet weak var PlantName: UILabel!
    @IBOutlet weak var PlantType: UILabel!
    @IBOutlet weak var GrowthLevel: UILabel!
    @IBOutlet weak var Group: UILabel!
    
    func DrawContent(NewPlantName: String, NewPlantType: String, NewGroup: String, NewGrowthLevel: Float){
        PlantName.text = NewPlantName
        PlantType.text = NewPlantType
        GrowthLevel.text = String(NewGrowthLevel)
        Group.text = NewGroup
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
