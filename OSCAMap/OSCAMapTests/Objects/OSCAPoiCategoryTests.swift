//
//  OSCAPoiCategoryTests.swift
//  OSCAMapTests
//
//  Created by Stephan Breidenbach on 02.03.22.
//
#if canImport(XCTest) && canImport(OSCATestCaseExtension)
import Foundation
import OSCAEssentials
@testable import OSCAMap
import XCTest
import OSCATestCaseExtension
import OSCANetworkService

class OSCAPoiCategoryTests: OSCAParseClassObjectTestSuite<OSCAPoiCategory> {
  override func setUpWithError() throws -> Void {
    try super.setUpWithError()
  }// end override func setupWithError
  
  override func tearDownWithError() throws -> Void {
    try super.tearDownWithError()
  }// end override func tearDownWithError
  
  /// Is there a file with the `JSON` scheme example data available?
  /// The file name has to match with the test class name: `OSCAPoiCategoryTests.json`
  override func testJSONDataAvailable() throws -> Void {
    try super.testJSONDataAvailable()
  }// end override func testJSONDataAvailable
#if DEBUG
  /// Is it possible to deserialize `JSON` scheme example data to an array  `OSCAPoiCategory` 's?
  override func testDecodingJSONData() throws -> Void {
    try super.testDecodingJSONData()
  }// end override func testDecodingJSONData
#endif
  /// is it possible to fetch up to 1000 `OSCAPoiCategory` objects in an array from network?
  override func testFetchAllParseObjects() throws -> Void {
    try super.testFetchAllParseObjects()
  }// end override func test testFetchAllParseObjects
  
  override func testFetchParseObjectSchema() throws -> Void {
    try super.testFetchParseObjectSchema()
  }// end override func test testFetchParseObjectSchema
  
  
  func testSortByShowCategory() throws -> Void {
    try testDecodingJSONData()
    OSCAPoiCategory.sort(poiCategories: &self.sut, by: .showCategory)
    let compactMapped: [String] = self.sut.compactMap { $0.objectId }
    let expected: [String] = [ "sport29","sport27","sport28","sport26" ]
    XCTAssertEqual(compactMapped, expected)
  }// end func testSortByShowCategory
  
  func testSortByPosition() throws -> Void {
    try testDecodingJSONData()
    OSCAPoiCategory.sort(poiCategories: &self.sut, by: .position)
    let compactMapped: [String] = self.sut.compactMap { $0.objectId }
    let expected: [String] = [ "sport28","sport27","sport26" ]
    XCTAssertEqual(compactMapped, expected)
  }// end testSortByPosition
  
