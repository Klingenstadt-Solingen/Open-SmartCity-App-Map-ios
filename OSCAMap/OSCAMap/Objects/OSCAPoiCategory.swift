//
//  OSCAPoiCategory.swift
//  OSCAMap
//
//  Created by Stephan Breidenbach on 02.03.22.
//  Reviewed by Stephan Breidenbach on 10.08.22

import Foundation
import OSCAEssentials

public struct OSCAPoiCategory {
  /// Auto generated id
  public private(set) var objectId: String?
  /// UTC date when the object was created
  public private(set) var createdAt: Date?
  /// UTC date when the object was changed
  public private(set) var updatedAt: Date?
  /// name / title of the POI category
  public var name: String?
  /// title of the map of the POI category
  public var mapTitle: String?
  // TODO: description
  public var status: String?
  /// icon name ot the POI category
  public var iconName: String?
  /// icon path from where to download, of the POI category
  public var iconPath: String?
  /// icon MIME type of the POI category
  public var iconMimetype: String?
  /// icon image data of the POI category
  public var iconImageData: IconImageData?
  /// symbol name for the map Pin of the POI category
  public var symbolName: String?
  /// symbol path from where to download, of the POI category
  public var symbolPath: String?
  /// symbol MIME type of the POI category
  public var symbolMimetype: String?
  /// symbol image data of the POI category
  public var symbolImageData: SymbolImageData?
  /// position where to show the POI category
  public var position: Int?
  /// flag to show the POI category
  @OSCAParse.BoolFromString
  public var showCategory: Bool?
  /// version string of the POI category
  public var categoryVersion: String?
  // TODO: description
  public var metathema: String?
  // TODO: description
  public var metaquelle: String?
  // TODO: description
  public var metainfodatum: String?
  /// flag to show the filter of the POI category
  @OSCAParse.BoolFromString
  public var showFilter: Bool?
  /// Id of the object in the source system
  public var sourceId: String?
  /// The thematic view that should be used by default
  public var defaultThematicView: String?

  /// flist of possible filter fields of the POI category
  public var filterFields: [OSCAPoiCategory.FilterField?]?

  public enum CodingKeys: String, CodingKey {
    /// Auto generated id
    case objectId
    /// UTC date when the object was created
    case createdAt
    /// UTC date when the object was changed
    case updatedAt
    /// name / title of the POI category
    case name
    /// title of the map of the POI category
    case mapTitle
    // TODO: description
    case status
    /// icon name ot the POI category
    case iconName
    /// icon path from where to download, of the POI category
    case iconPath
    /// icon MIME type of the POI category
    case iconMimetype
    /// icon image data of the POI category
    case iconImageData
    /// symbol name for the map Pin of the POI category
    case symbolName
    /// symbol path from where to download, of the POI category
    case symbolPath
    /// symbol MIME type of the POI category
    case symbolMimetype
    /// symbol image data of the POI category
    case symbolImageData
    /// position where to show the POI category
    case position
    /// flag to show the POI category
    case showCategory
    /// version string of the POI category
    case categoryVersion
    // TODO: description
    case metathema
    // TODO: description
    case metaquelle
    // TODO: description
    case metainfodatum
    /// flag to show the filter of the POI category
    case showFilter
    /// flist of possible filter fields of the POI category
    case filterFields
    case sourceId
    case defaultThematicView
  } // end public enum CodingKeys
} // end public struct OSCAPoiCategory

extension OSCAPoiCategory: OSCAParseClassObject {}

// MARK: - Image data

extension OSCAPoiCategory {
  public struct IconImageData: OSCAImageData {
    public static func < (lhs: OSCAPoiCategory.IconImageData, rhs: OSCAPoiCategory.IconImageData) -> Bool {
      let lhsImageData = lhs.imageData
      let rhsImageData = rhs.imageData
      if nil != lhsImageData {
        if nil != rhsImageData {
          return lhsImageData!.count < rhsImageData!.count
        } else {
          return false
        } // end if
      } else {
        if nil != rhsImageData {
          return false
        } else {
          return true
        } // end if
      } // end if
    } // end public static func <

    public init(objectId: String, imageData: Data) {
      self.objectId = objectId
      self.imageData = imageData
    } // end public init

    public var objectId: String?
    public var imageData: Data?
    public var url: URL?
  } // end public struct IconImageData
} // end extension public struct OSCAPoiCategory

extension OSCAPoiCategory.IconImageData: OSCAUrlData {
  public var data: Data? {
    get {
      self.imageData
    }// end getter
    set(newValue) {
      self.imageData = newValue
    }// end setter
  }// end public var data
  
