//
//  OSCAPoi.swift
//  OSCAMap
//
//  Created by Stephan Breidenbach on 02.03.22.
//  Reviewed by Stephan Breidenbach on 10.08.22

import Foundation
import OSCAEssentials

public struct OSCAPoi {
  /// Auto generated id
  public private(set) var objectId: String?
  /// UTC date when the object was created
  public private(set) var createdAt: Date?
  /// UTC date when the object was changed
  public private(set) var updatedAt: Date?
  /// The name / title of the POI
  public var name: String?
  /// The street name and the street number of the POI
  public var address: String?
  /// The zip code of the POI
  public var zip: String?
  /// The city name of the POI
  public var city: String?
  /// the district name of the POI
  public var district: String?
  /// The unique `objectId` of `OSCAPoiCategory` object of the POI
  public var poiCategory: String?
  /// The flag to show user generated content of the POI
  @OSCAParse.BoolFromDict
  public var showUserGeneratedContent: Bool
  /// The flag to show the route to of the POI
  @OSCAParse.BoolFromDict
  public var showRouteTo: Bool
  /// The route type of the POI
  public var routeType: RouteType?
  /// The geo location point of the POI
  public var geopoint: ParseGeoPoint?
  /// More details of the POI
  public var details: [OSCAPoi.Detail?]?
  /// The associated images of the POI
  public var images: [OSCAPoi.Image?]?
  /// poi category object of the POI
  public var poiCategoryObject: OSCAPoiCategory?
  /// The geo location point from where to start a route from
  public var startGeopoint: OSCAGeoPoint?

  public enum CodingKeys: String, CodingKey {
    /// Auto generated id
    case objectId
    /// UTC date when the object was created
    case createdAt
    /// UTC date when the object was changed
    case updatedAt
    /// The name / title of the POI
    case name
    /// The street name and the street number of the POI
    case address
    /// The zip code of the POI
    case zip
    /// The city name of the POI
    case city
    /// the district name of the POI
    case district
    /// The unique `objectId` of `OSCAPoiCategory` object of the POI
    case poiCategory
    /// The flag to show user generated content of the POI
    case showUserGeneratedContent
    /// The flag to show the route to of the POI
    case showRouteTo
    /// The route type of the POI
    case routeType
    /// The geo location point of the POI
    case geopoint
    /// More details of the POI
    case details
    /// The associated images of the POI
    case images
    /// poi category object of the POI
    case poiCategoryObject
    /// The geo location point from where to start a route from
    case startGeopoint
  } // end public enum CodingKeys
} // end public struct OSCAPoi

extension OSCAPoi: OSCAParseClassObject {}
extension OSCAPoi: Equatable {}

extension OSCAPoi {
  /// fill `pois` with poi categories
  /// - Parameter pois: list of poi s by reference
  /// - Parameter with poiCategories: list of poi categories
  public static func compactMap(pois: inout [OSCAPoi], with poiCategories: [OSCAPoiCategory]) {
    guard !pois.isEmpty,
          !poiCategories.isEmpty else { return }
    pois = pois.compactMap {
      var poi = $0
      guard let poiCategoryId = poi.poiCategory,
            let poiCategoryObject = poiCategories.first(where: { $0.objectId == poiCategoryId })
      else { return nil }
      poi.poiCategoryObject = poiCategoryObject
      return poi
    } // end poiItems
  } // end public static func compactMap pois with poi categories

