//
//  OSCAImageFileDataRequestResource+SymbolImageData.swift
//  OSCAMap
//
//  Created by Stephan Breidenbach on 04.04.22.
//

import Foundation
import OSCANetworkService

extension OSCAImageDataRequestResource {
  static func symbolImageData(poiCategory: OSCAPoiCategory) -> OSCAImageDataRequestResource<OSCAPoiCategory.SymbolImageData>? {
    guard let objectId: String = poiCategory.objectId,
          !objectId.isEmpty,
          let symbolName: String = poiCategory.symbolName,
          !symbolName.isEmpty,
          let symbolPath: String = poiCategory.symbolPath,
          let symbolURL: URL = URL(string: symbolPath),
          let symbolMimeType: String = poiCategory.symbolMimetype else { return nil }
    return OSCAImageDataRequestResource<OSCAPoiCategory.SymbolImageData>(
      objectId: objectId,
      baseURL: symbolURL,
      fileName: symbolName,
      mimeType: symbolMimeType)
  }// end static func symbolImageData
}// end extension public struct OSCAImageDataRequestResource
