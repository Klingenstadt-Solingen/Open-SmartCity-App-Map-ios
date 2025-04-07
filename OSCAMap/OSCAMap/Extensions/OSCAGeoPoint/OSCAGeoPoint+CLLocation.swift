//
//  OSCAGeoPoint+CLLocation.swift
//  OSCAMap
//
//  Created by Stephan Breidenbach on 04.03.24.
//

import Foundation
import OSCAEssentials
import CoreLocation

extension OSCAGeoPoint {
  public init?(latString: String?,
               lonString: String?) {
    guard let latString = latString,
          let latitude = Double(latString),
          let lonString = lonString,
          let longitude = Double(lonString) else { return nil }
    
    self = .init(latitude: latitude,
                 longitude: longitude)
  }// end public init from string
  
  public init?(clLocation: CLLocation?) {
    guard let clLocation = clLocation else { return nil }
    self = .init(clLocation)
  }// end public init from cllocation
}// end extension OSCAGeoPoint