  /// filters the pois out, which have no `objectId` and no `key`
  /// - Parameter pois: list of `OSCAPoi` by reference
  /// - Parameter by key: coding key
  public static func compact(pois: inout [OSCAPoi], by key: OSCAPoi.CodingKeys) {
    switch key {
    /// Auto generated id
    case .objectId:
      pois = pois.compactMap { ($0.objectId != nil) ? $0 : nil }
    /// UTC date when the object was created
    case .createdAt:
      pois = pois.compactMap { ($0.objectId != nil && $0.createdAt != nil) ? $0 : nil }
    /// UTC date when the object was changed
    case .updatedAt:
      pois = pois.compactMap { ($0.objectId != nil && $0.updatedAt != nil) ? $0 : nil }
    /// The name / title of the POI
    case .name:
      pois = pois.compactMap { ($0.objectId != nil && $0.name != nil) ? $0 : nil }
    /// The street name and the street number of the POI
    case .address:
      pois = pois.compactMap { ($0.objectId != nil && $0.address != nil) ? $0 : nil }
    /// The zip code of the POI
    case .zip:
      pois = pois.compactMap { ($0.objectId != nil && $0.zip != nil) ? $0 : nil }
    /// The city name of the POI
    case .city:
      pois = pois.compactMap { ($0.objectId != nil && $0.city != nil) ? $0 : nil }
    /// the district name of the POI
    case .district:
      pois = pois.compactMap { ($0.objectId != nil && $0.district != nil) ? $0 : nil }
    /// The unique `objectId` of `OSCAPoiCategory` object of the POI
    case .poiCategory:
      pois = pois.compactMap { ($0.objectId != nil && $0.poiCategory != nil) ? $0 : nil }
    /// The flag to show user generated content of the POI
    case .showUserGeneratedContent:
      pois = pois.compactMap { ($0.objectId != nil) ? $0 : nil }
    /// The flag to show the route to of the POIt
    case .showRouteTo:
      pois = pois.compactMap { ($0.objectId != nil) ? $0 : nil }
    /// The route type of the POI
    case .routeType:
      pois = pois.compactMap { ($0.objectId != nil && $0.routeType != nil) ? $0 : nil }
    /// The geo location point of the POI
    case .geopoint:
      pois = pois.compactMap { ($0.objectId != nil && $0.geopoint != nil) ? $0 : nil }
    /// More details of the POI
    case .details:
      pois = pois.compactMap { ($0.objectId != nil && $0.details != nil) ? $0 : nil }
    /// The associated images of the POI
    case .images:
      pois = pois.compactMap { ($0.objectId != nil && $0.images != nil) ? $0 : nil }
    /// poi category object of the POI
    case .poiCategoryObject:
      pois = pois.compactMap { ($0.objectId != nil && $0.poiCategoryObject != nil) ? $0 : nil }
    /// The geo location point from where to start a route from
    case .startGeopoint:
      pois = pois.compactMap { ($0.objectId != nil && $0.startGeopoint != nil) ? $0 : nil }
    } // end switch case
  } // end public static func compact poi categories

