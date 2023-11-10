//
// ParkModel.swift : Parks
//
// Copyright © 2023 Auburn University.
// All Rights Reserved.


import Foundation

struct RestaurantModel : Codable, Identifiable {
    var id : UUID {
        return UUID()
    }
    let name: String?
    let business_id: String?
    let inspection_date: String?
    let address: String?
    let city: String?
    let zip_code: String?
    let phone: String?
    let latitude: String?
    let longitude: String?
    let inspection_score: String?
}
