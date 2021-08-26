//
//  BusinessSearch.swift
//  CitySights
//
//  Created by Shrikanta Mazumder on 25/8/21.
//

import Foundation

struct BusinessSearch: Decodable {
    var businesses = [Business]()
    var total = 0
    var region = Region()
}

struct Region: Decodable {
    var center = Coordinate()
}