  /// filters the pois, which have the given `object`in the `key` property of `OSCAPoi`
  /// - Parameter pois: list of `OSCAPoi` by reference
  /// - Parameter by key: coding key
  /// - Parameter object: the object, which have to be there
  public static func filter(pois: inout [OSCAPoi], by key: OSCAPoi.CodingKeys, object: Any) {
    guard !pois.isEmpty else { return }
    switch key {
    /// Auto generated id
    case .objectId:
      guard let objectId = object as? String else { pois = []; return }
      pois = pois.compactMap { ($0.objectId == objectId) ? $0 : nil }
    /// UTC date when the object was created
    case .createdAt:
      guard let createdAt = object as? Date else { pois = []; return }
      pois = pois.compactMap { ($0.createdAt == createdAt) ? $0 : nil }
    /// UTC date when the object was changed
    case .updatedAt:
      guard let updatedAt = object as? Date else { pois = []; return }
      pois = pois.compactMap { ($0.updatedAt == updatedAt) ? $0 : nil }
    /// The name / title of the POI
    case .name:
      guard let name = object as? String else { pois = []; return }
      pois = pois.compactMap { ($0.name == name) ? $0 : nil }
    /// The street name and the street number of the POI
    case .address:
      guard let address = object as? String else { pois = []; return }
      pois = pois.compactMap { ($0.address == address) ? $0 : nil }
    /// The zip code of the POI
    case .zip:
      guard let zip = object as? String else { pois = []; return }
      pois = pois.compactMap { ($0.zip == zip) ? $0 : nil }
    /// The city name of the POI
    case .city:
      guard let city = object as? String else { pois = []; return }
      pois = pois.compactMap { ($0.city == city) ? $0 : nil }
    /// the district name of the POI
    case .district:
      guard let district = object as? String else { pois = []; return }
      pois = pois.compactMap { ($0.district == district) ? $0 : nil }
    /// The unique `objectId` of `OSCAPoiCategory` object of the POI
    case .poiCategory:
      guard let poiCategory = object as? String else { pois = []; return }
      pois = pois.compactMap { ($0.poiCategory == poiCategory) ? $0 : nil }
    /// The flag to show user generated content of the POI
    case .showUserGeneratedContent:
      guard let showUserGeneratedContent = object as? Bool else { pois = []; return }
      pois = pois.compactMap { ($0.showUserGeneratedContent == showUserGeneratedContent) ? $0 : nil }
    /// The flag to show the route to of the POIt
    case .showRouteTo:
      guard let showRouteTo = object as? Bool else { pois = []; return }
      pois = pois.compactMap { ($0.showRouteTo == showRouteTo) ? $0 : nil }
    /// The route type of the POI
    case .routeType:
      guard let routeType = object as? OSCAPoi.RouteType else { pois = []; return }
      pois = pois.compactMap { ($0.routeType == routeType) ? $0 : nil }
    /// The geo location point of the POI
    case .geopoint:
      guard let geopoint = object as? ParseGeoPoint else { pois = []; return }
      pois = pois.compactMap { ($0.geopoint == geopoint) ? $0 : nil }
    /// More details of the POI
    case .details:
      guard let details = object as? [OSCAPoi.Detail] else { pois = []; return }
      pois = pois.compactMap { ($0.details == details) ? $0 : nil }
    /// The associated images of the POI
    case .images:
      guard let images = object as? [OSCAPoi.Image] else { pois = []; return }
      pois = pois.compactMap { ($0.images == images) ? $0 : nil }
    /// poi category object of the POI
    case .poiCategoryObject:
      guard let poiCategoryObject = object as? OSCAPoiCategory else { pois = []; return }
      pois = pois.compactMap { ($0.poiCategoryObject == poiCategoryObject) ? $0 : nil }
    /// The geo location point from where to start a route from
    case .startGeopoint:
      guard let startGeopoint = object as? OSCAGeoPoint else { pois = []; return }
      pois = pois.compactMap { ($0.startGeopoint == startGeopoint) ? $0 : nil }
    } // end switch case
  } // end public static func filter pois by key object
} // end extension public struct OSCAPoi

// MARK: - Detail

extension OSCAPoi {
  public struct Detail {
    /// type of the detail
    public var type: DetailType?
    /// title / name of the detail
    public var title: String?
    /// subtitle of the detail
    public var subtitle: String?
    /// content value of the detail
    public var value: String?
    /// position of the detail
    public var position: Int?
    /// icon name of the detail
    public var iconName: String?
    /// icon path from where to download of the detail
    public var iconPath: String?
    /// icon MIME type of the detail
    public var iconMimetype: String?
    /// symbol name of the detail
    public var symbolName: String?
    /// symbol path from where to download of the detail
    public var symbolPath: String?
    /// symbol MIME type of the detail
    public var symbolMimetype: String?
    /// filter field of the detail
    public var filterField: String?
  } // end public struct Detail
} // end extension public struct OSCAPoi

extension OSCAPoi.Detail: Codable {}
extension OSCAPoi.Detail: Hashable {}
extension OSCAPoi.Detail: Equatable {}

