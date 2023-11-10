//
// ParkDetail.swift : Restaurant
//
// Copyright © 2023 Auburn University.
// All Rights Reserved.


import SwiftUI
import MapKit

struct RestaurantDetail: View {
    
    var restaurant : RestaurantModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text(restaurant.name!)
                    .font(.system(size: 20))
                    .padding(.horizontal)
                Text(restaurant.city!)
                    .padding(.horizontal)
                MapView(coordinate: CLLocationCoordinate2D(latitude: Double(restaurant.latitude!)!, longitude: Double(restaurant.longitude!)!))
                    .frame(height: 300)
                HStack {
                    ContactView(icon: "phone", contact: restaurant.phone!)
                        .padding(.horizontal)
                    Spacer()
                    ScoreView(icon: "pill.circle", score: restaurant.inspection_score!)
                        .padding(.horizontal)
                }
            }
        }
    }
}
