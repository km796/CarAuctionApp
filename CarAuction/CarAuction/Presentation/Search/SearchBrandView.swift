//
//  SearchBrandView.swift
//  CarAuction
//
//  Created by Kang Minsu on 4/12/24.
//

import SwiftUI

struct SearchBrandView: View {
    @StateObject var viewModel = SearchResultViewModel()
    var body: some View {
        VStack(alignment: .leading) {
            Text("브랜드").font(.system(size: 24, weight: .bold)).padding(.leading, 24)
            List(viewModel.brandResults) { result in
                SearchResultCell(result: result)
                    .background(
                        NavigationLink(
                            "",
                            destination: SearchCarTypeView(viewModel: viewModel).onAppear {
                                viewModel.getCarTypeResults(brandId: result.id)
                            }
                        )
                        .opacity(0)
                    )
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
                    .frame(height: 64)
            }
            .listStyle(PlainListStyle())
            .onAppear {
                viewModel.getBrandResults()
            }
        }
        .background(Color.white)
    }
}

#Preview {
    SearchBrandView()
}


