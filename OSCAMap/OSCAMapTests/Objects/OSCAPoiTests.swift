//
//  OSCAPoiTests.swift
//  OSCAMapTests
//
//  Created by Stephan Breidenbach on 02.03.22.
//
#if canImport(XCTest) && canImport(OSCATestCaseExtension)
import Foundation
import OSCAEssentials
import OSCANetworkService
@testable import OSCAMap
import XCTest
import OSCATestCaseExtension

/// ```console
/// curl -X GET \
///  -H "X-Parse-Application-Id: APPLICATION_ID" \
///  -H "X-Parse-Client-Key: API_CLIENT_KEY" \
///  https://parse-dev.solingen.de/classes/POI \
///  | python3 -m json.tool
///  | pygmentize -g
///  ```
class OSCAPoiTests: OSCAParseClassObjectTestSuite<OSCAPoi> {
  
  override func setUpWithError() throws -> Void {
    try super.setUpWithError()
  }// end override func setupWithError
  
  override func tearDownWithError() throws -> Void {
    try super.tearDownWithError()
  }// end override func tearDownWithError
  
  /// Is there a file with the `JSON` scheme example data available?
  /// The file name has to match with the test class name: `OSCAPoiTests.json`
  override func testJSONDataAvailable() throws -> Void {
    try super.testJSONDataAvailable()
  }// end override func testJSONDataAvailable
#if DEBUG
  /// Is it possible to deserialize `JSON` scheme example data to an array  `OSCAPoi` 's?
  override func testDecodingJSONData() throws -> Void {
    try super.testDecodingJSONData()
  }// end override func testDecodingJSONData
#endif
  /// is it possible to fetch up to 1000 `OSCAPoi` objects in an array from network?
  override func testFetchAllParseObjects() throws -> Void {
    try super.testFetchAllParseObjects()
  }// end override func test testFetchAllParseObjects
  
  override func testFetchParseObjectSchema() throws -> Void {
    try super.testFetchParseObjectSchema()
  }// end override func test testFetchParseObjectSchema
  
  func testCompactMapPoisWithPoiCategories() throws -> Void {
    try testDecodingJSONData()
    let poiCategories: [OSCAPoiCategory] = [OSCAPoiCategory(objectId: "sport26",
                                                            createdAt: nil,
                                                            updatedAt: nil,
                                                            name: "TestOSCACategory",
                                                            mapTitle: "Test",
                                                            status: nil,
                                                            iconName: nil,
                                                            iconPath: nil,
                                                            iconMimetype: .none,
                                                            iconImageData: nil,
                                                            symbolName: nil, symbolPath: nil, symbolMimetype: .none, symbolImageData: nil, position: 0, showCategory: OSCAParse.BoolFromString(value: true), categoryVersion: nil, metathema: nil, metaquelle: nil, metainfodatum: nil, showFilter: OSCAParse.BoolFromString(value: false), filterFields: nil)]
    OSCAPoi.compactMap(pois: &sut, with: poiCategories)
    for poi in self.sut {
      XCTAssertEqual(poi.poiCategoryObject, poiCategories.first)
    }// end for each
  }// end func testCompactMapPoisWithPoiCategories
  
