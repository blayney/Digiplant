//
//  LocalViewController.swift
//  Digiplant2
//
//  Created by Hugh Blayney on 31/05/2020.
//  Copyright © 2020 Will Blayney. All rights reserved.
//

import UIKit

class LocalViewController: UIViewController{
    
    var testString:String = ""

    @IBOutlet weak var plantName: UILabel!
    @IBOutlet weak var plantType: UILabel!
    @IBOutlet weak var growth: UILabel!
    @IBOutlet weak var group: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(mainInstance.name)
        plantName.text = mainInstance.name
        plantType.text = mainInstance.type
        growth.text = String(mainInstance.growth)
        group.text = mainInstance.group
        // Do any additional setutestStringp after loading the view.
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
