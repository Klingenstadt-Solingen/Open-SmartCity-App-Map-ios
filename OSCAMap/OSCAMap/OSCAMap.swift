//
//  OSCAMap.swift
//  OSCAMap
//
//  Created by Stephan Breidenbach on 02.03.22.
//  Reviewed by Stephan Breidenbach on 10.08.22

import Combine
import CoreText
import Foundation
import OSCAEssentials
import OSCANetworkService
import CoreLocation

/// OSCA map module
///
/// other swift flags: -D MOCKNETWORK for mocking up network calls
public struct OSCAMap: OSCAModule {
  /// module DI Container
  var moduleDIContainer: OSCAMap.DIContainer!

  let transformError: (OSCANetworkError) -> OSCAMapError = { networkError in
    switch networkError {
    case OSCANetworkError.invalidResponse:
      return OSCAMapError.networkInvalidResponse
    case OSCANetworkError.invalidRequest:
      return OSCAMapError.networkInvalidRequest
    case let OSCANetworkError.dataLoadingError(statusCode: code, data: data):
      return OSCAMapError.networkDataLoading(statusCode: code, data: data)
    case let OSCANetworkError.jsonDecodingError(error: error):
      return OSCAMapError.networkJSONDecoding(error: error)
    case OSCANetworkError.isInternetConnectionError:
      return OSCAMapError.networkIsInternetConnectionFailure
    } // end switch case
  } // end let transformError closure

  /// version of the module
  public var version: String = "1.0.4"
  /// bundle prefix of the module
  public var bundlePrefix: String = "de.osca.map"
  /// module `Bundle`
  ///
  /// **available after module initialization only!!!**
  public internal(set) static var bundle: Bundle!

  private var networkService: OSCANetworkService!
  
  public private(set) var defaultGeoPoint: OSCAGeoPoint?

  public private(set) var userDefaults: UserDefaults
  
  public private(set) var dataCache: NSCache<NSString, NSData>

  /**
   create module and inject module dependencies

   ** This is the only way to initialize the module!!! **
   - Parameter moduleDependencies: module dependencies
   ```
   call: OSCAMap.create(with moduleDependencies)
   ```
   */
  public static func create(with moduleDependencies: OSCAMap.Dependencies) -> OSCAMap {
    var module: Self = Self(defaultGeoPoint: moduleDependencies.defaultGeoPoint,
                            networkService: moduleDependencies.networkService,
                            userDefaults: moduleDependencies.userDefaults,
                            dataCache: moduleDependencies.dataCache)
    module.moduleDIContainer = OSCAMap.DIContainer(dependencies: moduleDependencies)
    return module
  } // end public static create

  /// initializes the events module
  ///  - Parameter networkService: Your configured network service
  private init(defaultGeoPoint: OSCAGeoPoint? = nil,
               networkService: OSCANetworkService,
               userDefaults: UserDefaults,
               dataCache: NSCache<NSString, NSData>) {
    self.defaultGeoPoint = defaultGeoPoint
    self.networkService = networkService
    self.userDefaults = userDefaults
    self.dataCache = dataCache
    
    var bundle: Bundle?
    #if SWIFT_PACKAGE
      bundle = Bundle.module
    #else
      bundle = Bundle(identifier: bundlePrefix)
    #endif
    guard let bundle: Bundle = bundle else { fatalError("Module bundle not initialized!") }
    Self.bundle = bundle
  } // end public init
} // end public struct OCAMap

// MARK: - Dependencies

extension OSCAMap {
  public struct Dependencies {
    let defaultGeoPoint: OSCAGeoPoint?
    let networkService: OSCANetworkService
    let userDefaults: UserDefaults
    let dataCache = NSCache<NSString, NSData>()
    let analyticsModule: OSCAAnalyticsModule?

    public init(defaultGeoPoint: OSCAGeoPoint? = nil,
                networkService: OSCANetworkService,
                userDefaults: UserDefaults,
                analyticsModule: OSCAAnalyticsModule? = nil
    ) {
      self.defaultGeoPoint = defaultGeoPoint
      self.networkService = networkService
      self.userDefaults = userDefaults
      self.analyticsModule = analyticsModule
    } // end public memberwise init
  } // end public struct OSCAMapDependencies
} // end extension public struct OSCAMap