  func testContainsByKeyObject() throws -> Void {
    try testDecodingJSONData()
    let poiCategories = self.sut!
    let poiCategory = poiCategories[1]
    // test objectId
    if let objectId = poiCategory.objectId {
      XCTAssertTrue(OSCAPoiCategory.contains(poiCategories: poiCategories, by: .objectId, object: objectId))
    }// end if
    
    // test name
    if let name = poiCategory.name {
      XCTAssertTrue(OSCAPoiCategory.contains(poiCategories: poiCategories, by: .name, object: name))
    }// end if
    
    // test mapTitle
    if let mapTitle = poiCategory.mapTitle {
      XCTAssertTrue(OSCAPoiCategory.contains(poiCategories: poiCategories, by: .mapTitle, object: mapTitle))
    }// end if
    
    // test status
    if let status = poiCategory.status {
      XCTAssertTrue(OSCAPoiCategory.contains(poiCategories: poiCategories, by: .status, object: status))
    }// end if
    
    // test iconName
    if let iconName = poiCategory.iconName {
      XCTAssertTrue(OSCAPoiCategory.contains(poiCategories: poiCategories, by: .iconName, object: iconName))
    }// end if
    
    // test iconPath
    if let iconPath = poiCategory.iconPath {
      XCTAssertTrue(OSCAPoiCategory.contains(poiCategories: poiCategories, by: .iconPath, object: iconPath))
    }// end if
    
    // test iconMimetype
    if let iconMimetype = poiCategory.iconMimetype {
      XCTAssertTrue(OSCAPoiCategory.contains(poiCategories: poiCategories, by: .iconMimetype, object:
                                              iconMimetype))
    }// end if
    
    // test symbolName
    if let symbolName = poiCategory.symbolName {
      XCTAssertTrue(OSCAPoiCategory.contains(poiCategories: poiCategories, by: .symbolName, object: symbolName))
    }// end if
    
    // test symbolPath
    if let symbolPath = poiCategory.symbolPath {
      XCTAssertTrue(OSCAPoiCategory.contains(poiCategories: poiCategories, by: .symbolPath, object: symbolPath))
    }// end if
    
    // test symbolMimetype
    if let symbolMimetype = poiCategory.symbolMimetype {
      XCTAssertTrue(OSCAPoiCategory.contains(poiCategories: poiCategories, by: .symbolMimetype, object: symbolMimetype))
    }// end if
    
    // test position
    if let position = poiCategory.position {
      XCTAssertTrue(OSCAPoiCategory.contains(poiCategories: poiCategories, by: .position, object: position))
    }// end if
    
    // test showCategory
    if let showCategory = poiCategory.showCategory {
      XCTAssertTrue(OSCAPoiCategory.contains(poiCategories: poiCategories, by: .showCategory, object: showCategory))
    }// end if
    
    // test categoryVersion
    if let categoryVersion = poiCategory.categoryVersion {
      XCTAssertTrue(OSCAPoiCategory.contains(poiCategories: poiCategories, by: .categoryVersion, object: categoryVersion))
    }// end if
    
    // test metathema
    if let metathema = poiCategory.metathema {
      XCTAssertTrue(OSCAPoiCategory.contains(poiCategories: poiCategories, by: .metathema, object: metathema))
    }// end if
    
    // test metaquelle
    if let metaquelle = poiCategory.metaquelle {
      XCTAssertTrue(OSCAPoiCategory.contains(poiCategories: poiCategories, by: .metaquelle, object: metaquelle))
    }// end if
    
    // test metainfodatum
    if let metainfodatum = poiCategory.metainfodatum {
      XCTAssertTrue(OSCAPoiCategory.contains(poiCategories: poiCategories, by: .metainfodatum, object: metainfodatum))
    }// end if
    
    // test showFilter
    if let showFilter = poiCategory.showFilter {
      XCTAssertTrue(OSCAPoiCategory.contains(poiCategories: poiCategories, by: .showFilter, object: showFilter))
    }// end if
    
    // test createdAt
    if let createdAt = poiCategory.createdAt {
      XCTAssertTrue(OSCAPoiCategory.contains(poiCategories: poiCategories, by: .createdAt, object: createdAt))
    }// end if
    
    // test updatedAt
    if let updatedAt = poiCategory.updatedAt {
      XCTAssertTrue(OSCAPoiCategory.contains(poiCategories: poiCategories, by: .updatedAt, object: updatedAt))
    }// end if
  }// end testContainsByKeyObject
  
