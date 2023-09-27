//
//  ViewState.swift
//  TestViewState
//
//  Created by Ivan Teo on 27/9/23.
//

import Foundation

enum ViewState<T: Decodable> {
  case loading
  case error(error: Error)
  case loaded(payload: T)
}