// - MARK: fetch all POIs / POI categories and mutate locally
extension OSCAMap {
  public typealias OSCAMapPublisher = AnyPublisher<[OSCAPoi], OSCAMapError>
  /// Fetches all POIs from parse server in background
  /// - Parameter maxCount: Limits the amount of POIs that gets downloaded from the server
  /// - Parameter query: HTTP query parameter
  /// - Returns: Publisher with a list of all Pois on the `Output` and possible `OSCAMapError`s on the `Fail`channel
  public func fetchAllPOIs(maxCount: Int = 1000,
                           query: [String: String] = [:]) -> OSCAMapPublisher {
    // limit is greater 0!
    guard maxCount > 0 else {
      // return an empty list of POIs immediately
      return Empty(completeImmediately: true,
                   outputType: [OSCAPoi].self,
                   failureType: OSCAMapError.self).eraseToAnyPublisher()
    } // end guard
    var parameters = query
    parameters["limit"] = "\(maxCount)"

    var headers = networkService.config.headers
    if let sessionToken = userDefaults.string(forKey: "SessionToken") {
      headers["X-Parse-Session-Token"] = sessionToken
    }

    var publisher: AnyPublisher<[OSCAPoi], OSCANetworkError>
    #if MOCKNETWORK
      publisher = networkService.fetch(OSCABundleRequestResource<OSCAPoi>
        .poi(bundle: Self.bundle, fileName: "POI.json"))
    #else
      publisher = networkService.fetch(OSCAClassRequestResource
        .poi(baseURL: networkService.config.baseURL,
             headers: headers,
             query: parameters))
    #endif
    return publisher
      .mapError(transformError)
      // fetch events in background
      .subscribe(on: OSCAScheduler.backgroundWorkScheduler)
      .eraseToAnyPublisher()
  } // end public func fetchAllPOIs
  public typealias OSCAMapCategoryPublisher = AnyPublisher<[OSCAPoiCategory], OSCAMapError>

  /// Fetches all POI categories from parse server in background
  /// - Parameter maxCount: Limits the amount of POI categories that gets downloaded from the server
  /// - Parameter query: HTTP query parameter
  /// - Returns: Publisher with a list of all Poi categories on the `Output` and possible `OSCAMapError`s on the `Fail`channel
  public func fetchAllPOICategories(maxCount: Int = 1000,
                                    query: [String: String] = [:]) -> OSCAMapCategoryPublisher {
    // limit is greater 0!
    guard maxCount > 0 else {
      // return an empty list of POI categories immediately
      return Empty(completeImmediately: true,
                   outputType: [OSCAPoiCategory].self,
                   failureType: OSCAMapError.self).eraseToAnyPublisher()
    } // end guard
    var parameters = query
    parameters["limit"] = "\(maxCount)"

    var headers = networkService.config.headers
    if let sessionToken = userDefaults.string(forKey: "SessionToken") {
      headers["X-Parse-Session-Token"] = sessionToken
    }

    var publisher: AnyPublisher<[OSCAPoiCategory], OSCANetworkError>
    #if MOCKNETWORK
      publisher = networkService.fetch(OSCABundleRequestResource<OSCAPoiCategory>
        .poiCategory(bundle: Self.bundle, fileName: "POICategory.json"))
    #else
      publisher = networkService.fetch(OSCAClassRequestResource
        .poiCategory(baseURL: networkService.config.baseURL,
                     headers: headers,
                     query: parameters))
      
    #endif
    return publisher
      .mapError(transformError)
      // fetch events in background
      .subscribe(on: OSCAScheduler.backgroundWorkScheduler)
      .eraseToAnyPublisher()
  } // end public func fetchAllPOICategories
} // end extension public struct OSCAMap

// - MARK: fetch image data from any URL
extension OSCAMap {
  public typealias OSCAIconImageDataPublisher = AnyPublisher<OSCAPoiCategory.IconImageData, OSCAMapError>

