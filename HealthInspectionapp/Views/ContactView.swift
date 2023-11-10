//
// ContactView.swift : Parks
//
// Copyright © 2023 Auburn University.
// All Rights Reserved.


import SwiftUI

struct ContactView: View {
    
    var icon : String
    var contact : String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
            Text(contact)
        }
        .padding()
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(.blue, lineWidth: 2)
        }
        
    }
}

struct ContactView_Previews: PreviewProvider {
    static var previews: some View {
        ContactView(icon: "phone", contact: "123")
    }
}