extension OSCAPoi.Detail {
  public enum DetailType: String {
    /// plain text without extras
    case text
    /// `html` formated content
    case html
    /// phone number
    case tel
    /// url link to external content
    case url
    /// email address
    case mail
    /*
     // - TODO: description
     case http = "http"
     */
    private var typePositionRangeDict: [DetailType: Range<Int>] { return [
      /// position range for `text` [100, 200[
      .text: 100 ..< 200,
      /// position range for `html` [200,300[
      .html: 200 ..< 300,
      /// position range for `tel` [400,600[
      .tel: 400 ..< 600,
      /// position range for `url` [600,700[
      .url: 600 ..< 700,
      /// position range for `mail` [700,800[
      .mail: 700 ..< 800,
    ] // end return
    } // end private let typePositionList
    public var typePositionRange: Range<Int>? {
      return typePositionRangeDict[self]
    } // end public var typePositionRange
  } // end public enum DetailsType
} // end extension OSCAPoi.Detail

extension OSCAPoi.Detail.DetailType: CaseIterable {}
extension OSCAPoi.Detail.DetailType: Codable {}
extension OSCAPoi.Detail.DetailType: Hashable {}
extension OSCAPoi.Detail.DetailType: Equatable {}

extension OSCAPoi.Detail {
  public struct FilterField {
    public var field: String?
    public var value: String?
  } // end public struct FilterField
} // end extension OSCAPoi.Detail

extension OSCAPoi.Detail.FilterField: Codable {}
extension OSCAPoi.Detail.FilterField: Hashable {}
extension OSCAPoi.Detail.FilterField: Equatable {}

extension OSCAPoi.Detail.FilterField {
  public static func with(field: String, value: String) -> OSCAPoi.Detail.FilterField {
    return Self(field: field, value: value)
  }
}

extension OSCAPoi.Detail {
  public var symbolURL: URL? {
    if let symbolPath = symbolPath,
       !symbolPath.isEmpty,
       let baseURL = URL(string: symbolPath),
       let symbolName = symbolName,
       !symbolName.isEmpty,
       let symbolMimeType = symbolMimetype,
       !symbolMimeType.isEmpty,
       symbolMimeType.hasPrefix("."),
       let components = URLComponents(url: baseURL.appendingPathComponent("/\(symbolName)\(symbolMimeType)"), resolvingAgainstBaseURL: false),
       let url = components.url {
      return url
    } else {
      return nil
    } // end if
  } // end var symbolURL

  public var iconURL: URL? {
    if let iconPath = iconPath,
       !iconPath.isEmpty,
       let baseURL = URL(string: iconPath),
       let iconName = iconName,
       !iconName.isEmpty,
       let iconMimeType = iconMimetype,
       !iconMimeType.isEmpty,
       iconMimeType.hasPrefix("."),
       let components = URLComponents(url: baseURL.appendingPathComponent("/\(iconName)\(iconMimeType)"), resolvingAgainstBaseURL: false),
       let url = components.url {
      return url
    } else {
      return nil
    } // end if
  } // end var iconURL
} // end extension OSCAPoi.Detail

// MARK: - District for SG only

extension OSCAPoi {
  public enum District: String {
    /// district Burg-Höhscheid
    case burgHoehscheid = "Burg-H\u{00f6}hscheid"
    /// district Gräfrath
    case graefrath = "Gr\u{00e4}frath"
    /// district Solingen Mitte
    case mitte = "Mitte"
    /// district Ohligs Aufderhöhe Merscheid
    case ohligsAufderhoeheMerscheid = "Ohligs-Aufderh\u{00f6}he-Merscheid"
    /// district Wald
    case wald = "Wald"
  } // end public enum District
} // end extension public struct OSCAPoi

extension OSCAPoi.District: Codable {}
extension OSCAPoi.District: Hashable {}
extension OSCAPoi.District: Equatable {}

// MARK: - Route Type

extension OSCAPoi {
  public enum RouteType: String {
    case car
    case walk
//    case publicTransport = "public transport"
    case bicycle
  } // end public enum RouteType
} // end extension public struct OSCAPoi