  public func fetchImageData(poiCategory: OSCAPoiCategory) -> OSCAIconImageDataPublisher {
    guard let resource = OSCAImageDataRequestResource<OSCAPoiCategory.IconImageData>.iconImageData(poiCategory: poiCategory)
    else { return Fail(outputType: OSCAPoiCategory.IconImageData.self, failure: OSCAMapError.networkInvalidRequest)
      .eraseToAnyPublisher()
    }
    // OSCAImageFileDataRequestResource<OSCAPoiCategory.IconImageData>
    //let publisher = networkService.fetch<OSCAPoiCategory.IconImageData>(resource)
    let publisher = networkService.fetch(resource)
    return publisher
      .mapError(transformError)
      // fetch events in background
      .subscribe(on: OSCAScheduler.backgroundWorkScheduler)
      .eraseToAnyPublisher()
  } // end public func fetch image data icon

  public typealias OSCASymbolImageDataPublisher = AnyPublisher<OSCAPoiCategory.SymbolImageData, OSCAMapError>

  public func fetchImageData(poiCategory: OSCAPoiCategory) -> OSCASymbolImageDataPublisher {
    guard let resource = OSCAImageDataRequestResource<OSCAPoiCategory.SymbolImageData>.symbolImageData(poiCategory: poiCategory) else { return Fail(outputType: OSCAPoiCategory.SymbolImageData.self, failure: OSCAMapError.networkInvalidRequest)
      .eraseToAnyPublisher()
    }
    let publisher = networkService.fetch(resource)
    return publisher
      .mapError(transformError)
      // fetch events in background
      .subscribe(on: OSCAScheduler.backgroundWorkScheduler)
      .eraseToAnyPublisher()
  } // end public func fetch image data symbol

  public typealias OSCAImageDataPublisher = AnyPublisher<Data, OSCAMapError>

  public func fetchImageData(url: URL) -> OSCAImageDataPublisher {
    let publisher = networkService.fetch(url)
    return publisher
      .mapError(transformError)
      .subscribe(on: OSCAScheduler.backgroundWorkScheduler)
      .eraseToAnyPublisher()
  } // end public func fetch image data from URL
} // end extension public struct OSCAMap

// - MARK: elastic search
extension OSCAMap {
  public typealias ElasticSearchPublisher = AnyPublisher<[OSCAPoi.SearchResult.Item], OSCAMapError>
  /// Elastic-Search endpoint to get a `raw`search result
  /// ```console
  /// curl -vX POST 'https://parse-dev.solingen.de/functions/elastic-search' \
  ///  -H "X-Parse-Application-Id: <APP_ID>" \
  ///  -H "X-Parse-Client-Key: <CLIENT_KEY>" \
  ///  -H 'Content-Type: application/json' \
  ///  -d '{
  ///    "index":"new_poi",
  ///    "query":"Blumen",
  ///    "raw": true
  ///  }'
  /// ```
  public func elasticSearch(for query: String, at index: String = "new_poi") -> ElasticSearchPublisher {
    guard !query.isEmpty,
          !index.isEmpty
    else {
      return Empty(completeImmediately: true,
                   outputType: [OSCAPoi.SearchResult.Item].self,
                   failureType: OSCAMapError.self).eraseToAnyPublisher()
    } // end guard
    // init cloud function parameter object
    let cloudFunctionParameter = ParseElasticSearchQuery(index: index,
                                                         query: query)

    var publisher: AnyPublisher<[OSCAPoi.SearchResult.Item], OSCANetworkError>

    #if MOCKNETWORK

    #else
      var headers = networkService.config.headers
      if let sessionToken = userDefaults.string(forKey: "SessionToken") {
        headers["X-Parse-Session-Token"] = sessionToken
      }

      publisher = networkService.fetch(OSCAFunctionRequestResource<ParseElasticSearchQuery>
        .elasticSearch(baseURL: networkService.config.baseURL,
                       headers: headers,
                       cloudFunctionParameter: cloudFunctionParameter))
    #endif
    return publisher
      .mapError(transformError)
      .subscribe(on: OSCAScheduler.backgroundWorkScheduler)
      .eraseToAnyPublisher()
  } // end public func elasticSearch for query at index with raw return

