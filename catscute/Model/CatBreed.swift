//
//  CatBreed.swift
//  catscute
//
//  Created by Luthfi Abdurrahim on 21/02/23.
//

import ObjectMapper

struct CatBreed: Mappable, Identifiable {
    var id: String?
    var name: String?
    var description: String?
    var origin: String?
    var temperament: String?
    var lifeSpan: String?
    var adaptability: Int?
    var affectionLevel: Int?
    var childFriendly: Int?
    var grooming: Int?
    var intelligence: Int?
    var healthIssues: Int?
    var socialNeeds: Int?
    var strangerFriendly: Int?
    var imageUrl: String?
    
    init?(map: Map) {}
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        description <- map["description"]
        origin <- map["origin"]
        temperament <- map["temperament"]
        lifeSpan <- map["life_span"]
        adaptability <- map["adaptability"]
        affectionLevel <- map["affection_level"]
        childFriendly <- map["child_friendly"]
        grooming <- map["grooming"]
        intelligence <- map["intelligence"]
        healthIssues <- map["health_issues"]
        socialNeeds <- map["social_needs"]
        strangerFriendly <- map["stranger_friendly"]
        imageUrl <- map["image.url"]
    }
}
