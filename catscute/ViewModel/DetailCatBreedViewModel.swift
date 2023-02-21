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
    
    func loadImages(for breedId: String) async throws {
        images = try await catService.fetchImages(for: breedId)
    }
}
