//
//  global.swift
//  Digiplant2
//
//  Created by Hugh Blayney on 31/05/2020.
//  Copyright © 2020 Will Blayney. All rights reserved.
//

import Foundation
class Main {
    var name:String = ""
    var type:String = ""
    var growth:Float = 0.0
    var group:String = ""
    
    init(name:String) {
        self.name=name
    }
}

var mainInstance = Main(name:"My Global Class")