  public init(url: URL, data: Data) {
    self.url = url
    self.data = data
  }// end public init
}// end extension public struct IconImageData

extension OSCAPoiCategory.IconImageData: Comparable {}

extension OSCAPoiCategory {
  public struct SymbolImageData: OSCAImageData {
    public init(objectId: String, imageData: Data) {
      self.objectId = objectId
      self.imageData = imageData
    } // end public init

    public static func < (lhs: OSCAPoiCategory.SymbolImageData, rhs: OSCAPoiCategory.SymbolImageData) -> Bool {
      let lhsImageData = lhs.imageData
      let rhsImageData = rhs.imageData
      if nil != lhsImageData {
        if nil != rhsImageData {
          return lhsImageData!.count < rhsImageData!.count
        } else {
          return false
        } // end if
      } else {
        if nil != rhsImageData {
          return false
        } else {
          return true
        } // end if
      } // end if
    } // end public static func <

    public var objectId: String?
    public var imageData: Data?
  } // end public struct SymbolImageData
} // end extension public struct OSCAPoiCategory

extension OSCAPoiCategory.SymbolImageData: Comparable {}

// MARK: - Default Categories

extension OSCAPoiCategory {
  public struct DefaultCategories {
    /// list of poi category names
    public var list: [String]

    public init(list: [String]) {
      self.list = list
    } // end public init
  } // end public struct DefaultCategories
} // extension public struct OSCAPoiCategory

extension OSCAPoiCategory.DefaultCategories: Codable {}
extension OSCAPoiCategory.DefaultCategories: Hashable {}
extension OSCAPoiCategory.DefaultCategories: Equatable {}

// MARK: - Filter field

extension OSCAPoiCategory {
  public struct FilterField {
    /// human readable filter title
    public var title: String?
    /// link to OSCAPOI.Detail.filterField
    public var field: String?
    /// filter string values
    public var values: [String?]?
  } // end public struct FilterField
} // end extension public struct OSCAPoiCategory

extension OSCAPoiCategory.FilterField: Codable {}
extension OSCAPoiCategory.FilterField: Hashable {}
extension OSCAPoiCategory.FilterField: Equatable {}
extension OSCAPoiCategory.FilterField: Comparable {
  public static func < (lhs: OSCAPoiCategory.FilterField, rhs: OSCAPoiCategory.FilterField) -> Bool {
    let lhsField = lhs.field
    let rhsField = rhs.field
    if nil != lhsField {
      if nil != rhsField {
        return lhsField! < rhsField!
      } else {
        return false
      } // end if
    } else {
      if nil != rhsField {
        return false
      } else {
        return true
      } // end if
    } // end if
  } // end public static func <
} // end extension OSCAPoiCategory.FilterField

// MARK: - Filter Field Query Parameter

extension OSCAPoiCategory {
  public struct FilterFieldQueryParameter {
    /// `OSCAPoiCategory` object id
    public var category: String
    /// list of `OSCAPoi` details filter fields
    public var filter: [OSCAPoi.Detail.FilterField]
    /// force
    public var force: Bool
  }// end public struct FilterFieldQueryParameter
}// end extension OSCAPoiCategory

extension OSCAPoiCategory.FilterFieldQueryParameter {
  public init( categorySourceId: String,
               filter: [OSCAPoi.Detail.FilterField] = []) {
    self.category = categorySourceId
    self.filter = filter
    self.force = false
  }// end public init
}// end extension OSCAPoiCategory.FilterFieldQueryParameter

extension OSCAPoiCategory.FilterFieldQueryParameter: Codable {}
extension OSCAPoiCategory.FilterFieldQueryParameter: Hashable {}
extension OSCAPoiCategory.FilterFieldQueryParameter: Equatable {}

// MARK: - PoiCategories mutating functions

