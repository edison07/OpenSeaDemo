//
//  API.swift
//  OpenSeaDemo
//
//  Created by Funday on 2020/4/21.
//  Copyright © 2020 Edison. All rights reserved.
//

import Foundation
import Alamofire

struct API {
    
    static func download(offset: String, completion: @escaping(DataModel) -> ()) {
        
        let parameters: [String : Any] = ["format" : "json",
                                          "owner" : "0x960DE9907A2e2f5363646d48D7FB675Cd2892e91",
                                          "offset" : offset,
                                          "limit" : "20"]
        Alamofire.request("https://api.opensea.io/api/v1/assets/", parameters: parameters).responseJSON { (response) in
            switch response.result {
                
            case .success(_):
                let decoder = JSONDecoder()
                if let data = response.data, let json = try? decoder.decode(DataModel.self, from: data) {
                    completion(json)
                }else {
                    print("decode fail")
                }
            case .failure(_):
                print(response.error)
            }
        }
        
    }
}


