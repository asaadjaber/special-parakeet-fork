//
//  BirdsAPI.swift
//  Special Parakeet
//
//  Created by Asaad Jaber on 19/04/2024.
//

import Foundation
import Combine

struct Body: Decodable {
    var results: [BirdResult]
}

struct BirdResult: Decodable, Identifiable {
    var uuid: String
    var id: Int
    var speciesGuess: String?
    var taxon: Taxon
    
    enum CodingKeys: String, CodingKey {
        case uuid, id, taxon
        case speciesGuess = "species_guess"
    }
}

struct Taxon: Decodable {
    var isActive: Bool
    var defaultPhoto: DefaultPhoto
    
    enum CodingKeys: String, CodingKey {
        case isActive = "is_active"
        case defaultPhoto = "default_photo"
    }
}

struct DefaultPhoto: Decodable {
    var squareUrl: String
    var mediumUrl: String
    
    enum CodingKeys: String, CodingKey {
        case squareUrl = "square_url"
        case mediumUrl = "medium_url"

    }
}

class BirdsAPI: ObservableObject {
    static let url = URL(string: "https://api.inaturalist.org/v1/observations?iconic_taxa=Aves&per_page=50&order=desc&order_by=created_at")
    
    @Published var birdResults: [BirdResult] = []
    
    @MainActor
    func fetchObservations() async {
        do {
            let (data, _) = try await URLSession.shared.data(for: URLRequest(url: BirdsAPI.url!))
            let decoder = JSONDecoder()
            do {
                let body = try decoder.decode(Body.self, from: data)
                self.birdResults = body.results
            } catch {
                print("error decoding data,", error)
            }
        } catch {
            print("error fetching data,", error)
        }
    }
}
