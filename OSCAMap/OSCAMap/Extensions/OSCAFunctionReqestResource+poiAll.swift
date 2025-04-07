//
//  OSCAFunctionReqestResource+poiAll.swift
//  OSCAMap
//
//  Created by Mammut Nithammer on 23.08.22.
//

import Foundation
import OSCANetworkService

extension OSCAFunctionRequestResource {
  public static func poiAll(baseURL: URL,
                            headers: [String: CustomStringConvertible],
                            cloudFunctionParameter: OSCAPoi.CacheQueryParameter) -> OSCAFunctionRequestResource<OSCAPoi.CacheQueryParameter> {
    let cloudFunctionName = "poi-all"
    return OSCAFunctionRequestResource<OSCAPoi.CacheQueryParameter>(baseURL: baseURL, cloudFunctionName: cloudFunctionName, cloudFunctionParameter: cloudFunctionParameter, headers: headers)
  } // end public static func poiFiltered
} // end extension public struct OSCAFunctionRequestResource
