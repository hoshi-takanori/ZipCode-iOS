//
//  ZipCode.swift
//  ZipCode
//
//  Created by Hoshi Takanori on 2016/04/24.
//  Copyright © 2016 Hoshi Takanori. All rights reserved.
//

import ObjectMapper
import APIKit

let BASE_URL = "http://search.olp.yahooapis.jp"
let PATH = "/OpenLocalPlatform/V1/zipCodeSearch"
let API_KEY = "YOUR_API_KEY"

class ZipCodeEntry: Mappable, CustomStringConvertible {
    var address: String?
    var coordinates: String?

    required init?(_ map: Map) {
    }

    func mapping(map: Map) {
        address     <- map["Property.Address"]
        coordinates <- map["Geometry.Coordinates"]
    }

    var description: String {
        return "ZipCodeEntry(address: \(address), coordinates: \(coordinates))"
    }
}

class ZipCodeResult: Mappable, CustomStringConvertible {
    var count: Int = 0
    var entries: [ZipCodeEntry] = []

    required init?(_ map: Map) {
    }

    func mapping(map: Map) {
        count   <- map["ResultInfo.Count"]
        entries <- map["Feature"]
    }

    var description: String {
        return "ZipCodeResult(count: \(count), entries: \(entries))"
    }
}

struct ZipCodeRequest: RequestType {
    typealias Response = ZipCodeResult

    var zipCode: String

    init(zipCode: String) {
        self.zipCode = zipCode
    }

    var baseURL: NSURL { return NSURL(string: BASE_URL)! }
    var method: HTTPMethod { return .GET }
    var path: String { return PATH }
    var parameters: [String : AnyObject] {
        return [ "query": zipCode, "output": "json", "appid": API_KEY ]
    }

    func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) -> Response? {
        return Mapper<ZipCodeResult>().map(object)
    }
}
