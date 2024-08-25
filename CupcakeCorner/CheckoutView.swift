//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Naveed on 25/08/2024.
//

import Foundation
import SwiftUI

struct CheckoutView: View {
    var order: Order
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                        image
                            .resizable()
                            .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)

                Text("Your total is \(order.cost, format: .currency(code: "USD"))")
                    .font(.title)

                Button("Place Order", action: {
                    Task {
                        await placeOrder()
                    }
                })
                    .padding()
            }
        }
        .navigationTitle("Check out")
        .alert("Thank you!", isPresented: $showingConfirmation) {
            Button("OK") { }
        } message: {
            Text(confirmationMessage)
        }
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
    }
    
    func placeOrder() async {
        // Encode the Object to JSON
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }
        // Create URL & URL Request
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        // Make API Request Using Data & URL Request
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            // We recive the data we sent in JSON Form We need to Decode that data
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
            showingConfirmation = true
        } catch {
            print("Checkout failed: \(error.localizedDescription)")
        }
    }
}

#Preview {
    CheckoutView(order: Order())
}
