//
//  ApiService.swift
//  catscute
//
//  Created by Luthfi Abdurrahim on 21/02/23.
//

import SwiftUI
import ObjectMapper

class ApiService {
    private let breedsUrl = "https://api.thecatapi.com/v1/breeds/"
    private let imagesUrl = "https://api.thecatapi.com/v1/images/search"
    
    private let apiKey = "live_IonPMgxfSo2U4t50Zr5HtpR8bA2wBTVu7Ks5koGxvaryZDx0DoZ0s4cxR71MwQPA"
    
    func fetchBreeds() async throws -> [CatBreed] {
        let url = URL(string: breedsUrl)!
        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "x-api-key")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NSError(domain: "Invalid response", code: 0, userInfo: nil)
        }
        
        let breeds = Mapper<CatBreed>().mapArray(JSONObject: try JSONSerialization.jsonObject(with: data))
        return breeds ?? []
    }
    
    func fetchImages(for breedId: String) async throws -> [CatImage] {
        let url = URL(string: imagesUrl)!
        let parameters = ["limit": "10", "breed_ids": breedId]
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        urlComponents.queryItems = parameters.map { key, value in URLQueryItem(name: key, value: value) }
        var request = URLRequest(url: urlComponents.url!)
        request.setValue(apiKey, forHTTPHeaderField: "x-api-key")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NSError(domain: "Invalid response", code: 0, userInfo: nil)
        }
        
        let images = Mapper<CatImage>().mapArray(JSONObject: try JSONSerialization.jsonObject(with: data))
        return images ?? []
    }
}

