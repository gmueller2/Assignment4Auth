//
// ParksViewModel.swift : Parks
//
// Copyright © 2023 Auburn University.
// All Rights Reserved.


import Foundation
import SwiftUI // for the color changer function

class RestaurantViewModel : ObservableObject {
    
    @Published private(set) var restaurantData = [RestaurantModel]()
    @Published private(set) var previousData = [RestaurantModel]()
    @Published var hasError = false
    @Published var error : RestaurantModelError?
    private let url = "https://data.kingcounty.gov/resource/f29f-zza5.json?$limit=20000&$$app_token=t4hiiJhHBTfM4aNmWnwZXKW8A"
    
    @MainActor
    func fetchData() async {
        
        if let url = URL(string: url) {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                guard let results = try JSONDecoder().decode([RestaurantModel]?.self, from: data) else {
                    self.hasError.toggle()
                    self.error = RestaurantModelError.decodeError
                    return
                }
                
                let outputDict = await createDict(results: results)
                let latestEntries = await findLatest(rDict: outputDict)
                let previousEntries = await findPrevious(rDict: outputDict)

                self.restaurantData = latestEntries
                self.previousData = previousEntries
            } catch {
                self.hasError.toggle()
                print(error)
                self.error = RestaurantModelError.customError(error: error)
            }
        }
        
    }
    
    @MainActor
    func createDict(results: [RestaurantModel]) async -> [String: [RestaurantModel]]{
        var rDict = [String : [RestaurantModel]]()
        for restaurant in results { // for each restaurant object in the list provided
            
            if rDict[restaurant.business_id!] != nil { // if the object is not in the dictionary
                rDict[restaurant.business_id!]!.append(restaurant) // then add it
            } else { // otherwise
                rDict[restaurant.business_id!] = [restaurant] // add the object is if IS nil
            }
        }
        return rDict
    }
    
    @MainActor
    func findLatest(rDict: [String: [RestaurantModel]]) async -> [RestaurantModel] {
        var latestEntries : [RestaurantModel] = []
        
        for (_, entries) in rDict {
            if let latestEntry = entries.max(by: {$0.inspection_date! < $1.inspection_date!}) {
                latestEntries.append(latestEntry)
            }
        }
        return latestEntries
        
    }
    
    @MainActor
    func findPrevious(rDict: [String: [RestaurantModel]]) async -> [RestaurantModel] {
        var previousEntries: [RestaurantModel] = []
        
        for (_, entries) in rDict {
            // sort all entries in descending order
            let sortedEntries = entries.sorted(by: {$0.inspection_date! > $1.inspection_date!})
            
            // drop the first element, append all others
            let allButLatest = Array(sortedEntries.dropFirst())
            previousEntries.append(contentsOf: allButLatest)
        }
        return previousEntries
    }

    @MainActor
    func colorScore(_ value: String) -> Color {
        // convert value to integer
        let value = Int(value)
        var scoreColor : Color
        
        // check for nils
        
        if value == nil {
            return Color.black
        }
        
        // get the color gradients
        
        if value! >= 500 {
            scoreColor = Color.red
        } else if value! >= 200 {
            scoreColor = Color.orange
        } else {
            scoreColor = Color.green
        }
        
        return scoreColor
    }
}

extension RestaurantViewModel {
    enum RestaurantModelError : LocalizedError {
        case decodeError
        case customError(error: Error)
        
        var errorDescription: String? {
            switch self {
            case .decodeError:
                return "Decoding Error"
            case .customError(let error):
                return error.localizedDescription
            }
        }
        
    }

}