  /// a new feature for the elastic-search endpoint to get not-`raw`, the parse objects `OSCAPoi` of the search result.
  /// ```console
  /// curl -vX POST 'https://parse-dev.solingen.de/functions/elastic-search' \
  ///  -H "X-Parse-Application-Id: <APP_ID>" \
  ///  -H "X-Parse-Client-Key: <CLIENT_KEY>" \
  ///  -H 'Content-Type: application/json' \
  ///  -d '{
  ///    "index":"new_poi",
  ///    "query":"Blumen",
  ///    "raw": false
  ///  }'
  /// ```
  public func elasticSearch(for query: String, at index: String = "new_poi") -> OSCAMapPublisher {
    guard !query.isEmpty,
          !index.isEmpty
    else {
      return Empty(completeImmediately: true,
                   outputType: [OSCAPoi].self,
                   failureType: OSCAMapError.self).eraseToAnyPublisher()
    } // end guard
    // init cloud function parameter object
    let cloudFunctionParameter = ParseElasticSearchQuery(index: index,
                                                         query: query,
                                                         raw: false)

    var publisher: AnyPublisher<[OSCAPoi], OSCANetworkError>

    #if MOCKNETWORK

    #else
      var headers = networkService.config.headers
      if let sessionToken = userDefaults.string(forKey: "SessionToken") {
        headers["X-Parse-Session-Token"] = sessionToken
      }

      publisher = networkService.fetch(OSCAFunctionRequestResource<ParseElasticSearchQuery>
        .elasticSearch(baseURL: networkService.config.baseURL,
                       headers: headers,
                       cloudFunctionParameter: cloudFunctionParameter))
    #endif
    return publisher
      .mapError(transformError)
      .subscribe(on: OSCAScheduler.backgroundWorkScheduler)
      .eraseToAnyPublisher()
  } // end public func elasticSearch for query at index without raw return
} // end extension public struct OSCAMap

