//
//  OSCAImageFileDataRequestResource+OSCAUrlData.swift
//  OSCAMap
//
//  Created by Stephan Breidenbach on 31.05.22.
//

import Foundation
import OSCAEssentials
import OSCANetworkService

extension OSCAUrlDataRequestResource {
  static func imageData(url: URL) -> OSCAUrlDataRequestResource? {
    return OSCAUrlDataRequestResource(url: url)
  }// end static func imageData from url
}// end extension public struct OSCAUrlDataRequestResource