extension OSCAPoiCategory {
  /// filters the poi categories out, which have no `objectId` and no `key`
  /// - Parameter poiCategories: list of `OSCAPoiCategories` by reference
  /// - Parameter by key: coding key
  public static func compact(poiCategories: inout [OSCAPoiCategory], by key: OSCAPoiCategory.CodingKeys) {
    switch key {
    /// Auto generated id
    case .objectId:
      poiCategories = poiCategories.compactMap { ($0.objectId != nil) ? $0 : nil }
    /// UTC date when the object was created
    case .createdAt:
      poiCategories = poiCategories.compactMap { ($0.objectId != nil && $0.createdAt != nil) ? $0 : nil }
    /// UTC date when the object was changed
    case .updatedAt:
      poiCategories = poiCategories.compactMap { ($0.objectId != nil && $0.updatedAt != nil) ? $0 : nil }
    /// name / title of the POI category
    case .name:
      poiCategories = poiCategories.compactMap { ($0.objectId != nil && $0.name != nil) ? $0 : nil }
    /// title of the map of the POI category
    case .mapTitle:
      poiCategories = poiCategories.compactMap { ($0.objectId != nil && $0.mapTitle != nil) ? $0 : nil }
    // TODO: description
    case .status:
      poiCategories = poiCategories.compactMap { ($0.objectId != nil && $0.status != nil) ? $0 : nil }
    /// icon name ot the POI category
    case .iconName:
      poiCategories = poiCategories.compactMap { ($0.objectId != nil && $0.iconName != nil) ? $0 : nil }
    /// icon path from where to download, of the POI category
    case .iconPath:
      poiCategories = poiCategories.compactMap { ($0.objectId != nil && $0.iconPath != nil) ? $0 : nil }
    /// icon MIME type of the POI category
    case .iconMimetype:
      poiCategories = poiCategories.compactMap { ($0.objectId != nil && $0.iconMimetype != nil) ? $0 : nil }
    /// icon image data of the POI category
    case .iconImageData:
      poiCategories = poiCategories.compactMap { ($0.objectId != nil && $0.iconImageData != nil) ? $0 : nil }
    /// symbol name for the map Pin of the POI category
    case .symbolName:
      poiCategories = poiCategories.compactMap { ($0.objectId != nil && $0.symbolName != nil) ? $0 : nil }
    /// symbol path from where to download, of the POI category
    case .symbolPath:
      poiCategories = poiCategories.compactMap { ($0.objectId != nil && $0.symbolPath != nil) ? $0 : nil }
    /// symbol MIME type of the POI category
    case .symbolMimetype:
      poiCategories = poiCategories.compactMap { ($0.objectId != nil && $0.symbolMimetype != nil) ? $0 : nil }
    /// symbol image data of the POI category
    case .symbolImageData:
      poiCategories = poiCategories.compactMap { ($0.objectId != nil && $0.symbolImageData != nil) ? $0 : nil }
    /// position where to show the POI category
    case .position:
      poiCategories = poiCategories.compactMap { ($0.objectId != nil && $0.position != nil) ? $0 : nil }
    /// flag to show the POI category
    case .showCategory:
      poiCategories = poiCategories.compactMap { ($0.objectId != nil && $0.showCategory != nil) ? $0 : nil }
    /// version string of the POI category
    case .categoryVersion:
      poiCategories = poiCategories.compactMap { ($0.objectId != nil && $0.categoryVersion != nil) ? $0 : nil }
    // TODO: description
    case .metathema:
      poiCategories = poiCategories.compactMap { ($0.objectId != nil && $0.metathema != nil) ? $0 : nil }
    // TODO: description
    case .metaquelle:
      poiCategories = poiCategories.compactMap { ($0.objectId != nil && $0.metaquelle != nil) ? $0 : nil }
    // TODO: description
    case .metainfodatum:
      poiCategories = poiCategories.compactMap { ($0.objectId != nil && $0.metainfodatum != nil) ? $0 : nil }
    /// flag to show the filter of the POI category
    case .showFilter:
      poiCategories = poiCategories.compactMap { ($0.objectId != nil && $0.showFilter != nil) ? $0 : nil }
    /// flist of possible filter fields of the POI category
    case .filterFields:
      poiCategories = poiCategories.compactMap { ($0.objectId != nil && $0.filterFields != nil) ? $0 : nil }
    case .sourceId:
      poiCategories = poiCategories.compactMap { ($0.objectId != nil && $0.sourceId != nil) ? $0 : nil }
    case .defaultThematicView:
      poiCategories = poiCategories.compactMap { ($0.defaultThematicView != nil && $0.defaultThematicView != nil) ? $0 : nil }
    } // end switch case
  } // end public static func compact poi categories

