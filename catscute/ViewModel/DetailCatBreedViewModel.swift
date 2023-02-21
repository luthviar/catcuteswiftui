//
//  DetailCatBreedViewModel.swift
//  catscute
//
//  Created by Luthfi Abdurrahim on 21/02/23.
//

import SwiftUI

@MainActor class DetailCatBreedViewModel: ObservableObject {
    private let catService = ApiService()
    
    @Published private(set) var images: [CatImage] = []
    @Published private(set) var breedName: String = ""
    
    func loadImages(for breedId: String) async throws {
        let breeds = try await catService.fetchBreeds().filter { $0.id == breedId }
        guard let breed = breeds.first else { return }
        breedName = breed.name ?? ""
        images = try await catService.fetchImages(for: breedId)
    }
}
