#if canImport(XCTest) && canImport(OSCATestCaseExtension)
import XCTest
@testable import OSCAMap
import OSCANetworkService
import OSCATestCaseExtension
import OSCAEssentials
import Combine

final class OSCAMapTests: XCTestCase {
  static let moduleVersion = "1.0.4"
  private var cancellables: Set<AnyCancellable>!
  override func setUpWithError() throws -> Void {
    try super.setUpWithError()
    // initialize cancellabels
    self.cancellables = []
  }// end func setUpWithError
  
  override func tearDownWithError() throws -> Void {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    try super.tearDownWithError()
    guard let cancellabels = self.cancellables
    else { return }
    if !cancellabels.isEmpty {
      for cancellable in cancellabels {
        cancellable.cancel()
      }// end for
      self.cancellables = nil
    }// end if
  }// end override func tearDownWithError
  
  func testModuleInit() throws -> Void {
    let module = try makeDevModule()
    XCTAssertNotNil(module)
    XCTAssertEqual(module.version, OSCAMapTests.moduleVersion)
    XCTAssertEqual(module.bundlePrefix, "de.osca.map")
    let bundle = OSCAMap.bundle
    XCTAssertNotNil(bundle)
    XCTAssertNotNil(self.devPlistDict)
    XCTAssertNotNil(self.productionPlistDict)
  }// end func testModuleInit
  
  func testTransformError() throws -> Void {
    let module = try makeDevModule()
    XCTAssertEqual(module.transformError(OSCANetworkError.invalidResponse), OSCAMapError.networkInvalidResponse)
    XCTAssertEqual(module.transformError(OSCANetworkError.invalidRequest), OSCAMapError.networkInvalidRequest)
    let testData = Data([1,2,3])
    XCTAssertEqual(module.transformError(OSCANetworkError.dataLoadingError(statusCode: 1, data: testData)), OSCAMapError.networkDataLoading(statusCode: 1, data: testData))
    let error: Error = OSCAMapError.networkInvalidResponse
    XCTAssertEqual(module.transformError(OSCANetworkError.jsonDecodingError(error: error)), OSCAMapError.networkJSONDecoding(error: error))
    XCTAssertEqual(module.transformError(OSCANetworkError.isInternetConnectionError),OSCAMapError.networkIsInternetConnectionFailure)
  }// end func testTransformError
  
  func testFetchAllPOIs() throws -> Void {
    var pois: [OSCAPoi] = []
    var error: Error?
    let maxCount: Int = 100
    
    let expectation = self.expectation(description: "fetchAllPOIs")
    let module = try makeDevModule()
    XCTAssertNotNil(module)
    module.fetchAllPOIs(maxCount: maxCount)
      .sink { completion in
        switch completion {
        case .finished:
          expectation.fulfill()
        case let .failure(encounteredError):
          error = encounteredError
          expectation.fulfill()
        }// end switch completion
      } receiveValue: { allPOIsFromNetwork in
        pois = allPOIsFromNetwork
      }// end sink
      .store(in: &self.cancellables)
    
    waitForExpectations(timeout: 10)
    
    XCTAssertNil(error)
    XCTAssertTrue(pois.count == maxCount)
  }// end func testFetchAllPOIs
  
  func testFetchAllPOICategories() throws -> Void {
    var poiCategories: [OSCAPoiCategory] = []
    var error: Error?
    let maxCount: Int = 100
    
    let expectation = self.expectation(description: "fetchAllPOICategories")
    let module = try makeDevModule()
    XCTAssertNotNil(module)
    module.fetchAllPOICategories(maxCount: maxCount)
      .sink { completion in
        switch completion {
        case .finished:
          expectation.fulfill()
        case let .failure(encounteredError):
          error = encounteredError
          expectation.fulfill()
        }// end switch completion
      } receiveValue: { allPOICategoriesFromNetwork in
        poiCategories = allPOICategoriesFromNetwork
      }// end sink
      .store(in: &self.cancellables)
    
    waitForExpectations(timeout: 10)
    
    XCTAssertNil(error)
    XCTAssertTrue(poiCategories.count == maxCount)
  }// end func testFetchAllPOICategories
  