extension OSCAPoi.RouteType: Codable {}
extension OSCAPoi.RouteType: Hashable {}
extension OSCAPoi.RouteType: Equatable {}

// MARK: - Image

extension OSCAPoi {
  public struct Image {
    /// name / title of the image
    public var imageName: String?
    /// the path from where to download from the image
    public var imagePath: String?
    /// the MIME type of the image
    public var imageMimetype: String?
    /// the info text of the image
    public var text: String?
    // TODO: description
    public var relevance: Int?
    /// accessibility hint of the image
    public var accessibilityHint: String?
  } // end public struct Image
} // end extension public struct OSCAPoi

extension OSCAPoi.Image: Codable {}
extension OSCAPoi.Image: Hashable {}
extension OSCAPoi.Image: Equatable {}

extension OSCAPoi.Image {
  public var imageURL: URL? {
    if let imagePath = imagePath,
       !imagePath.isEmpty,
       let baseURL = URL(string: imagePath),
       let imageName = imageName,
       !imageName.isEmpty,
       let imageMimeType = imageMimetype,
       !imageMimeType.isEmpty,
       imageMimeType.hasPrefix("."),
       let components = URLComponents(url: baseURL.appendingPathComponent("/\(imageName)\(imageMimeType)"), resolvingAgainstBaseURL: false),
       let url = components.url {
      return url
    } else {
      return nil
    } // end if
  } // end var imageURL
} // end extension public struct OSCAPoi.Image

// MARK: - Search result

extension OSCAPoi {
  public struct SearchResult {
    public var result: [OSCAPoi.SearchResult.Item]

    public init() {
      result = []
    }
  } // end public struct SearchResult
} // end extension public struct OSCAPoi

extension OSCAPoi.SearchResult: Codable {}
extension OSCAPoi.SearchResult: Equatable {}
extension OSCAPoi.SearchResult: Hashable {}

extension OSCAPoi.SearchResult {
  public struct Item {
    public var id: String?
    public enum CodingKeys: String, CodingKey {
      case id = "_id"
    } // end public enum CodingKeys
  } // end public struct SearchResult.Item
} // end extension public struct OSCAPoi.SearchResult

extension OSCAPoi.SearchResult.Item: Codable {}
extension OSCAPoi.SearchResult.Item: Equatable {}
extension OSCAPoi.SearchResult.Item: Hashable {}

// MARK: - Filter result

extension OSCAPoi {
  public struct Filter {
    public var result: [OSCAPoi.Filter.Result]
  } // end public struct Filter
} // end extension public struct OSCAPoi

extension OSCAPoi.Filter: Codable {}
extension OSCAPoi.Filter: Equatable {}
extension OSCAPoi.Filter: Hashable {}

extension OSCAPoi.Filter {
  public struct Result {
    public var items: [OSCAPoi]?
    public var count: Int?
  } // end public struct Result
} // end extension public struct OSCAPoi.Filter

extension OSCAPoi.Filter.Result: Codable {}
extension OSCAPoi.Filter.Result: Equatable {}
extension OSCAPoi.Filter.Result: Hashable {}

extension OSCAPoi {
  public struct CacheQueryParameter {
    ///  Forces the functions to query the database
    public var force: Bool
  }
}

extension OSCAPoi.CacheQueryParameter: Codable {}
extension OSCAPoi.CacheQueryParameter: Hashable {}
extension OSCAPoi.CacheQueryParameter: Equatable {}


extension OSCAPoi {
  public struct NearbyQueryParameter {
    public var lat: Double
    public var lon: Double
    public var distance: Int?
    public var random: Bool?
    public var limit: Int?
    public var category: String?
  }
}

extension OSCAPoi.NearbyQueryParameter: Codable {}
extension OSCAPoi.NearbyQueryParameter: Hashable {}
extension OSCAPoi.NearbyQueryParameter: Equatable {}

extension OSCAPoi {
  /// Parse class name
  public static var parseClassName : String { return "POI" }
}// end extension OSCAPoi
