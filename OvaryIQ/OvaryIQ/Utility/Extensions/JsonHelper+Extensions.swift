//
//  JSONHelper+Extensions.swift
//  OvaryIQ
//
//  Created by Mobcoder on 25/01/22.
//

import Foundation
class JSONHelper<T: Codable> {
  init() {

  }
  func getCodableModel(data: Data) -> T? {

   // let decoder = JSONDecoder()
    let model = try? JSONDecoder().decode(T.self, from: data)
    return model

//    do {
//       let model = try? JSONDecoder().decode(T.self, from: data)
//        return model
//    } catch let error {
//        print(error)
//        return nil
//    }
  }

  func getData(model: T) -> Data? {
    guard let data: Data = try? JSONEncoder().encode(model) else {
      return nil
    }

    return data
  }
}
