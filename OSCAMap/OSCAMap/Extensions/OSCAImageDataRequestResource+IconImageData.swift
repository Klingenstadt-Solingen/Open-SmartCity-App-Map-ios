//
//  OSCAImageFileDataRequestResource+IconImageData.swift
//  OSCAMap
//
//  Created by Stephan Breidenbach on 04.04.22.
//

import Foundation
import OSCAEssentials
import OSCANetworkService

extension OSCAImageDataRequestResource {
  static func iconImageData(poiCategory: OSCAPoiCategory) -> OSCAImageDataRequestResource<OSCAPoiCategory.IconImageData>? {
    guard let objectId: String = poiCategory.objectId,
          !objectId.isEmpty,
          let iconName: String = poiCategory.iconName,
          !iconName.isEmpty,
          let iconPath: String = poiCategory.iconPath,
          let iconURL: URL = URL(string: iconPath),
          let iconMimeType: String = poiCategory.iconMimetype else { return nil }
    return OSCAImageDataRequestResource<OSCAPoiCategory.IconImageData>(
      objectId: objectId,
      baseURL: iconURL,
      fileName: iconName,
      mimeType: iconMimeType)
  }// end static func iconImageData
}// end extension public struct OSCAImageDataRequestResource