  /// sort a list of poi categories in ascending order by key
  /// - Parameter poiCategories: list of `OSCAPoiCategories` by reference
  /// - Parameter by key: coding key
  public static func sort(poiCategories: inout [OSCAPoiCategory], by key: OSCAPoiCategory.CodingKeys) {
    OSCAPoiCategory.compact(poiCategories: &poiCategories, by: key)
    guard !poiCategories.isEmpty else { return }
    switch key {
    /// Auto generated id
    case .objectId:
      poiCategories.sort(by: { $0.objectId! <= $1.objectId! })
    /// UTC date when the object was created
    case .createdAt:
      poiCategories.sort(by: { $0.createdAt! <= $1.createdAt! })
    /// UTC date when the object was changed
    case .updatedAt:
      poiCategories.sort(by: { $0.updatedAt! <= $1.updatedAt! })
    /// name / title of the POI category
    case .name:
      poiCategories.sort(by: { $0.name! <= $1.name! })
    /// title of the map of the POI category
    case .mapTitle:
      poiCategories.sort(by: { $0.mapTitle! <= $1.mapTitle! })
    // TODO: description
    case .status:
      poiCategories.sort(by: { $0.status! <= $1.status! })
    /// icon name ot the POI category
    case .iconName:
      poiCategories.sort(by: { $0.iconName! <= $1.iconName! })
    /// icon path from where to download, of the POI category
    case .iconPath:
      poiCategories.sort(by: { $0.iconPath! <= $1.iconPath! })
    /// icon MIME type of the POI category
    case .iconMimetype:
      poiCategories.sort(by: { $0.iconMimetype! <= $1.iconMimetype! })
    /// icon image data of the POI category
    case .iconImageData:
      poiCategories.sort(by: { $0.iconImageData! <= $1.iconImageData! })
    /// symbol name for the map Pin of the POI category
    case .symbolName:
      poiCategories.sort(by: { $0.symbolName! <= $1.symbolName! })
    /// symbol path from where to download, of the POI category
    case .symbolPath:
      poiCategories.sort(by: { $0.symbolPath! <= $1.symbolPath! })
    /// symbol MIME type of the POI category
    case .symbolMimetype:
      poiCategories.sort(by: { $0.symbolMimetype! <= $1.symbolMimetype! })
    /// symbol image data of the POI category
    case .symbolImageData:
      poiCategories.sort(by: { $0.symbolImageData! <= $1.symbolImageData! })
    /// position where to show the POI category
    case .position:
      poiCategories.sort(by: { $0.position! <= $1.position! })
    /// flag to show the POI category
    case .showCategory:
      poiCategories.sort(by: { ($0.showCategory! == $1.showCategory!) || $0.showCategory! })
    /// version string of the POI category
    case .categoryVersion:
      poiCategories.sort(by: { $0.categoryVersion! <= $1.categoryVersion! })
    // TODO: description
    case .metathema:
      poiCategories.sort(by: { $0.metathema! <= $1.metathema! })
    // TODO: description
    case .metaquelle:
      poiCategories.sort(by: { $0.metaquelle! <= $1.metaquelle! })
    // TODO: description
    case .metainfodatum:
      poiCategories.sort(by: { $0.metainfodatum! <= $1.metainfodatum! })
    /// flag to show the filter of the POI category
    case .showFilter:
      poiCategories.sort(by: { ($0.showFilter! == $1.showFilter!) || $0.showFilter! })
    /// flist of possible filter fields of the POI category
    case .filterFields:
      poiCategories.sort(by: { $0.filterFields!.count <= $1.filterFields!.count })
    case .sourceId:
      poiCategories.sort(by: { $0.sourceId! <= $1.sourceId! })
    case .defaultThematicView:
      poiCategories.sort(by: { $0.defaultThematicView! <= $1.defaultThematicView! })
    } // end switch case
  } // end public static func sort

