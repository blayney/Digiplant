//
//  AddPlantViewController.swift
//  Digiplant2
//
//  Created by Will Blayney on 30/05/2020.
//  Copyright © 2020 Will Blayney. All rights reserved.
//

import UIKit

class AddPlantViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    var plantGroupArray = CoreDataUtils.shared.returnGroupList() ?? ["Default"]


    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var growthSlider: UISlider!
    @IBOutlet weak var groupPicker: UIPickerView!
    // added comment
    var RFIDReturn: String = "0"
    var PlantName: String = "DefaultName"
    var PlantType: String = "Default Plant Type"
    var GrowthLevel: Float = 0.0
    var Group: String = "Debug"
    var PlantID: String = "10230"
    
    
    @IBAction func confirmButton(_ sender: UIButton) {
        PlantName = nameField.text!
        
        if PlantName == "" {
            PlantName = "No Name"
        }
        
        GrowthLevel = growthSlider.value
        
        Group = plantGroupArray[groupPicker.selectedRow(inComponent: 0)]
        
        // print(PlantName)
        // print(GrowthLevel)
        // print(Group)
        
        // Write the values for this plant into the Core Data
        guard let newPlant = CoreDataUtils.shared.savePlant(name: PlantName, plantType: PlantType, plantID: PlantID, growthLevel: GrowthLevel, group: Group, rfidReturn: RFIDReturn) else { return }
        
        // print(CoreDataUtils.shared.testReturnPlants())
        
        

        // Close the add plant screen

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier != "SetTypeTransfer"{
        let destVC = segue.destination as! ViewController
            destVC.addPlant(PlantName, PlantType, Group, GrowthLevel)
            
        }
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // TRIGGERS RFID SEQUENCE AND SETS RFIDRETURN TO UID FROM RFID CLASS
        
        self.groupPicker.delegate = self
        self.groupPicker.dataSource = self
        self.groupPicker.setValue(UIColor.white, forKey: "TextColor")
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return plantGroupArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return plantGroupArray[row]
    }
    
    @IBAction func UnwindToTwo(_ sender: UIStoryboardSegue){
        
        
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
