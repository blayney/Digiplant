//
//  AddPlantViewController.swift
//  Digiplant2
//
//  Created by Will Blayney on 30/05/2020.
//  Copyright © 2020 Will Blayney. All rights reserved.
//

import UIKit

class AddPlantViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var plantGroupDict = ["Patio": ["Plant 1", "Plant 2"],
                          "Lawn": ["Plant 3]"]]
    

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var growthSlider: UISlider!
    @IBOutlet weak var groupPicker: UIPickerView!
    
    var RFIDReturn: String = "0"
    var PlantName: String = ""
    var PlantType: String = "Default Plant Type"
    var GrowthLevel: Float = 0.0
    var Group: String = ""
    var PlantID: Int = 10230
    
    @IBAction func confirmButton(_ sender: UIButton) {
        PlantName = nameField.text!
        if PlantName == "" {
            PlantName = "No Name"
        }
        
        GrowthLevel = growthSlider.value
        
        Group = Array(plantGroupDict.keys)[groupPicker.selectedRow(inComponent: 0)]
        
        print(PlantName)
        print(GrowthLevel)
        print(Group)
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // TRIGGERS RFID SEQUENCE AND SETS RFIDRETURN TO UID FROM RFID CLASS
        
        self.groupPicker.delegate = self
        self.groupPicker.dataSource = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Array(plantGroupDict.keys).count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Array(plantGroupDict.keys)[row]
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
