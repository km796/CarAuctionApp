//
//  SearchBarView.swift
//  CarAuction
//
//  Created by Kang Minsu on 4/12/24.
//

import SwiftUI

struct SearchBarView: View {
    let searchTitle: String?
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                Text(searchTitle ?? "제조사 • 모델로 검색")
                Spacer()
            }
            .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 8))
            .foregroundColor(.secondary)
        }
        .overlay(
            RoundedRectangle(cornerRadius: 4)
                .stroke(Color.black, lineWidth: 1)
        )
        .padding(.horizontal, 24)
    }
}