  ///  evaluates if the `poiCategories` list contains an `object` in `key`, the given property of `OSCAPoiCategory`
  ///  - Parameter poiCategories: list of `OSCAPoiCategories`
  ///  - Parameter by key: coding key
  ///  - Parameter object: search object
  public static func contains(poiCategories: [OSCAPoiCategory], by key: OSCAPoiCategory.CodingKeys, object: Any) -> Bool {
    guard !poiCategories.isEmpty else { return false }
    switch key {
    /// Auto generated id
    case .objectId:
      guard let objectId = object as? String else { return false }
      return poiCategories.contains(where: { $0.objectId == objectId })
    /// UTC date when the object was created
    case .createdAt:
      guard let createdAt = object as? Date else { return false }
      return poiCategories.contains(where: { $0.createdAt == createdAt })
    /// UTC date when the object was changed
    case .updatedAt:
      guard let updatedAt = object as? Date else { return false }
      return poiCategories.contains(where: { $0.updatedAt == updatedAt })
    /// name / title of the POI category
    case .name:
      guard let name = object as? String else { return false }
      return poiCategories.contains(where: { $0.name == name })
    /// title of the map of the POI category
    case .mapTitle:
      guard let mapTitle = object as? String else { return false }
      return poiCategories.contains(where: { $0.mapTitle == mapTitle })
    // TODO: description
    case .status:
      guard let status = object as? String else { return false }
      return poiCategories.contains(where: { $0.status == status })
    /// icon name ot the POI category
    case .iconName:
      guard let iconName = object as? String else { return false }
      return poiCategories.contains(where: { $0.iconName == iconName })
    /// icon path from where to download, of the POI category
    case .iconPath:
      guard let iconPath = object as? String else { return false }
      return poiCategories.contains(where: { $0.iconPath == iconPath })
    /// icon MIME type of the POI category
    case .iconMimetype:
      guard let iconMimetype = object as? String else { return false }
      return poiCategories.contains(where: { $0.iconMimetype == iconMimetype })
    /// icon image data of the POI category
    case .iconImageData:
      guard let iconImageData = object as? OSCAPoiCategory.IconImageData else { return false }
      return poiCategories.contains(where: { $0.iconImageData == iconImageData })
    /// symbol name for the map Pin of the POI category
    case .symbolName:
      guard let symbolName = object as? String else { return false }
      return poiCategories.contains(where: { $0.symbolName == symbolName })
    /// symbol path from where to download, of the POI category
    case .symbolPath:
      guard let symbolPath = object as? String else { return false }
      return poiCategories.contains(where: { $0.symbolPath == symbolPath })
    /// symbol MIME type of the POI category
    case .symbolMimetype:
      guard let symbolMimetype = object as? String else { return false }
      return poiCategories.contains(where: { $0.symbolMimetype == symbolMimetype })
    /// symbol image data of the POI category
    case .symbolImageData:
      guard let symbolImageData = object as? OSCAPoiCategory.SymbolImageData else { return false }
      return poiCategories.contains(where: { $0.symbolImageData == symbolImageData })
    /// position where to show the POI category
    case .position:
      guard let position = object as? Int else { return false }
      return poiCategories.contains(where: { $0.position == position })
    /// flag to show the POI category
    case .showCategory:
      guard let showCategory = object as? Bool else { return false }
      return poiCategories.contains(where: { $0.showCategory == showCategory })
    /// version string of the POI category
    case .categoryVersion:
      guard let categoryVersion = object as? String else { return false }
      return poiCategories.contains(where: { $0.categoryVersion == categoryVersion })
    // TODO: description
    case .metathema:
      guard let metathema = object as? String else { return false }
      return poiCategories.contains(where: { $0.metathema == metathema })
    // TODO: description
    case .metaquelle:
      guard let metaquelle = object as? String else { return false }
      return poiCategories.contains(where: { $0.metaquelle == metaquelle })
    // TODO: description
    case .metainfodatum:
      guard let metainfodatum = object as? String else { return false }
      return poiCategories.contains(where: { $0.metainfodatum == metainfodatum })
    /// flag to show the filter of the POI category
    case .showFilter:
      guard let showFilter = object as? Bool else { return false }
      return poiCategories.contains(where: { $0.showFilter == showFilter })
    /// flist of possible filter fields of the POI category
    case .filterFields:
      guard let filterFields = object as? [OSCAPoiCategory.FilterField] else { return false }
      return poiCategories.contains(where: { $0.filterFields == filterFields })
    case .sourceId:
      guard let sourceId = object as? String else { return false }
      return poiCategories.contains(where: { $0.sourceId == sourceId })
    case .defaultThematicView:
      guard let defaultThematicView = object as? String else { return false }
      return poiCategories.contains(where: { $0.defaultThematicView == defaultThematicView })
    } // end switch case
  } // end func contains poiCategories by key object

