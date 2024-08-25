//
//  DisableFormExample.swift
//  CupcakeCorner
//
//  Created by Naveed on 25/08/2024.
//

import Foundation
import SwiftUI

struct FormExample: View {
    @State private var name = ""
    
    var disableForm: Bool {
        name.count < 5
    }
    
    var body: some View{
        
        Form{
            TextField("User name", text: $name)
            
            Section {
                Button("Create account") {
                       print("Creating account…")
                   }
            }
            .disabled(disableForm)
        }

    }
}

#Preview {
    FormExample()
}
