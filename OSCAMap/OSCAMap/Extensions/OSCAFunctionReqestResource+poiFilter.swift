//
//  OSCAFunctionReqestResource+poiFilter.swift
//  OSCAMap
//
//  Created by Stephan Breidenbach on 09.08.22.
//

import Foundation
import OSCANetworkService

extension OSCAFunctionRequestResource {
  public static func poiFilter(baseURL: URL,
                               headers: [String: CustomStringConvertible],
                               cloudFunctionParameter: OSCAPoiCategory.FilterFieldQueryParameter) -> OSCAFunctionRequestResource<OSCAPoiCategory.FilterFieldQueryParameter> {
    let cloudFunctionName = "poi-filter"
    return OSCAFunctionRequestResource<OSCAPoiCategory.FilterFieldQueryParameter>(baseURL: baseURL, cloudFunctionName: cloudFunctionName, cloudFunctionParameter: cloudFunctionParameter, headers: headers)
  }// end public static func poiFilter
}// end extension public struct OSCAFunctionRequestResource

