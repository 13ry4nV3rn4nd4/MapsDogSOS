//
//  LookAround.swift
//  DoctorMaps
//
//  Created by Bryan Vernanda on 02/04/24.
//

import SwiftUI
import MapKit

struct LookAround: View {
    
    @State private var lookAroundScene: MKLookAroundScene?
    var selectedResult: MyFavoriteLocation
    
    var body: some View {
        LookAroundPreview(initialScene: lookAroundScene)
            .overlay(alignment: .bottomTrailing) {
                HStack {
                    Text("\(selectedResult.name)")
                }
                .font(.caption)
                .foregroundStyle(.white)
                .padding(18)
            }
            .onAppear {
                getLookAroundScene()
            }
            .onChange(of: selectedResult) {
                getLookAroundScene()
            }
    }
    
    func getLookAroundScene() {
        lookAroundScene = nil
        Task {
            let request = MKLookAroundSceneRequest(coordinate: selectedResult.coordinate)
            lookAroundScene = try? await request.scene
        }
    }
}

#Preview {
    LookAround(selectedResult: MyFavoriteLocation(name: "Location A", coordinate: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)))
}
