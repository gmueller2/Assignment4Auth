//
//  ScoreView.swift
//  Assignment3
//
//  Created by Gene Mueller on 10/31/23.
//

import SwiftUI

struct ScoreView: View {
    
    @ObservedObject var restaurantvm = RestaurantViewModel()
    var icon : String
    var score : String
    
    var body: some View {
        let scoreColor : Color = restaurantvm.colorScore(score)
        HStack {
            Image(systemName: icon)
                .foregroundColor(scoreColor)
            Text(score)
                .foregroundColor(scoreColor)
        }
        .padding()
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(scoreColor, lineWidth: 2)
        }
        
    }
}

struct ScoreView_Previews: PreviewProvider {
    
    static var previews: some View {
        ScoreView(icon: "pill.circle", score: "50")
    }
}