// - MARK: cloud functions
extension OSCAMap {
  public typealias PoiCategoryFilterFieldsPublisher = AnyPublisher<[OSCAPoiCategory.FilterField], OSCAMapError>
  /// get all `OSCAPoi` filter fields and possible values for a specific `OSCAPoiCategory`
  /// ```console
  /// curl -vX POST \
  ///  -H "X-Parse-Application-Id: <APP_ID>" \
  ///  -H "X-Parse-Client-Key: <CLIENT_KEY>" \
  ///  -H 'Content-Type: application/json' \
  ///  -d '{
  ///    "category":"dienstleistung100"
  ///  }' \
  ///  'https://parse-dev.solingen.de/functions/poi-filter' \
  /// ```
  public func fetchAllFilterFields(for category: OSCAPoiCategory) -> PoiCategoryFilterFieldsPublisher {
    // object id is not empty
    guard let sourceId = category.sourceId,
          !sourceId.isEmpty else {
      // return an empty list of POI categor filter fields immediately
      return Empty(completeImmediately: true,
                   outputType: [OSCAPoiCategory.FilterField].self,
                   failureType: OSCAMapError.self).eraseToAnyPublisher()
    } // end guard
    let cloudFunctionParameter = OSCAPoiCategory.FilterFieldQueryParameter(categorySourceId: sourceId)

    var publisher: AnyPublisher<[OSCAPoiCategory.FilterField], OSCANetworkError>
    #if MOCKNETWORK

    #else
      var headers = networkService.config.headers
      if let sessionToken = userDefaults.string(forKey: "SessionToken") {
        headers["X-Parse-Session-Token"] = sessionToken
      }

      publisher = networkService.fetch(OSCAFunctionRequestResource<OSCAPoiCategory.FilterFieldQueryParameter>.poiFilter(baseURL: networkService.config.baseURL, headers: headers, cloudFunctionParameter: cloudFunctionParameter))
    #endif
    return publisher
      .mapError(transformError)
      // fetch filter fields in background
      .subscribe(on: OSCAScheduler.backgroundWorkScheduler)
      .eraseToAnyPublisher()
  } // end public func fetchAllFilterFields for category object id
  public typealias FilteredPoisPublisher = AnyPublisher<OSCAPoi.Filter.Result, OSCAMapError>
  /// get a list of `OSCAPoi`for an `OSCAPoiCategory` with a specific filter
  /// ```console
  /// curl -vX POST \
  ///  -H "X-Parse-Application-Id: solingenapp" \
  ///  -H "X-PARSE-CLIENT-KEY: 2gUj8dXf844qaTUatfSuVDHZ2CusQ9Cv" \
  ///  -H 'Content-Type: application/json' \
  ///  -d '{
  ///    "category":"dienstleistung100",
  ///    "filter": [
  ///      {
  ///        "field": "filter_branche",
  ///        "value": "Backwaren"
  ///      },
  ///      {
  ///        "field": "filter_nachhaltigkeit",
  ///        "value": "Regional"
  ///      }
  ///    ]
  ///  }' \
  ///  'https://parse-dev.solingen.de/functions/poi-filtered'
  /// ```
  /// - Returns: Publisher with Poi filter result on the `Output` and possible `OSCAMapError`s on the `Fail`channel
  public func fetchAllFilteredPois(for category: OSCAPoiCategory,
                                   with filterFields: [OSCAPoi.Detail.FilterField] = [],
                                   on operationQueue: OperationQueue = OSCAScheduler.backgroundWorkScheduler
  ) -> FilteredPoisPublisher {
    // object id is not empty
    guard let sourceId = category.sourceId,
          !sourceId.isEmpty else {
      // return an empty list of POI categor filter fields immediately
      return Empty(completeImmediately: true,
                   outputType: OSCAPoi.Filter.Result.self,
                   failureType: OSCAMapError.self).eraseToAnyPublisher()
    } // end guard

    let cloudFunctionParameter = OSCAPoiCategory.FilterFieldQueryParameter(categorySourceId: sourceId, filter: filterFields)

    var publisher: AnyPublisher<OSCAPoi.Filter.Result, OSCANetworkError>
    #if MOCKNETWORK

    #else
      var headers = networkService.config.headers
      if let sessionToken = userDefaults.string(forKey: "SessionToken") {
        headers["X-Parse-Session-Token"] = sessionToken
      }

      publisher = networkService.fetch(OSCAFunctionRequestResource<OSCAPoiCategory.FilterFieldQueryParameter>.poiFiltered(baseURL: networkService.config.baseURL, headers: headers, cloudFunctionParameter: cloudFunctionParameter))
    #endif
    return publisher
      .mapError(transformError)
      // fetch filtered POIs in background
      .subscribe(on: operationQueue)
      .eraseToAnyPublisher()
  } // end public func fetch all filtered pois for category with filter fields

  public func fetchAllCachedPois(force: Bool = false) -> OSCAMap.OSCAMapPublisher {
    let cloudFunctionParameter = OSCAPoi.CacheQueryParameter(force: force)

    var publisher: AnyPublisher<[OSCAPoi], OSCANetworkError>
    #if MOCKNETWORK

    #else
      var headers = networkService.config.headers
      if let sessionToken = userDefaults.string(forKey: "SessionToken") {
        headers["X-Parse-Session-Token"] = sessionToken
      }

      publisher = networkService.fetch(OSCAFunctionRequestResource<OSCAPoi.CacheQueryParameter>.poiAll(baseURL: networkService.config.baseURL, headers: headers, cloudFunctionParameter: cloudFunctionParameter))
    #endif
    return publisher
      .mapError(transformError)
      // fetch filtered POIs in background
      .subscribe(on: OSCAScheduler.backgroundWorkScheduler)
      .eraseToAnyPublisher()
  } // end public func fetch all filtered pois for category with filter fields