  /// filters the poiCategories, which have the given `object`in the `key` property of `OSCAPoiCategory`
  /// - Parameter poiCategories: list of `OSCAPoiCategory` by reference
  /// - Parameter by key: coding key
  /// - Parameter object: the object, which have to be there
  public static func filter(poiCategories: inout [OSCAPoiCategory], by key: OSCAPoiCategory.CodingKeys, object: Any) {
    guard !poiCategories.isEmpty else { return }
    switch key {
    /// Auto generated id
    case .objectId:
      guard let objectId = object as? String else { poiCategories = []; return }
      poiCategories = poiCategories.compactMap { ($0.objectId == objectId) ? $0 : nil }
    /// UTC date when the object was created
    case .createdAt:
      guard let createdAt = object as? Date else { poiCategories = []; return }
      poiCategories = poiCategories.compactMap { ($0.createdAt == createdAt) ? $0 : nil }
    /// UTC date when the object was changed
    case .updatedAt:
      guard let updatedAt = object as? Date else { poiCategories = []; return }
      poiCategories = poiCategories.compactMap { ($0.updatedAt == updatedAt) ? $0 : nil }
    /// name / title of the POI category
    case .name:
      guard let name = object as? String else { poiCategories = []; return }
      poiCategories = poiCategories.compactMap { ($0.name == name) ? $0 : nil }
    /// title of the map of the POI category
    case .mapTitle:
      guard let mapTitle = object as? String else { poiCategories = []; return }
      poiCategories = poiCategories.compactMap { ($0.mapTitle == mapTitle) ? $0 : nil }
    // TODO: description
    case .status:
      guard let status = object as? String else { poiCategories = []; return }
      poiCategories = poiCategories.compactMap { ($0.status == status) ? $0 : nil }
    /// icon name ot the POI category
    case .iconName:
      guard let iconName = object as? String else { poiCategories = []; return }
      poiCategories = poiCategories.compactMap { ($0.iconName == iconName) ? $0 : nil }
    /// icon path from where to download, of the POI category
    case .iconPath:
      guard let iconPath = object as? String else { poiCategories = []; return }
      poiCategories = poiCategories.compactMap { ($0.iconPath == iconPath) ? $0 : nil }
    /// icon MIME type of the POI category
    case .iconMimetype:
      guard let iconMimetype = object as? String else { poiCategories = []; return }
      poiCategories = poiCategories.compactMap { ($0.iconMimetype == iconMimetype) ? $0 : nil }
    /// icon image data of the POI category
    case .iconImageData:
      guard let iconImageData = object as? OSCAPoiCategory.IconImageData else { poiCategories = []; return }
      poiCategories = poiCategories.compactMap { ($0.iconImageData == iconImageData) ? $0 : nil }
    /// symbol name for the map Pin of the POI category
    case .symbolName:
      guard let symbolName = object as? String else { poiCategories = []; return }
      poiCategories = poiCategories.compactMap { ($0.symbolName == symbolName) ? $0 : nil }
    /// symbol path from where to download, of the POI category
    case .symbolPath:
      guard let symbolPath = object as? String else { poiCategories = []; return }
      poiCategories = poiCategories.compactMap { ($0.symbolPath == symbolPath) ? $0 : nil }
    /// symbol MIME type of the POI category
    case .symbolMimetype:
      guard let symbolMimetype = object as? String else { poiCategories = []; return }
      poiCategories = poiCategories.compactMap { ($0.symbolMimetype == symbolMimetype) ? $0 : nil }
    /// symbol image data of the POI category
    case .symbolImageData:
      guard let symbolImageData = object as? OSCAPoiCategory.SymbolImageData else { poiCategories = []; return }
      poiCategories = poiCategories.compactMap { ($0.symbolImageData == symbolImageData) ? $0 : nil }
    /// position where to show the POI category
    case .position:
      guard let position = object as? Int else { poiCategories = []; return }
      poiCategories = poiCategories.compactMap { ($0.position == position) ? $0 : nil }
    /// flag to show the POI category
    case .showCategory:
      guard let showCategory = object as? Bool else { poiCategories = []; return }
      poiCategories = poiCategories.compactMap { ($0.showCategory == showCategory) ? $0 : nil }
    /// version string of the POI category
    case .categoryVersion:
      guard let categoryVersion = object as? String else { poiCategories = []; return }
      poiCategories = poiCategories.compactMap { ($0.categoryVersion == categoryVersion) ? $0 : nil }
    // TODO: description
    case .metathema:
      guard let metathema = object as? String else { poiCategories = []; return }
      poiCategories = poiCategories.compactMap { ($0.metathema == metathema) ? $0 : nil }
    // TODO: description
    case .metaquelle:
      guard let metaquelle = object as? String else { poiCategories = []; return }
      poiCategories = poiCategories.compactMap { ($0.metaquelle == metaquelle) ? $0 : nil }
    // TODO: description
    case .metainfodatum:
      guard let metainfodatum = object as? String else { poiCategories = []; return }
      poiCategories = poiCategories.compactMap { ($0.metainfodatum == metainfodatum) ? $0 : nil }
    /// flag to show the filter of the POI category
    case .showFilter:
      guard let showFilter = object as? Bool else { poiCategories = []; return }
      poiCategories = poiCategories.compactMap { ($0.showFilter == showFilter) ? $0 : nil }
    /// flist of possible filter fields of the POI category
    case .filterFields:
      guard let filterFields = object as? [OSCAPoiCategory.FilterField] else { poiCategories = []; return }
      poiCategories = poiCategories.compactMap { ($0.filterFields == filterFields) ? $0 : nil }
    case .sourceId:
      guard let sourceId = object as? String else { poiCategories = []; return }
      poiCategories = poiCategories.compactMap { ($0.sourceId == sourceId) ? $0 : nil }
    case .defaultThematicView:
      guard let defaultThematicView = object as? String else { poiCategories = []; return }
      poiCategories = poiCategories.compactMap { ($0.defaultThematicView == defaultThematicView) ? $0 : nil }
    } // end switch case
  } // end public static func filter poi categories by key object

