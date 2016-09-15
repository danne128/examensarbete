//
//  Group.swift
//  Test projekt
//
//  Created by Daniel Trondsen Wallin on 12/09/16.
//  Copyright © 2016 Daniel Trondsen Wallin. All rights reserved.
//

import Foundation
import Firebase

class Group {
    
    let group: String
    var key: String?
    
    init(group: String) {
        self.group = group
    }
    
    init(dataSnapshot: FIRDataSnapshot) {
        self.group = (dataSnapshot.value!["groupname"] as? String)!
        self.key = dataSnapshot.key
    }

}

