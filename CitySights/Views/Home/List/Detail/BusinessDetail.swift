//
//  BusinessDetail.swift
//  CitySights
//
//  Created by Shrikanta Mazumder on 28/8/21.
//

import SwiftUI

struct BusinessDetail: View {
    var business: Business
    @State private var showDirection = false
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 0) {
                GeometryReader() { geometry in
                    // Business image
                    let uiImage = UIImage(data: business.imageData ?? Data())
                    Image(uiImage: uiImage ?? UIImage())
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipped()
                }
                .ignoresSafeArea(.all, edges: .top)
                
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(height: 36)
                        .foregroundColor(business.isClosed! ? .gray : .blue)
                    Text(business.isClosed! ? "Closed" : "Open")
                        .bold()
                        .foregroundColor(.white)
                        .padding(.leading)
                }
            }
                
            Group {
                // Business title
                BusinessTitle(business: business)
                    .padding()
                Divider()
                
                // Phone
                if let phone = business.displayPhone {
                    HStack {
                        Text("Phone")
                        Text(phone)
                        Spacer()
                        Link("Call", destination: URL(string: "tel:\(business.phone ?? "")")!)
                    }
                    .padding()
                }
                
                Divider()
                
                // Reviews
                    HStack {
                        Text("Reviews:")
                        Text("\(business.reviewCount ?? 0)")
                        Spacer()
                        Link("Read", destination: URL(string: "\(business.url ?? "")")!)
                    }
                    .padding()
                
                Divider()
                
                // Website
                HStack {
                    Text("Website:")
                        
                    Text(business.url ?? "")
                        .lineLimit(1)
                    Spacer()
                    Link("Visit", destination: URL(string: "\(business.url ?? "")")!)
                }
                .padding()
                
                Divider()
        }
            
            // Get direction button
            Button(action: {
                self.showDirection = true
            }, label: {
                ZStack {
                    Rectangle()
                        .frame(height: 48)
                        .foregroundColor(.blue)
                        .cornerRadius(10)
                    
                    Text("Get Direction")
                        .foregroundColor(.white)
                        .bold()
                }
            })
            .padding()
            .sheet(isPresented: $showDirection, content: {
                DirectionsView(business: business)
            })
        }
    }
}
