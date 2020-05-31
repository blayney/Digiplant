//
//  SettingsViewController.swift
//  Digiplant2
//
//  Created by Hugh Blayney on 31/05/2020.
//  Copyright © 2020 Will Blayney. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return.lightContent
        
    }
    var groupNameStr: String = ""

    @IBOutlet weak var groupName: UITextField!
    @IBAction func groupAddButton(_ sender: Any) {
        groupNameStr = groupName.text!
        
        if groupNameStr == "" {
            groupNameStr = "Default"
        }
        
        guard let newGroup = CoreDataUtils.shared.saveGroup(name: groupNameStr) else { return }
    }
    
    @IBAction func LinkSearchFunction(_ sender: Any) {
        // Call function from CoreDataUtils
        CoreDataUtils.shared.linkCSVToCore()
    }
    
    @IBOutlet weak var SearchBox: UITextField!
    var searchTerm: String = ""
    @IBAction func SearchButton(_ sender: Any) {
        searchTerm = SearchBox.text!
        print(CoreDataUtils.shared.searchNameString(searchTerm: searchTerm))
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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
