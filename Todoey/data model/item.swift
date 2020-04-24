//
//  item.swift
//  Todoey
//
//  Created by Nitin Birdi on 24/04/20.
//  Copyright © 2020. All rights reserved.
//

import Foundation


class Item: Encodable  {
    var title: String = ""
    var done: Bool = false
}
