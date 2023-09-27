//
//  NetworkManager.swift
//  TestViewState
//
//  Created by Ivan Teo on 27/9/23.
//

import Foundation
import Combine

class NetworkManager {
  
  static func request(urlString: String) -> URLRequest? {
    guard let url = URL(string: urlString) else { return nil }
    // Handle HTTP methods, attaching headers and body here
    return URLRequest(url: url)
  }

  static func response<T: Decodable>(
    request: URLRequest
  ) -> AnyPublisher<T, Error> {
    URLSession
      .shared
      .dataTaskPublisher(for: request)
      .tryMap { element -> Data in
        guard let httpResponse = element.response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
          throw URLError(.badServerResponse)
        }
        return element.data
      }
      .decode(type: T.self, decoder: JSONDecoder())
      .eraseToAnyPublisher()
  }
}