  /// filters the poiCategories, which have the given `objects` in the `key` property of `OSCAPoiCategory`
  /// - Parameter poiCategories: list of `OSCAPoiCategory` by reference
  /// - Parameter by key: coding key
  /// - Parameter objects: the objects, which have to be there
  public static func filter(poiCategories: inout [OSCAPoiCategory], by key: OSCAPoiCategory.CodingKeys, objects: [Any]) {
    guard !poiCategories.isEmpty,
          !objects.isEmpty else { return }
    switch key {
    /// Auto generated id
    case .objectId:
      guard let objectIds = objects as? [String] else { poiCategories = []; return }
      poiCategories = poiCategories.compactMap { poiCategory in
        objectIds.contains { objectId in
          poiCategory.objectId == objectId
        } ? poiCategory : nil
      }
    /// UTC date when the object was created
    case .createdAt:
      guard let createdAts = objects as? [Date] else { poiCategories = []; return }
      poiCategories = poiCategories.compactMap { poiCategory in
        createdAts.contains { createdAt in
          poiCategory.createdAt == createdAt
        } ? poiCategory : nil
      }
    /// UTC date when the object was changed
    case .updatedAt:
      guard let updatedAts = objects as? [Date] else { poiCategories = []; return }
      poiCategories = poiCategories.compactMap { poiCategory in
        updatedAts.contains { updatedAt in
          poiCategory.updatedAt == updatedAt
        } ? poiCategory : nil
      }
    /// name / title of the POI category
    case .name:
      guard let names = objects as? [String] else { poiCategories = []; return }
      poiCategories = poiCategories.compactMap { poiCategory in
        names.contains { name in
          poiCategory.name == name
        } ? poiCategory : nil
      }
    /// title of the map of the POI category
    case .mapTitle:
      guard let mapTitles = objects as? [String] else { poiCategories = []; return }
      poiCategories = poiCategories.compactMap { poiCategory in
        mapTitles.contains { mapTitle in
          poiCategory.mapTitle == mapTitle
        } ? poiCategory : nil
      }
    // TODO: description
    case .status:
      guard let stati = objects as? [String] else { poiCategories = []; return }
      poiCategories = poiCategories.compactMap { poiCategory in
        stati.contains { status in
          poiCategory.status == status
        } ? poiCategory : nil
      }
    /// icon name ot the POI category
    case .iconName:
      guard let iconNames = objects as? [String] else { poiCategories = []; return }
      poiCategories = poiCategories.compactMap { poiCategory in
        iconNames.contains { iconName in
          poiCategory.iconName == iconName
        } ? poiCategory : nil
      }
    /// icon path from where to download, of the POI category
    case .iconPath:
      guard let iconPaths = objects as? [String] else { poiCategories = []; return }
      poiCategories = poiCategories.compactMap { poiCategory in
        iconPaths.contains { iconPath in
          poiCategory.iconPath == iconPath
        } ? poiCategory : nil
      }
    /// icon MIME type of the POI category
    case .iconMimetype:
      guard let iconMimetypes = objects as? [String] else { poiCategories = []; return }
      poiCategories = poiCategories.compactMap { poiCategory in
        iconMimetypes.contains { iconMimetype in
          poiCategory.iconMimetype == iconMimetype
        } ? poiCategory : nil
      }
    /// icon image data of the POI category
    case .iconImageData:
      guard let iconImageDatas = objects as? [OSCAPoiCategory.IconImageData] else { poiCategories = []; return }
      poiCategories = poiCategories.compactMap { poiCategory in
        iconImageDatas.contains { iconImageData in
          poiCategory.iconImageData == iconImageData
        } ? poiCategory : nil
      }
    /// symbol name for the map Pin of the POI category
    case .symbolName:
      guard let symbolNames = objects as? [String] else { poiCategories = []; return }
      poiCategories = poiCategories.compactMap { poiCategory in
        symbolNames.contains { symbolName in
          poiCategory.symbolName == symbolName
        } ? poiCategory : nil
      }
    /// symbol path from where to download, of the POI category
    case .symbolPath:
      guard let symbolPaths = objects as? [String] else { poiCategories = []; return }
      poiCategories = poiCategories.compactMap { poiCategory in
        symbolPaths.contains { symbolPath in
          poiCategory.symbolPath == symbolPath
        } ? poiCategory : nil
      }
    /// symbol MIME type of the POI category
    case .symbolMimetype:
      guard let symbolMimetypes = objects as? [String] else { poiCategories = []; return }
      poiCategories = poiCategories.compactMap { poiCategory in
        symbolMimetypes.contains { symbolMimetype in
          poiCategory.symbolMimetype == symbolMimetype
        } ? poiCategory : nil
      }
    /// symbol image data of the POI category
    case .symbolImageData:
      guard let symbolImageDatas = objects as? [OSCAPoiCategory.SymbolImageData] else { poiCategories = []; return }
      poiCategories = poiCategories.compactMap { poiCategory in
        symbolImageDatas.contains { symbolImageData in
          poiCategory.symbolImageData == symbolImageData
        } ? poiCategory : nil
      }
    /// position where to show the POI category
    case .position:
      guard let positions = objects as? [Int] else { poiCategories = []; return }
      poiCategories = poiCategories.compactMap { poiCategory in
        positions.contains { position in
          poiCategory.position == position
        } ? poiCategory : nil
      }
    /// flag to show the POI category
    case .showCategory:
      guard let showCategories = objects as? [Bool] else { poiCategories = []; return }
      poiCategories = poiCategories.compactMap { poiCategory in
        showCategories.contains { showCategory in
          poiCategory.showCategory == showCategory
        } ? poiCategory : nil
      }
    /// version string of the POI category
    case .categoryVersion:
      guard let categoryVersions = objects as? [String] else { poiCategories = []; return }
      poiCategories = poiCategories.compactMap { poiCategory in
        categoryVersions.contains { categoryVersion in
          poiCategory.categoryVersion == categoryVersion
        } ? poiCategory : nil
      }
    // TODO: description
    case .metathema:
      guard let metathemas = objects as? [String] else { poiCategories = []; return }
      poiCategories = poiCategories.compactMap { poiCategory in
        metathemas.contains { metathema in
          poiCategory.metathema == metathema
        } ? poiCategory : nil
      }
    // TODO: description
    case .metaquelle:
      guard let metaquelles = objects as? [String] else { poiCategories = []; return }
      poiCategories = poiCategories.compactMap { poiCategory in
        metaquelles.contains { metaquelle in
          poiCategory.metaquelle == metaquelle
        } ? poiCategory : nil
      }
    // TODO: description
    case .metainfodatum:
      guard let metainfodatums = objects as? [String] else { poiCategories = []; return }
      poiCategories = poiCategories.compactMap { poiCategory in
        metainfodatums.contains { metainfodatum in
          poiCategory.metainfodatum == metainfodatum
        } ? poiCategory : nil
      }
    /// flag to show the filter of the POI category
    case .showFilter:
      guard let showFilters = objects as? [Bool] else { poiCategories = []; return }
      poiCategories = poiCategories.compactMap { poiCategory in
        showFilters.contains { showFilter in
          poiCategory.showFilter == showFilter
        } ? poiCategory : nil
      }
    /// flist of possible filter fields of the POI category
    case .filterFields:
      guard let filterFieldsList = objects as? [[OSCAPoiCategory.FilterField]] else { poiCategories = []; return }
      poiCategories = poiCategories.compactMap { poiCategory in
        filterFieldsList.contains { filterFields in
          poiCategory.filterFields == filterFields
        } ? poiCategory : nil
      }
    case .sourceId:
      guard let sourceId = objects as? [String] else { poiCategories = []; return }
      poiCategories = poiCategories.compactMap { poiCategory in
        sourceId.contains { sourceId in
          poiCategory.sourceId == sourceId
        } ? poiCategory : nil
      }
    case .defaultThematicView:
      guard let defaultThematicView = objects as? [String] else { poiCategories = []; return }
      poiCategories = poiCategories.compactMap { poiCategory in
        defaultThematicView.contains { defaultThematicView in
          poiCategory.defaultThematicView == defaultThematicView
        } ? poiCategory : nil
      }
    } // end switch case
  } // end public static func filter poi categories by key objects
} // end extension public struct OSCAPOICategory

// MARK: - Symbol and Icon URL

extension OSCAPoiCategory {
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
} // end extension public struct OSCAPoiCategory

extension OSCAPoiCategory {
  /// Parse class name
  public static var parseClassName : String { return "POICategory" }
}// end extension OSCAPoiCategory
