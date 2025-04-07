//
//  OSCAPoiDetailGroup.swift
//  OSCAMap
//
//  Created by Mammut Nithammer on 24.08.22.
//

import Foundation

public struct OSCAPoiDetailGroup: Codable, Hashable {
  public var title: String
  public var values: [String]
  public var position: Int
  public var type: OSCAPoi.Detail.DetailType
}

public extension OSCAPoiDetailGroup {
    static func convert(from details: [OSCAPoi.Detail?]?) -> [OSCAPoiDetailGroup] {
    guard let details = details else {
      return []
    }

    let nonNilDetails = details.compactMap({ $0 })

    guard !nonNilDetails.isEmpty else { return [] }

    var result: [OSCAPoiDetailGroup] = []

    let titles = Array(Set(nonNilDetails.compactMap({ $0.title })))

    for title in titles {
      var values: [String] = []
      var detailsForTitle = nonNilDetails.filter({ $0.title == title })
      detailsForTitle.sort(by: { $0.position ?? 9999 < $1.position ?? 9999 })

      for detail in detailsForTitle {
        values.append(detail.subtitle != nil ? "\(detail.subtitle ?? ""): \(detail.value ?? "")" : detail.value ?? "")
      }

      guard let position = detailsForTitle.first?.position, let type = detailsForTitle.first?.type else { continue }
      result.append(OSCAPoiDetailGroup(title: title, values: values, position: position, type: type))
    }

    return result
  }
}
