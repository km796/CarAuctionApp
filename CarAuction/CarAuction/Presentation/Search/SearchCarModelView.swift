//
//  SearchCarModelView.swift
//  CarAuction
//
//  Created by Kang Minsu on 4/15/24.
//

import SwiftUI

struct SearchCarModelView: View {
    @StateObject var viewModel: SearchResultViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("모델").font(.system(size: 24, weight: .bold)).padding(.leading, 24)
            List(viewModel.carModelResults) { result in
                SearchResultCell(result: result)
                    .background(
                        NavigationLink("", destination: CarListScreen(searchResult: result))
                            .opacity(0)
                    )
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
                    .frame(height: 64)
            }
            .listStyle(PlainListStyle())
        }
        .background(Color.white)
    }
}