  func testCompactPoisByKey() throws -> Void {
    try testDecodingJSONData()
    for i in 0..<self.sut.count {
      if i % 2 == 0 {
        self.sut[i] = OSCAPoi(objectId: nil, createdAt: nil, updatedAt: nil, name: nil, address: nil, zip: nil, city: nil, district: nil, poiCategory: nil, showUserGeneratedContent: false, showRouteTo: false, routeType: nil, geopoint: nil, details: nil, images: nil, poiCategoryObject: nil, startGeopoint: nil)
      } else {
        //                let poi = self.sut[i]
        //                @OSCAParse.BoolFromDict var showUserGeneratedContent = poi.showUserGeneratedContent
        //                @OSCAParse.BoolFromDict var showRouteTo              = poi.showRouteTo
        //                self.sut[i] = OSCAPoi(objectId: poi.objectId, createdAt: poi.createdAt, updatedAt: poi.updatedAt, name: poi.name, address: poi.address, zip: poi.zip, city: poi.city, district: poi.district, poiCategory: poi.poiCategory, showUserGeneratedContent: showUserGeneratedContent, showRouteTo: showRouteTo, routeType: poi.routeType, geopoint: poi.geopoint, details: poi.details, images: poi.images, poiCategoryObject: poi.poiCategoryObject, startGeopoint: poi.startGeopoint)
        continue
      }// end if
    }// end for i
    var pois: [OSCAPoi] = self.sut
    /// Auto generated id
    OSCAPoi.compact(pois: &pois, by: .objectId)
    XCTAssertTrue(pois.count == 50)
    /// UTC date when the object was created
    pois = self.sut
    OSCAPoi.compact(pois: &pois, by: .createdAt)
    XCTAssertTrue(pois.count == 50)
    /// UTC date when the object was changed
    pois = self.sut
    OSCAPoi.compact(pois: &pois, by: .updatedAt)
    XCTAssertTrue(pois.count == 50)
    /// The name / title of the POI
    pois = self.sut
    OSCAPoi.compact(pois: &pois, by: .name)
    XCTAssertTrue(pois.count == 50)
    /// The street name and the street number of the POI
    pois = self.sut
    OSCAPoi.compact(pois: &pois, by: .address)
    XCTAssertTrue(pois.count == 50)
    /// The zip code of the POI
    pois = self.sut
    OSCAPoi.compact(pois: &pois, by: .zip)
    XCTAssertTrue(pois.count == 50)
    /// The city name of the POI
    pois = self.sut
    OSCAPoi.compact(pois: &pois, by: .city)
    XCTAssertTrue(pois.count == 50)
    /// the district name of the POI
    pois = self.sut
    OSCAPoi.compact(pois: &pois, by: .district)
    XCTAssertTrue(pois.count == 50)
    /// The unique `objectId` of `OSCAPoiCategory` object of the POI
    pois = self.sut
    OSCAPoi.compact(pois: &pois, by: .poiCategory)
    XCTAssertTrue(pois.count == 50)
    /// The flag to show user generated content of the POI
    pois = self.sut
    OSCAPoi.compact(pois: &pois, by: .showUserGeneratedContent)
    XCTAssertTrue(pois.count == 50)
    /// The flag to show the route to of the POI
    pois = self.sut
    OSCAPoi.compact(pois: &pois, by: .showRouteTo)
    XCTAssertTrue(pois.count == 50)
    /// The route type of the POI
    pois = self.sut
    OSCAPoi.compact(pois: &pois, by: .routeType)
    XCTAssertTrue(pois.count == 50)
    /// The geo location point of the POI
    pois = self.sut
    OSCAPoi.compact(pois: &pois, by: .geopoint)
    XCTAssertTrue(pois.count == 50)
    /// More details of the POI
    pois = self.sut
    OSCAPoi.compact(pois: &pois, by: .details)
    XCTAssertTrue(pois.count == 50)
    /// The associated images of the POI
    pois = self.sut
    OSCAPoi.compact(pois: &pois, by: .images)
    XCTAssertTrue(pois.count == 50)
    /// poi category object of the POI
    pois = self.sut
    OSCAPoi.compact(pois: &pois, by: .poiCategoryObject)
    XCTAssertTrue(pois.count == 0)
    /// The geo location point from where to start a route from
    pois = self.sut
    OSCAPoi.compact(pois: &pois, by: .startGeopoint)
    XCTAssertTrue(pois.count == 0)
  }// end func testCompactPoisByKey
  
