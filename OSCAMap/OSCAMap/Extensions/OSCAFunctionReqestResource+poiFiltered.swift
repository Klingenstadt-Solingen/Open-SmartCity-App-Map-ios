//
//  OSCAFunctionReqestResource+poiFiltered.swift
//  OSCAMap
//
//  Created by Stephan Breidenbach on 10.08.22.
//

import Foundation
import OSCANetworkService

extension OSCAFunctionRequestResource {
  public static func poiFiltered (baseURL: URL,
                                  headers: [String: CustomStringConvertible],
                                  cloudFunctionParameter: OSCAPoiCategory.FilterFieldQueryParameter) -> OSCAFunctionRequestResource<OSCAPoiCategory.FilterFieldQueryParameter> {
    let cloudFunctionName = "poi-filtered"
    return OSCAFunctionRequestResource<OSCAPoiCategory.FilterFieldQueryParameter>(baseURL: baseURL, cloudFunctionName: cloudFunctionName, cloudFunctionParameter: cloudFunctionParameter, headers: headers)
  }// end public static func poiFiltered
}// end extension public struct OSCAFunctionRequestResource
