//
//  OSCAClassRequestResource+OSCAPoiCategory.swift
//  OSCAMap
//
//  Created by Stephan Breidenbach on 02.03.22.
//

import Foundation
import OSCANetworkService

extension OSCAClassRequestResource {
  /// `ClassReqestRessource` for poi category data
  ///
  ///```console
  /// curl -vX GET \
  /// -H "X-Parse-Application-Id: ApplicationId" \
  /// -H "X-PARSE-CLIENT-KEY: ClientKey" \
  /// -H 'Content-Type: application/json' \
  /// 'https://parse-dev.solingen.de/classes/POICategory'
  ///  ```
  /// - Parameters:
  ///   - baseURL: The base url of your parse-server
  ///   - headers: The authentication headers for parse-server
  ///   - query: HTTP query parameters for the request
  /// - Returns: A ready to use `OSCAClassRequestResource`
  static func poiCategory(baseURL: URL, headers: [String: CustomStringConvertible], query: [String: CustomStringConvertible] = [:]) -> OSCAClassRequestResource {
    let parseClass = OSCAPoiCategory.parseClassName
    return OSCAClassRequestResource(baseURL: baseURL, parseClass: parseClass, parameters: query, headers: headers)
  }// end static func poiCategory
}// end extension public struct OSCAClassRequestResource
