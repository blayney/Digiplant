//
//  GlobalViewController.swift
//  Digiplant2
//
//  Created by Hugh Blayney on 31/05/2020.
//  Copyright © 2020 Will Blayney. All rights reserved.
//

import UIKit

class GlobalViewController: UIViewController {
    
    var commonName:String = ""
    var searchQuery:String = ""
    
    func percentageEncode(input:String) -> String {
        return input.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        commonName = mainInstance.name
        searchQuery = percentageEncode(input: commonName)
        
        // Based on code from https://learnappmaking.com/urlsession-swift-networking-how-to/
        
        
        
        let session = URLSession.shared
        let url = URL(string: "https://plantsdb.xyz/search?Common_Name=" + searchQuery)!

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