  func testFilterPoisByKeyWhereObject() throws -> Void {
    try testDecodingJSONData()
    var pois: [OSCAPoi] = self.sut
    /// Auto generated id
    var i = Int.random(in: 0..<self.sut.count)
    guard let objectId = self.sut[i].objectId else {
      XCTFail("objectId at index: \(i) is nil")
      return }
    OSCAPoi.filter(pois: &pois, by: .objectId, object: objectId)
    XCTAssertTrue(pois.count == 1)
    XCTAssertEqual(pois.first, self.sut[i])
    /// UTC date when the object was created
    i = Int.random(in: 0..<self.sut.count)
    guard let createdAt = self.sut[i].createdAt else {
      XCTFail("createdAt at index: \(i) is nil")
      return }
    pois = self.sut
    OSCAPoi.filter(pois: &pois, by: .createdAt, object: createdAt)
    XCTAssertEqual(pois.first, self.sut[i])
    /// UTC date when the object was changed
    i = Int.random(in: 0..<self.sut.count)
    guard let updatedAt = self.sut[i].updatedAt else {
      XCTFail("updatedAt at index: \(i) is nil")
      return }
    pois = self.sut
    OSCAPoi.filter(pois: &pois, by: .updatedAt, object: updatedAt)
    XCTAssertEqual(pois.first, self.sut[i])
    /// The name / title of the POI
    i = Int.random(in: 0..<self.sut.count)
    guard let name = self.sut[i].name else {
      XCTFail("name at index: \(i) is nil")
      return }
    pois = self.sut
    OSCAPoi.filter(pois: &pois, by: .name, object: name)
    XCTAssertEqual(pois.first, self.sut[i])
    /// The street name and the street number of the POI
    i = Int.random(in: 0..<self.sut.count)
    guard let address = self.sut[i].address else {
      XCTFail("address at index: \(i) is nil")
      return }
    pois = self.sut
    OSCAPoi.filter(pois: &pois, by: .address, object: address)
    for poi in pois {
      XCTAssertEqual(poi.address, self.sut[i].address)
    }
    /// The zip code of the POI
    i = Int.random(in: 0..<self.sut.count)
    guard let zip = self.sut[i].zip else {
      XCTFail("zip at index: \(i) is nil")
      return }
    pois = self.sut
    OSCAPoi.filter(pois: &pois, by: .zip, object: zip)
    for poi in pois {
      XCTAssertEqual(poi.zip, self.sut[i].zip)
    }
    /// The city name of the POI
    i = Int.random(in: 0..<self.sut.count)
    guard let city = self.sut[i].city else {
      XCTFail("city at index: \(i) is nil")
      return }
    pois = self.sut
    OSCAPoi.filter(pois: &pois, by: .city, object: city)
    for poi in pois {
      XCTAssertEqual(poi.city, self.sut[i].city)
    }
    /// the district name of the POI
    i = Int.random(in: 0..<self.sut.count)
    guard let district = self.sut[i].district else {
      XCTFail("district at index: \(i) is nil")
      return }
    pois = self.sut
    OSCAPoi.filter(pois: &pois, by: .district, object: district)
    for poi in pois {
      XCTAssertEqual(poi.city, self.sut[i].city)
    }
    /// The unique `objectId` of `OSCAPoiCategory` object of the POI
    i = Int.random(in: 0..<self.sut.count)
    guard let poiCategory = self.sut[i].poiCategory else {
      XCTFail("poiCategory at index: \(i) is nil")
      return }
    pois = self.sut
    OSCAPoi.filter(pois: &pois, by: .poiCategory, object: poiCategory)
    for poi in pois {
      XCTAssertEqual(poi.city, self.sut[i].city)
    }
    /// The flag to show user generated content of the POI
    i = Int.random(in: 0..<self.sut.count)
    let showUserGeneratedContent = self.sut[i].showUserGeneratedContent
    pois = self.sut
    OSCAPoi.filter(pois: &pois, by: .showUserGeneratedContent, object: showUserGeneratedContent)
    for poi in pois {
      XCTAssertEqual(poi.city, self.sut[i].city)
    }
    /// The flag to show the route to of the POI
    i = Int.random(in: 0..<self.sut.count)
    let showRouteTo = self.sut[i].showRouteTo
    pois = self.sut
    OSCAPoi.filter(pois: &pois, by: .showRouteTo, object: showRouteTo)
    for poi in pois {
      XCTAssertEqual(poi.city, self.sut[i].city)
    }
    /// The route type of the POI
    i = Int.random(in: 0..<self.sut.count)
    guard let routeType = self.sut[i].routeType else {
      XCTFail("routeType at index: \(i) is nil")
      return }
    pois = self.sut
    OSCAPoi.filter(pois: &pois, by: .routeType, object: routeType)
    for poi in pois {
      XCTAssertEqual(poi.city, self.sut[i].city)
    }
    /// The geo location point of the POI
    i = Int.random(in: 0..<self.sut.count)
    guard let geopoint = self.sut[i].geopoint else {
      XCTFail("geopoint at index: \(i) is nil")
      return }
    pois = self.sut
    OSCAPoi.filter(pois: &pois, by: .geopoint, object: geopoint)
    XCTAssertEqual(pois.first, self.sut[i])
    /// More details of the POI
    i = Int.random(in: 0..<self.sut.count)
    guard let details = self.sut[i].details else {
      XCTFail("details at index: \(i) is nil")
      return }
    pois = self.sut
    OSCAPoi.filter(pois: &pois, by: .details, object: details)
    XCTAssertEqual(pois.first, self.sut[i])
    /// The associated images of the POI
    i = Int.random(in: 0..<self.sut.count)
    guard let images = self.sut[i].images else {
      XCTFail("images at index: \(i) is nil")
      return }
    pois = self.sut
    OSCAPoi.filter(pois: &pois, by: .images, object: images)
    XCTAssertEqual(pois.first, self.sut[i])
  }// end func testFilterPoisByKeyWhereObject
}// end class OSCAPoiTests
#endif
