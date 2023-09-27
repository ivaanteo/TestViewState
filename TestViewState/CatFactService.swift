//
//  CatFactService.swift
//  TestViewState
//
//  Created by Ivan Teo on 27/9/23.
//

import Foundation
import Combine

class CatFactService {

  private enum Endpoints {
    static let catFact = "https://catfact.ninja/fact"
  }
  
  static func getFacts() -> AnyPublisher<CatFactModel, Error> {
    guard let request = NetworkManager.request(urlString: Endpoints.catFact)
    else {
      return
        Fail<CatFactModel, Error>(
          error: URLError(.unsupportedURL)
        ).eraseToAnyPublisher()
    }
    return NetworkManager.response(request: request)
  }
}
