//
//  OSCABundleRequestResource+OSCAPoiCategory.swift
//  OSCAMap
//
//  Created by Stephan Breidenbach on 26.03.22.
//

import Foundation
import OSCANetworkService

extension OSCABundleRequestResource {
  /// `BundleRequestResource` for poi data
  /// - Parameters:
  ///   - bundle: bundle in which the JSON-file is bundled
  ///   - fileName: JSON-file name with postfix
  /// - Returns: A ready to use `OSCABundleRequestResource`
  static func poiCategory(bundle: Bundle,
                          fileName: String) -> OSCABundleRequestResource {
    return OSCABundleRequestResource(bundle:bundle,
                                                      fileName: fileName)
  }// end static func poiCategory
}// end extension public struct OSCABundleRequestResource
