//
//  DataModel.swift
//  OpenSeaDemo
//
//  Created by Funday on 2020/4/22.
//  Copyright © 2020 Edison. All rights reserved.
//

import Foundation

struct DataModel: Codable {
    let assets: [DataModelAssets]
}

struct DataModelAssets: Codable {
    let image_url: String?
    let name: String?
    let description: String?
    let permalink: String?
    let collection: DataModelCollection
}
struct DataModelCollection: Codable {
    let name: String?
}
