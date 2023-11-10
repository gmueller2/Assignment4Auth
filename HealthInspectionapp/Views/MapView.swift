//
// MapView.swift : Parks
//
// Copyright © 2023 Auburn University.
// All Rights Reserved.


import SwiftUI
import MapKit

struct MapView: View {
     
    var coordinate : CLLocationCoordinate2D
    
    var body: some View {
        Map(coordinateRegion: .constant(MKCoordinateRegion(center: coordinate, latitudinalMeters: 750, longitudinalMeters: 750)))
    }
}
