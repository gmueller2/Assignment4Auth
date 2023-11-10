//
//  PreviousView.swift
//  HealthInspectionapp
//
//  Created by Gene Mueller on 11/6/23.
//

import SwiftUI

struct PreviousView: View {
    @ObservedObject var restaurantvm = RestaurantViewModel()

    var body: some View {
        NavigationStack {
            List {
                ForEach(restaurantvm.previousData) { restaurant in
                    NavigationLink {
                        RestaurantDetail(restaurant: restaurant)
                    } label: {
                        HStack {
                            Text(restaurant.name!)
                            Spacer()
                            Text(restaurant.inspection_score ?? "0")
                                .foregroundColor(restaurantvm.colorScore(restaurant.inspection_score ?? "0"))
                        }
                    }
                }
                
            }
            .task {
                await restaurantvm.fetchData()
            }
            .listStyle(.grouped)
            .alert(isPresented: $restaurantvm.hasError, error: restaurantvm.error) {
                Text("")
            }
        }
    }
}

struct PreviousView_Previews: PreviewProvider {
    static var previews: some View {
        PreviousView()
    }
}
