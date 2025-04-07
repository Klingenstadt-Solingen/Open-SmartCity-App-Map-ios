//
//  UserDefaults.swift
//  OSCAMap
//
//  Created by Ömer Kurutay on 07.06.23.
//

import Foundation

// MARK: Push
extension UserDefaults {
  public func setOSCAMapConstructionSitesPush(notification isPushing: Bool) {
    self.set(isPushing, forKey: OSCAMap.Keys.userDefaultsMapConstructionSitesPush.rawValue)
    NotificationCenter.default.post(name: .mapConstructionSitesPushDidChange, object: nil, userInfo: nil)
  }
  
  public func isOSCAMapConstructionSitesPushingNotification() -> Bool {
    self.bool(forKey: OSCAMap.Keys.userDefaultsMapConstructionSitesPush.rawValue)
  }
}
