//
//  SearchCarTypeView.swift
//  CarAuction
//
//  Created by Kang Minsu on 4/14/24.
//

import Foundation

import SwiftUI

struct SearchCarTypeView: View {
    @StateObject var viewModel: SearchResultViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("차종").font(.system(size: 24, weight: .bold)).padding(.leading, 24)
            List(viewModel.carTypeResults) { result in
                SearchResultCell(result: result)
                    .background(
                        NavigationLink(
                            "",
                            destination: SearchCarModelView(viewModel: viewModel)
                                .onAppear {
                                    viewModel.getCarModelResults(carTypeId: result.id)
                                }
                        )
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
