//
//  OSCAMap+DIContainer.swift
//  OSCAMap
//
//  Created by Stephan Breidenbach on 01.03.22.
//  Reviewed by Stephan Breidenbach on 11.08.2022
//

import Foundation

extension OSCAMap {
  final class DIContainer {
    private let dependencies: OSCAMap.Dependencies
    
    public init(dependencies: OSCAMap.Dependencies) {
      self.dependencies = dependencies
    }// end public init
  }// end final class DIContainer
}// end extension public struct OSCAMap
