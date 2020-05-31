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