  func testElasticSearchRaw() throws -> Void {
    var resultItems: [OSCAPoi.SearchResult.Item] = []
    var error: Error?
    
    let expectation = self.expectation(description: "ElasticSearchPOIRaw")
    let module = try makeDevModule()
    XCTAssertNotNil(module)
    let publisher: AnyPublisher<[OSCAPoi.SearchResult.Item], OSCAMapError> = module.elasticSearch(for: "Blumen")
    publisher
      .sink { completion in
        switch completion {
        case .finished:
          expectation.fulfill()
        case let .failure(encounteredError):
          error = encounteredError
          expectation.fulfill()
        }// end switch completion
      } receiveValue: { resultItemsFromNetwork in
        resultItems = resultItemsFromNetwork
      }// end sink
      .store(in: &self.cancellables)
    
    waitForExpectations(timeout: 10)
    XCTAssertNil(error)
    XCTAssertTrue(!resultItems.isEmpty)
  }// end func testElasticSearchRaw
  
  func testElasticSearchPoi() throws -> Void {
    var pois: [OSCAPoi] = []
    var error: Error?
    
    let expectation = self.expectation(description: "ElasticSearchPOI")
    let module = try makeDevModule()
    XCTAssertNotNil(module)
    let publisher: AnyPublisher<[OSCAPoi], OSCAMapError> = module.elasticSearch(for: "Blumen")
    publisher
      .sink { completion in
        switch completion {
        case .finished:
          expectation.fulfill()
        case let .failure(encounteredError):
          error = encounteredError
          expectation.fulfill()
        }// end switch completion
      } receiveValue: { poisFromNetwork in
        pois = poisFromNetwork
      }// end sink
      .store(in: &self.cancellables)
    
    waitForExpectations(timeout: 10)
    XCTAssertNil(error)
    XCTAssertTrue(!pois.isEmpty)
  }// end func testElasticSearch
  
  func testFetchAllFilterFieldsOfPoiCategory() throws -> Void {
    var filterFields: [OSCAPoiCategory.FilterField] = []
    var error: Error?
    let module = try makeDevModule()
    let poiCategory = try makePoiCategory()
    XCTAssertNotNil(module)
    XCTAssertNotNil(poiCategory)
    let expectation = self.expectation(description: "FetchAllFilterFieldsOfPoiCategory")
    let publisher: AnyPublisher<[OSCAPoiCategory.FilterField], OSCAMapError> = module.fetchAllFilterFields(for: poiCategory)
    publisher
      .sink { completion in
        switch completion {
        case .finished:
          expectation.fulfill()
        case let .failure(encounteredError):
          error = encounteredError
          expectation.fulfill()
        }// end switch completion
      } receiveValue: { filterFieldsFromNetwork in
        filterFields = filterFieldsFromNetwork
      }// end sink
      .store(in: &self.cancellables)
    waitForExpectations(timeout: 10)
    XCTAssertNil(error)
    XCTAssertTrue(!filterFields.isEmpty)
  }// end func testFetchAllFilterFieldsOfPoiCategory
  
  func testFetchAllFilteredPoisOfPoiCategory() throws -> Void {
    var pois: [OSCAPoi]?
    var error: Error?
    let module = try makeDevModule()
    let poiCategory = try makePoiCategory()
    let poiCategoryFilterFields = try makeFilterFields(of: poiCategory)
    XCTAssertNotNil(module)
    XCTAssertNotNil(poiCategory)
    var filterFields: [OSCAPoi.Detail.FilterField] = []
    
    filterFields = poiCategoryFilterFields.compactMap {
      guard let value = $0.values?.first
      else { return nil }
      return OSCAPoi.Detail.FilterField(field: $0.field, value: value)
    }// end compactMap closure
    
    let expectation = self.expectation(description: "FetchAllFilteredPoisofPoiCategory")
    let publisher: AnyPublisher<OSCAPoi.Filter.Result, OSCAMapError> = module.fetchAllFilteredPois(for: poiCategory, with: filterFields)
    publisher
      .sink { completion in
        switch completion {
        case .finished:
          expectation.fulfill()
        case let .failure(encounteredError):
          error = encounteredError
          expectation.fulfill()
        }// end switch completion
      } receiveValue: { poiFilterResultFromNetwork in
        guard let count = poiFilterResultFromNetwork.count,
              let items = poiFilterResultFromNetwork.items,
              items.count == count
        else { XCTFail("Wrong poi filter results from network!"); return }
        pois = items
      }// end sink
      .store(in: &self.cancellables)
    waitForExpectations(timeout: 10)
    XCTAssertNil(error)
    XCTAssertNotNil(pois)
  }// end func testFetchAllFilteredPoisOfPoiCategory
  
