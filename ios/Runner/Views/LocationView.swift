//
//  LocationView.swift
//  Runner
//
//  Created by Zachary on 13/7/24.
//

import SwiftUI

struct LocationView: View {
    @ObservedObject private var locationManager = LocationManager()
    
    var body: some View {
        VStack {
            if let location = locationManager.location {
                Text("Latitude: \(location.coordinate.latitude)")
                    .font(.title)
                Text("Longitude: \(location.coordinate.longitude)")
                    .font(.title)
            } else {
                Text("Fetching location...")
                    .font(.title)
            }
        }
        .padding()
    }
}


#Preview {
    LocationView()
}
