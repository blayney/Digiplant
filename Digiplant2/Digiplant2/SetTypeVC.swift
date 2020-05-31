//
//  SetTypeVC.swift
//  Digiplant2
//
//  Created by Will Blayney on 31/05/2020.
//  Copyright © 2020 Will Blayney. All rights reserved.
//

import UIKit

class SetTypeVC: UIViewController {
    
    var SearchResults = [String]()

    @IBOutlet weak var SearchField: UITextField!
    var searchTerm: String = ""
    @IBAction func SearchButton(_ sender: UIButton) {
        searchTerm = SearchField.text!
        SearchResults = CoreDataUtils.shared.searchNameString(searchTerm: searchTerm) ?? []
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
