//
//  CatFactViewModel.swift
//  TestViewState
//
//  Created by Ivan Teo on 27/9/23.
//

import Combine
import SwiftUI

class CatFactViewModel: ObservableObject {
  
  @Published
  var state: ViewState<CatFactModel> = .loading
  
  private var cancellables = Set<AnyCancellable>()
  
  func load() {
    state = .loading
    CatFactService.getFacts()
      .receive(on: RunLoop.main)
      .sink { [weak self] completion in
        switch completion {
        case .failure(let error):
          self?.state = .error(error: error)
        case .finished: return
        }
      } receiveValue: { [weak self] catFactModel in
        self?.state = .loaded(payload: catFactModel)
      }
      .store(in: &cancellables)
  }
}


