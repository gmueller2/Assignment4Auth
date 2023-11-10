//
// ContentView.swift : Parks
//
// Copyright © 2023 Auburn University.
// All Rights Reserved.


import SwiftUI

struct Restaurant: View {
    
    @ObservedObject var restaurantvm = RestaurantViewModel()

    var body: some View {
        NavigationStack {
            List {
                ForEach(restaurantvm.restaurantData) { restaurant in
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
            .navigationTitle("Health Inspections")
            .alert(isPresented: $restaurantvm.hasError, error: restaurantvm.error) {
                Text("")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Restaurant()
    }
}
