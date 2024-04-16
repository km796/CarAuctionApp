//
//  SearchResultCell.swift
//  CarAuction
//
//  Created by Kang Minsu on 4/15/24.
//

import SwiftUI

struct SearchResultCell: View {
    let result: SearchResult
    
    var body: some View {
        HStack {
            Text(result.name)
            Spacer()
            HStack {
                Text("\(result.count)")
                Image(.arrowRight)
            }
            .foregroundStyle(.prBlue)
        }
    }
}
