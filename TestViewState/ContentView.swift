//
//  ContentView.swift
//  TestViewState
//
//  Created by Ivan Teo on 27/9/23.
//

import SwiftUI

struct ContentView: View {
  
  @ObservedObject
  var viewModel = CatFactViewModel()
  
  var body: some View {
    VStack {
      Text("Cat Facts")
        .font(.title)
        .padding([.bottom])
      switch viewModel.state {
      case .loading:
        Text("Loading")
      case .error(let error):
        Text("Error: \(error.localizedDescription)")
      case .loaded(let catFact):
        Text("\(catFact.fact)")
      }
      Spacer()
      Button("Reload") {
        viewModel.load()
      }
    }
    .padding()
    .task {
      viewModel.load()
    }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
