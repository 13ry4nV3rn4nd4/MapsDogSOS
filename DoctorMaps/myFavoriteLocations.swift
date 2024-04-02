//
//  myFavoriteLocations.swift
//  DoctorMaps
//
//  Created by Bryan Vernanda on 02/04/24.
//

import Foundation
import MapKit

struct MyFavoriteLocation: Identifiable, Equatable {
    var id = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
    static func == (lhs: MyFavoriteLocation, rhs: MyFavoriteLocation) -> Bool {
        return lhs.id == rhs.id
    }
}