  func testFetchAllFilteredPoisOfPoiCategoryWithEmptyFilter() throws -> Void {
    var pois: [OSCAPoi]?
    var error: Error?
    let module = try makeDevModule()
    let poiCategory = try makePoiCategory()
    XCTAssertNotNil(module)
    XCTAssertNotNil(poiCategory)
    // empty filter
    let filterFields: [OSCAPoi.Detail.FilterField] = []
    
    let expectation = self.expectation(description: "FetchAllFilteredPoisofPoiCategoryWithEmptyFilter")
    
    let operationQueue = OSCAScheduler.backgroundWorkScheduler
    
    
    let publisher: AnyPublisher<OSCAPoi.Filter.Result, OSCAMapError> = module.fetchAllFilteredPois(for: poiCategory, with: filterFields)
    
    publisher
      .sink { completion in
        switch completion {
        case .finished:
          expectation.fulfill()
        case let .failure(encounteredError):
          error = encounteredError
          expectation.fulfill()
        }// end switch completion
      } receiveValue: { poiFilterResultFromNetwork in
        guard let count = poiFilterResultFromNetwork.count,
              let items = poiFilterResultFromNetwork.items,
              items.count == count
        else { XCTFail("Wrong poi filter results from network!"); return }
        pois = items
      }// end sink
      .store(in: &self.cancellables)
    waitForExpectations(timeout: 10)
    XCTAssertNil(error)
    XCTAssertNotNil(pois)
  }// end func testFetchAllFilteredPoisOfPoiCategoryWithEmptyFilter
  
  func testWrapperFetchAllFilteredPoisOfPoiCategory() throws -> Void {
    var pois: [OSCAPoi]?
    var error: Error?
    let module = try makeDevModule()
    let poiCategory = try makePoiCategory()
    let poiCategoryFilterFields = try makeFilterFields(of: poiCategory)
    XCTAssertNotNil(module)
    XCTAssertNotNil(poiCategory)
    var filterFields: [OSCAPoi.Detail.FilterField] = []
    
    filterFields = poiCategoryFilterFields.compactMap {
      guard let value = $0.values?.first
      else { return nil }
      return OSCAPoi.Detail.FilterField(field: $0.field, value: value)
    }// end compactMap closure
    
    let expectation = self.expectation(description: "FetchAllFilteredPoisofPoiCategory")
    let publisher: OSCAMap.OSCAMapPublisher = module.fetchAllFilteredPois(for: poiCategory, with: filterFields)
    publisher
      .sink { completion in
        switch completion {
        case .finished:
          expectation.fulfill()
        case let .failure(encounteredError):
          error = encounteredError
          expectation.fulfill()
        }// end switch completion
      } receiveValue: { poisFromNetwork in
        pois = poisFromNetwork
      }// end sink
      .store(in: &self.cancellables)
    waitForExpectations(timeout: 10)
    XCTAssertNil(error)
    XCTAssertNotNil(pois)
  }// end func testWrapperFetchAllFilteredPoisOfPoiCategory
  
  func testWrapperFetchAllFilteredPoisOfPoiCategoryEmptyFilter() throws -> Void {
    var pois: [OSCAPoi]?
    var error: Error?
    let module = try makeDevModule()
    let poiCategory = try makePoiCategory()
    XCTAssertNotNil(module)
    XCTAssertNotNil(poiCategory)
    // empty filter
    let filterFields: [OSCAPoi.Detail.FilterField] = []
    
    let expectation = self.expectation(description: "FetchAllFilteredPoisofPoiCategoryWithEmptyFilter")
    let publisher: OSCAMap.OSCAMapPublisher = module.fetchAllFilteredPois(for: poiCategory, with: filterFields)
    publisher
      .sink { completion in
        switch completion {
        case .finished:
          expectation.fulfill()
        case let .failure(encounteredError):
          error = encounteredError
          expectation.fulfill()
        }// end switch completion
      } receiveValue: { poisFromNetwork in
        pois = poisFromNetwork
      }// end sink
      .store(in: &self.cancellables)
    waitForExpectations(timeout: 600)
    XCTAssertNil(error)
    XCTAssertNotNil(pois)
  }// end testWrapperFetchAllFilteredPoisOfPoiCategoryEmptyFilter
  
