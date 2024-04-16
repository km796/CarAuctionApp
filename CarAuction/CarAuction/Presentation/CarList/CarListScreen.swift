//
//  CarListScreen.swift
//  CarAuction
//
//  Created by Kang Minsu on 4/11/24.
//

import SwiftUI

struct ViewOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}

struct CarListScreen: View {
    @StateObject var viewModel = CarListViewModel()
    var searchResult: SearchResult?
    private let amountToPullBeforeRefreshing: CGFloat = 220
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: SearchBrandView()) {
                    SearchBarView(searchTitle: searchResult?.name)
                }

                ScrollView {
                    if viewModel.isCurrentlyRefreshing {
                        ProgressView()
                    }
                    LazyVStack {
                        ForEach(viewModel.carListEntities, id: \.self) { carListEntity in
                            CarListCell(carListEntity: carListEntity)
                                .onAppear {
                                    guard let index = viewModel.carListEntities.firstIndex(where: { $0.uuid == carListEntity.uuid })
                                    else { return }
                                    let count = viewModel.carListEntities.count
                                    if index == count - 2 {
                                        viewModel.loadNext()
                                    }
                                }
                        }
                    }
                    .overlay(GeometryReader { geo in
                        let currentScrollViewPosition = -geo.frame(in: .global).origin.y
                        
                        if currentScrollViewPosition < -amountToPullBeforeRefreshing && !viewModel.isCurrentlyRefreshing {
                            Color.clear.preference(key: ViewOffsetKey.self, value: -geo.frame(in: .global).origin.y)
                        }
                    })
                }
                .onPreferenceChange(ViewOffsetKey.self, perform: { scrollPosition in
                    if scrollPosition < -amountToPullBeforeRefreshing && !viewModel.isCurrentlyRefreshing {
                        viewModel.refresh(id: searchResult?.id)
                    }
                })
                .onAppear {
                    Task {
                        await viewModel.getCars(id: searchResult?.id)
                    }
                }
            }
        }.navigationBarBackButtonHidden(true)
    }
}
