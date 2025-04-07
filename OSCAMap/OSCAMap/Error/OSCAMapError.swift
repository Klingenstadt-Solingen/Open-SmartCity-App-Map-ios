//
//  OSCAMapError.swift
//  OSCAMap
//
//  Created by Stephan Breidenbach on 02.03.22.
//

import Foundation

public enum OSCAMapError: Swift.Error, CustomStringConvertible {
  case networkInvalidRequest
  case networkInvalidResponse
  case networkDataLoading(statusCode: Int, data: Data)
  case networkJSONDecoding(error: Error)
  case networkIsInternetConnectionFailure
  case networkError
  case mapViewModelPOIsFetching
  case mapViewModelPOICategoriesFetching
  case mapViewModelImageDataFetching(url: URL)
  case mapViewModelFailToLocateUser(error: Error)
  case mapSearchResultsFetching
  
  public var description: String {
    switch self {
    case .networkInvalidRequest:
      return "There is a network Problem: invalid request!"
    case .networkInvalidResponse:
      return "There is a network Problem: invalid response!"
    case let .networkDataLoading(statusCode, data):
      return "There is a network Problem: data loading failed with status code \(statusCode): \(data)"
    case let .networkJSONDecoding(error):
#if DEBUG
      return "There is a network Problem: JSON decoding: \(error.localizedDescription)"
#endif
        return "There is a network Problem: JSON decoding"
    case .networkIsInternetConnectionFailure:
      return "There is a network Problem: Internet connection failure!"
    case .networkError:
      return "There is an unspecified network Problem!"
    case .mapViewModelPOICategoriesFetching:
      return "Error fetching POI categories!"
    case .mapViewModelPOIsFetching:
      return "Error fetching POIs!"
    case let .mapViewModelFailToLocateUser(error):
#if DEBUG
      return "Error locating user: \(error.localizedDescription)"
#endif
      return "Error locating user"
    case let .mapViewModelImageDataFetching(url):
      return "Error fetching Data: \(url)"
    case .mapSearchResultsFetching:
      return "Error fetching POI serach results!"
    }// end switch case
  }// end var description
}// end public enum OSCAMapError

extension OSCAMapError: Equatable{
  public static func == (lhs: OSCAMapError, rhs: OSCAMapError) -> Bool {
    switch (lhs, rhs) {
    case (.networkInvalidRequest, .networkInvalidRequest):
      return true
    case (.networkInvalidResponse,.networkInvalidResponse):
      return true
    case (.networkDataLoading(let statusCodeLhs, let dataLhs),.networkDataLoading(let statusCodeRhs, let dataRhs)):
      let statusCode = statusCodeLhs == statusCodeRhs
      let data = dataLhs == dataRhs
      return statusCode && data
    case (networkJSONDecoding(_),networkJSONDecoding(_)):
      return true
    case (.networkIsInternetConnectionFailure,.networkIsInternetConnectionFailure):
      return true
    case (.networkError,.networkError):
      return true
    default:
      return false
    }// switch case
  }// public static func ==
}// end extension public enum OSCAMapError
