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
    
    // Just a debugging tool to output from the API
    @IBOutlet weak var APILabel: UILabel!
    
    
    func DrawContent(NewPlantName: String, NewPlantType: String, NewGroup: String, NewGrowthLevel: Float){
        PlantName.text = NewPlantName
        PlantType.text = NewPlantType
        GrowthLevel.text = String(NewGrowthLevel)
        Group.text = NewGroup
        
        // Based on code from https://learnappmaking.com/urlsession-swift-networking-how-to/
        
        let session = URLSession.shared
        let url = URL(string: "https://plantsdb.xyz/search/Genus=Pinus")!

        let task = session.dataTask(with: url) { data, response, error in

            if error != nil || data == nil {
                print("Client error!")
                return
            }

            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error!")
                return
            } //abietinella moss

            guard let mime = response.mimeType, mime == "application/json" else {
                print("Wrong MIME type!")
                return
            }

            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                print(json)
            } catch {
                print("JSON error: \(error.localizedDescription)")
            }
        }

        task.resume()
        
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
