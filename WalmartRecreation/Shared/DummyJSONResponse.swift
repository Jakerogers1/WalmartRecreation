//
//  JSONResponse.swift
//  WalmartRecreation
//
//  Created by jmanerr on 1/30/24.
//

import Foundation

struct DummyJSONResponse: Codable{
    let products: [Product]
    let total: Int
    let skip: Int
    let limit: Int
}

struct Product: Codable, Identifiable{
    let id: Int?
    let title: String?
    let price: Double?
    let rating: Double?
    let thumbnail: URL?
    let description: String?
    let stock: Int?

    var thumbnailURL: URL? {
        if let thumbnail = thumbnail{
            return thumbnail
        }
        else{
            return nil
        }
    }
}