  func testFilterPoiCategoriesByKeyWhereObject() throws -> Void {
    try testDecodingJSONData()
    var poiCategories: [OSCAPoiCategory] = self.sut
    var i = Int.random(in: 0..<self.sut.count)
    guard let objectId = self.sut[i].objectId else {
      XCTFail("objectId at index: \(i) is nil")
      return
    }
    OSCAPoiCategory.filter(poiCategories: &poiCategories, by: .objectId, object: objectId)
    XCTAssertTrue(poiCategories.count == 1)
    XCTAssertEqual(poiCategories.first, self.sut[i])
    /// UTC date when the object was created
    // case createdAt
    i = Int.random(in: 0..<self.sut.count)
    guard let createdAt = self.sut[i].createdAt else {
      XCTFail("createdAt at index: \(i) is nil")
      return }
    poiCategories = self.sut
    OSCAPoiCategory.filter(poiCategories: &poiCategories, by: .createdAt, object: createdAt)
    XCTAssertTrue(poiCategories.count == 4)
    /// UTC date when the object was changed
    // case updatedAt
    i = Int.random(in: 0..<self.sut.count)
    guard let updatedAt = self.sut[i].updatedAt else {
      XCTFail("updatedAt at index: \(i) is nil")
      return }
    poiCategories = self.sut
    OSCAPoiCategory.filter(poiCategories: &poiCategories, by: .updatedAt, object: updatedAt)
    XCTAssertTrue(poiCategories.count == 4)
    /// name / title of the POI category
    // case name
    i = Int.random(in: 0..<self.sut.count)
    guard let name = self.sut[i].name else {
      XCTFail("name at index: \(i) is nil")
      return }
    poiCategories = self.sut
    OSCAPoiCategory.filter(poiCategories: &poiCategories, by: .name, object: name)
    XCTAssertEqual(poiCategories.first, self.sut[i])
    /// title of the map of the POI category
    // case mapTitle
    i = Int.random(in: 0..<self.sut.count)
    guard let mapTitle = self.sut[i].mapTitle else {
      XCTFail("mapTitle at index: \(i) is nil")
      return }
    poiCategories = self.sut
    OSCAPoiCategory.filter(poiCategories: &poiCategories, by: .mapTitle, object: mapTitle)
    XCTAssertEqual(poiCategories.first, self.sut[i])
    // TODO: description
    // case status
    i = Int.random(in: 0..<self.sut.count)
    guard let status = self.sut[i].status else {
      XCTFail("status at index: \(i) is nil")
      return }
    poiCategories = self.sut
    OSCAPoiCategory.filter(poiCategories: &poiCategories, by: .status, object: status)
    XCTAssertTrue(poiCategories.count == 4)
    /// icon name ot the POI category
    // case iconName
    i = Int.random(in: 0..<self.sut.count)
    guard let iconName = self.sut[i].iconName else {
      XCTFail("iconName at index: \(i) is nil")
      return }
    poiCategories = self.sut
    OSCAPoiCategory.filter(poiCategories: &poiCategories, by: .iconName, object: iconName)
    XCTAssertEqual(poiCategories.first, self.sut[i])
    /// icon path from where to download, of the POI category
    // case iconPath
    i = Int.random(in: 0..<self.sut.count)
    guard let iconPath = self.sut[i].iconPath else {
      XCTFail("iconPath at index: \(i) is nil")
      return }
    poiCategories = self.sut
    OSCAPoiCategory.filter(poiCategories: &poiCategories, by: .iconPath, object: iconPath)
    XCTAssertTrue(poiCategories.count == 4)
    /// icon MIME type of the POI category
    // case iconMimetype
    i = Int.random(in: 0..<self.sut.count)
    guard let iconMimetype = self.sut[i].iconMimetype else {
      XCTFail("iconMimetype at index: \(i) is nil")
      return }
    poiCategories = self.sut
    OSCAPoiCategory.filter(poiCategories: &poiCategories, by: .iconMimetype, object: iconMimetype)
    XCTAssertTrue(poiCategories.count == 4)
    /// icon image data of the POI category
    // case iconImageData
    
    /// symbol name for the map Pin of the POI category
    // case symbolName
    i = Int.random(in: 0..<self.sut.count)
    guard let symbolName = self.sut[i].symbolName else {
      XCTFail("symbolName at index: \(i) is nil")
      return }
    poiCategories = self.sut
    OSCAPoiCategory.filter(poiCategories: &poiCategories, by: .symbolName, object: symbolName)
    XCTAssertEqual(poiCategories.first, self.sut[i])
    /// symbol path from where to download, of the POI category
    // case symbolPath
    i = Int.random(in: 0..<self.sut.count)
    guard let symbolPath = self.sut[i].symbolPath else {
      XCTFail("symbolPath at index: \(i) is nil")
      return }
    poiCategories = self.sut
    OSCAPoiCategory.filter(poiCategories: &poiCategories, by: .symbolPath, object: symbolPath)
    XCTAssertTrue(poiCategories.count == 4)
    /// symbol MIME type of the POI category
    // case symbolMimetype
    i = Int.random(in: 0..<self.sut.count)
    guard let symbolMimetype = self.sut[i].symbolMimetype else {
      XCTFail("symbolMimetype at index: \(i) is nil")
      return }
    poiCategories = self.sut
    OSCAPoiCategory.filter(poiCategories: &poiCategories, by: .symbolMimetype, object: symbolMimetype)
    XCTAssertTrue(poiCategories.count == 4)
    /// symbol image data of the POI category
    // case symbolImageData
    
    /// position where to show the POI category
    // case position
    i = Int.random(in: 0..<self.sut.count)
    guard let position = self.sut[i].position else {
      XCTFail("position at index: \(i) is nil")
      return }
    poiCategories = self.sut
    OSCAPoiCategory.filter(poiCategories: &poiCategories, by: .position, object: position)
    XCTAssertEqual(poiCategories.first, self.sut[i])
    /// flag to show the POI category
    // case showCategory
    
    /// version string of the POI category
    // case categoryVersion
    
    // TODO: description
    // case metathema
    i = Int.random(in: 0..<self.sut.count)
    guard let metathema = self.sut[i].metathema else {
      XCTFail("metathema at index: \(i) is nil")
      return }
    poiCategories = self.sut
    OSCAPoiCategory.filter(poiCategories: &poiCategories, by: .metathema, object: metathema)
    XCTAssertEqual(poiCategories.first, self.sut[i])
    // TODO: description
    // case metaquelle
    
    // TODO: description
    // case metainfodatum
    
    /// flag to show the filter of the POI category
    // case showFilter
    i = Int.random(in: 0..<self.sut.count)
    guard let showFilter = self.sut[i].showFilter else {
      XCTFail("showFilter at index: \(i) is nil")
      return }
    poiCategories = self.sut
    OSCAPoiCategory.filter(poiCategories: &poiCategories, by: .showFilter, object: showFilter)
    XCTAssertEqual(poiCategories.first, self.sut[i])
    /// flist of possible filter fields of the POI category
    // case filterFields
    i = Int.random(in: 0..<self.sut.count)
    guard let filterFields = self.sut[i].filterFields else {
      XCTFail("filterFields at index: \(i) is nil")
      return }
    poiCategories = self.sut
    OSCAPoiCategory.filter(poiCategories: &poiCategories, by: .filterFields, object: filterFields)
    XCTAssertEqual(poiCategories.first, self.sut[i])
  }// end func testFilterPoiCategoriesByKeyWhereObject
  
  func testFilterPoiCategoriesByKeyWhereObjects() throws -> Void {
    try testDecodingJSONData()
    var poiCategories: [OSCAPoiCategory] = self.sut
    let subSut = self.sut[0...1]
    guard !subSut.isEmpty,
          let objectId0 = subSut[0].objectId,
          let objectId1 = subSut[1].objectId
    else {
      XCTFail("objectId is nil")
      return
    }
    let objectIds: [String] = [objectId0, objectId1]
    OSCAPoiCategory.filter(poiCategories: &poiCategories, by: .objectId, objects: objectIds)
    XCTAssertEqual(poiCategories[0], subSut[0])
    XCTAssertEqual(poiCategories[1], subSut[1])
  }// end func testFilterPoiCategoriesByKeyWhereObjects
}// end class OSCAPoiCategoryTests
#endif
