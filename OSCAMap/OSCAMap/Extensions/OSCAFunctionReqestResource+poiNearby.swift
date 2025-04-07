//
//  OSCAFunctionReqestResource+poiNearby.swift
//  OSCAMap
//
//  Created by Mammut Nithammer on 25.08.22.
//

import Foundation
import OSCANetworkService

extension OSCAFunctionRequestResource {
  public static func poiNearby(baseURL: URL,
                               headers: [String: CustomStringConvertible],
                               cloudFunctionParameter: OSCAPoi.NearbyQueryParameter) -> OSCAFunctionRequestResource<OSCAPoi.NearbyQueryParameter> {
    let cloudFunctionName = "poi-nearby"
    return OSCAFunctionRequestResource<OSCAPoi.NearbyQueryParameter>(baseURL: baseURL, cloudFunctionName: cloudFunctionName, cloudFunctionParameter: cloudFunctionParameter, headers: headers)
  } // end public static func poiNearby
} // end extension public struct OSCAFunctionRequestResource