  func testFetchDefaultCategories() throws -> Void {
    var categories: [OSCAPoiCategory]?
    let defaultCategories: OSCAPoiCategory.DefaultCategories = OSCAPoiCategory.DefaultCategories.init(list: ["Einkaufen","Baustelle","Spielplatz","Freifunk"])
    var error: Error?
    let module = try makeDevModule()
    XCTAssertNotNil(module)
    let expectation = self.expectation(description: "FetchDefaultPOICategories")
    let publisher: AnyPublisher<[OSCAPoiCategory], OSCAMapError> = module.fetchDefaultCategories(defaultCategories)
    publisher
      .sink { completion in
        switch completion {
        case .finished:
          expectation.fulfill()
        case let .failure(encounteredError):
          error = encounteredError
          expectation.fulfill()
        }// end switch completion
      } receiveValue: { poiCategoryResultFromNetwork in
        categories = poiCategoryResultFromNetwork
      }// end sink
      .store(in: &self.cancellables)
    waitForExpectations(timeout: 10)
    XCTAssertNil(error)
    XCTAssertNotNil(categories)
  }// end func testFetchDefaultCategories
}// end final class OSCAMapTests


// MARK: - factory methods
extension OSCAMapTests {
  public func makeDevModuleDependencies() throws -> OSCAMap.Dependencies {
    let networkService = try makeDevNetworkService()
    let userDefaults   = try makeUserDefaults(domainString: "de.osca.map")
    let dependencies = OSCAMap.Dependencies(
      networkService: networkService,
      userDefaults: userDefaults)
    return dependencies
  }// end public func makeDevModuleDependencies
  
  public func makeDevModule() throws -> OSCAMap {
    let devDependencies = try makeDevModuleDependencies()
    // initialize module
    let module = OSCAMap.create(with: devDependencies)
    return module
  }// end public func makeDevModule
  
  public func makeProductionModuleDependencies() throws -> OSCAMap.Dependencies {
    let networkService = try makeProductionNetworkService()
    let userDefaults   = try makeUserDefaults(domainString: "de.osca.map")
    let dependencies = OSCAMap.Dependencies(
      networkService: networkService,
      userDefaults: userDefaults)
    return dependencies
  }// end public func makeProductionModuleDependencies
  
  public func makeProductionModule() throws -> OSCAMap {
    let productionDependencies = try makeProductionModuleDependencies()
    // initialize module
    let module = OSCAMap.create(with: productionDependencies)
    return module
  }// end public func makeProductionModule
  
  public func makePoiCategory() throws -> OSCAPoiCategory {
    let maxCount: Int = 100
    var poiCategory: OSCAPoiCategory?
    var error: Error?
    let expectation = self.expectation(description: "fetchOnePOICategory")
    let module = try makeDevModule()
    XCTAssertNotNil(module)
    module.fetchAllPOICategories(maxCount: maxCount)
      .sink { completion in
        switch completion {
        case .finished:
          expectation.fulfill()
        case let .failure(encounteredError):
          error = encounteredError
          expectation.fulfill()
        }// end switch completion
      } receiveValue: { allPOICategoriesFromNetwork in
        poiCategory = allPOICategoriesFromNetwork.first (where: { poiCategory in
          guard let objectId = poiCategory.objectId else { return false }
          return objectId == "dienstleistung100"
        })
      }// end sink
      .store(in: &self.cancellables)
    
    waitForExpectations(timeout: 10)
    XCTAssertNil(error)
    XCTAssertNotNil(poiCategory)
    return poiCategory!
  }// end makePoiCategory
  
  public func makeFilterFields(of poiCategory: OSCAPoiCategory) throws -> [OSCAPoiCategory.FilterField] {
    var filterFields: [OSCAPoiCategory.FilterField] = []
    guard poiCategory.objectId != nil else { return filterFields }
    var error: Error?
    let expectation = self.expectation(description: "fetchFilteredFields")
    let module = try makeDevModule()
    XCTAssertNotNil(module)
    module.fetchAllFilterFields(for: poiCategory)
      .sink { completion in
        switch completion {
        case .finished:
          expectation.fulfill()
        case let .failure(encounteredError):
          error = encounteredError
          expectation.fulfill()
        }// end switch completion
      } receiveValue: { allFilteredFieldsForCategory in
        filterFields = allFilteredFieldsForCategory
      }// end sink
      .store(in: &self.cancellables)
    
    waitForExpectations(timeout: 10)
    XCTAssertNil(error)
    XCTAssertNotNil(filterFields)
    return filterFields
  }// end public func makeFilterFields of poi category
}// end extension final class OSCAMapTests
#endif
