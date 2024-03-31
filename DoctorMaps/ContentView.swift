//
//  ContentView.swift
//  DoctorMaps
//
//  Created by Bryan Vernanda on 28/03/24.
//

import SwiftUI
import MapKit

extension CLLocationCoordinate2D {
    static let marker = CLLocationCoordinate2D(latitude: 37.33683, longitude: -122.01218)
    
}

struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct ContentView: View {
    
    @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)
    
    @State private var text = ""
    @State private var selectedLocationIndex = 0
    @State private var userTrackingMode: MapUserTrackingMode = .follow
    
    let locations: [Location] = [
            Location(name: "Location A", coordinate: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)),
            Location(name: "Location B", coordinate: CLLocationCoordinate2D(latitude: 37.7793, longitude: -122.4152)),
            Location(name: "Location C", coordinate: CLLocationCoordinate2D(latitude: 37.7739, longitude: -122.4312))
        ]
    
    var filteredLocations: [Location] {
        if text.isEmpty {
            return locations
        } else {
            return locations.filter { $0.name.lowercased().contains(text.lowercased()) }
        }
    }
    
    var body: some View{
        //IDK BRUH
//        VStack{
//            TextField("Enter an address", text: $text)
//                .textFieldStyle(.roundedBorder)
//                .padding(.horizontal)
//            
//            Button("Find address"){
//                mapAPI.getLocation(address: text, delta: 0.5)
//            }
//            
//            Map(coordinateRegion: $mapAPI.region, annotationItems: mapAPI.locations){
//                location in MapMarker(coordinate: |, tint: Color?)
//            }
//        }
        
    //SEARCH BAR
        VStack {
                    TextField("Search", text: $text)
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal)
            
            Map(coordinateRegion: .constant(MKCoordinateRegion(center: locations.first?.coordinate ?? CLLocationCoordinate2D(), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))), annotationItems: filteredLocations) { location in
                            MapMarker(coordinate: location.coordinate, tint: .blue)
                        }
                        .onAppear {
                            // Request location authorization
                            CLLocationManager().requestWhenInUseAuthorization()
                        }
                        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                            // Update user tracking mode when app enters foreground
                            userTrackingMode = .follow
                        }
                        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                            // Update user tracking mode when app resigns active
                            userTrackingMode = .none
                        }
                    
                }
        
        //MAPS ONLY WITH PINS/MARKER UPDATED IOS 17 BUT STILL NOT FUNCTIONAL IDK WHY
//        Map(position: $position){
//            UserAnnotation(){
//                ZStack {
//                    Circle()
//                        .frame(width: 32, height: 32)
//                        .foregroundStyle(.blue.opacity(0.25))
//                    Circle()
//                        .frame(width: 20, height: 20)
//                        .foregroundStyle(.white)
//                    Circle()
//                        .frame(width: 12, height: 12)
//                        .foregroundStyle(.blue)
//                }
//            }
//            Marker("TestNgepin123", coordinate: .marker)
//        }
//        .mapControls{
//            MapUserLocationButton()
//            MapPitchToggle()
//            MapCompass()
//        }
//        .onAppear{
//            CLLocationManager().requestWhenInUseAuthorization()
//        }
        
    }
}

#Preview {
    ContentView()
}
