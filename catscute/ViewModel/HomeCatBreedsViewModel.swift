//
//  HomeCatBreedsViewModel.swift
//  catscute
//
//  Created by Luthfi Abdurrahim on 21/02/23.
//

import SwiftUI

@MainActor class HomeCatBreedsViewModel: ObservableObject {
    private let catService = ApiService()
    
    @Published private(set) var breeds: [CatBreed] = []
    
    func loadBreeds() async throws {
        breeds = try await catService.fetchBreeds()
            .sorted { ($0.name ?? "") < ($1.name ?? "") }            
            .sorted { ($0.id ?? "") < ($1.id ?? "") }
    }
}