  public func fetchNearbyPois(lat: Double,
                              lon: Double,
                              distance: Int? = nil,
                              random: Bool? = nil,
                              limit: Int? = nil,
                              categoryId: String? = nil) -> OSCAMap.OSCAMapPublisher {
    let cloudFunctionParameter = OSCAPoi.NearbyQueryParameter(lat: lat, lon: lon, distance: distance, random: random, limit: limit, category: categoryId)

    var publisher: AnyPublisher<[OSCAPoi], OSCANetworkError>
    #if MOCKNETWORK

    #else
      publisher = networkService.fetch(OSCAFunctionRequestResource<OSCAPoi.NearbyQueryParameter>.poiNearby(baseURL: networkService.config.baseURL, headers: networkService.config.headers, cloudFunctionParameter: cloudFunctionParameter))
    #endif
    return publisher
      .mapError(transformError)
      // fetch filtered POIs in background
      .subscribe(on: OSCAScheduler.backgroundWorkScheduler)
      .eraseToAnyPublisher()
  } // end public func fetch all filtered pois for category with filter fields
  
  public func fetchNearbyPois(geoPoint: OSCAGeoPoint?,
                              distance: Int = 1000,
                              random: Bool = true,
                              limit: Int = 10) -> OSCAMapPublisher {
    var publisher: OSCAMapPublisher
    if let geoPoint = geoPoint {
      publisher = fetchNearbyPois(lat: geoPoint.latitude,
                                  lon: geoPoint.longitude,
                                  distance: distance,
                                  random: random,
                                  limit: limit)
    } else {
      publisher = .empty()
    }
    return publisher
  }// end public func fetch nearby POIs with geopoint wrapper
  
  public func fetchNearbyPois(clLocation: CLLocation?,
                              distance: Int = 1000,
                              random: Bool = true,
                              limit: Int = 10) -> OSCAMapPublisher {
    fetchNearbyPois(geoPoint: OSCAGeoPoint(clLocation: clLocation))
  }// end public func fetch nearby POIs with cl location wrapper

  /// wrapper function of `fetchAllFilteredPois(for:with:)`
  /// - Returns: Publisher with list of `OSCAPoi` on the `Output` and possible `OSCAMapError`s on the `Fail`channel
  public func fetchAllFilteredPois(for category: OSCAPoiCategory,
                                   with filterFields: [OSCAPoi.Detail.FilterField]) -> OSCAMapPublisher {
    let publisher: FilteredPoisPublisher = fetchAllFilteredPois(for: category, with: filterFields)
    return publisher
      .flatMap { filteredPOIsPublisher -> AnyPublisher<[OSCAPoi], OSCAMapError> in
        guard let items = filteredPOIsPublisher.items else {
          return Empty(completeImmediately: true,
                       outputType: [OSCAPoi].self,
                       failureType: OSCAMapError.self).eraseToAnyPublisher()
        }
        return Just(items)
          .setFailureType(to: OSCAMapError.self)
          .eraseToAnyPublisher()
      } // end flat map to poi publisher
      .eraseToAnyPublisher()
  } // end public func fetchAllFilteredPois for category with filter fields
} // end extension public struct OSCAMap

// - MARK: default categories
extension OSCAMap {
  /// Fetches all default POICategories from parse server in background
  /// - Parameter defaultCategories: `OSCAPoiCategory.DefaultCategories` object with a list of category name strings
  /// - Returns: Publisher with a list of all PoiCategories on the `Output` and possible `OSCAMapError`s on the `Fail`channel
  public func fetchDefaultCategories(_ defaultCategories: OSCAPoiCategory.DefaultCategories = OSCAPoiCategory.DefaultCategories(list: ["Einkaufen", "Baustelle", "Spielplatz", "Freifunk"])) -> OSCAMapCategoryPublisher {
    // default category list is NOT empty
    guard !defaultCategories.list.isEmpty else {
      // return an empty list of POI categories immediately
      return Empty(completeImmediately: true,
                   outputType: [OSCAPoiCategory].self,
                   failureType: OSCAMapError.self).eraseToAnyPublisher()
    } // end guard
    let query = ["where": "{\"name\":{\"$in\":\(defaultCategories.list)}}"]
    return fetchAllPOICategories(maxCount: 4, query: query)
  } // end public func fetch default categories
} // end extension public struct OSCAMap

// MARK: - Keys
extension OSCAMap {
  /// UserDefaults object keys
  public enum Keys: String {
    case userDefaultsMapConstructionSitesPush = "OSCAMap_Construction_Sites_Push"
  }
}
