//
//  CatImage.swift
//  catscute
//
//  Created by Luthfi Abdurrahim on 21/02/23.
//

import ObjectMapper

struct CatImage: Identifiable, Mappable {
    var id: String?
    var url: String?
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        url <- map["url"]
    }
}
