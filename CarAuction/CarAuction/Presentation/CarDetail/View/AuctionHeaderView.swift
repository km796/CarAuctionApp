//
//  AuctionHeaderView.swift
//  CarAuction
//
//  Created by Kang Minsu on 4/16/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct AuctionHeaderView: View {
    @StateObject var viewModel: CarDetailViewModel
    
    var body: some View {
        if viewModel.untilEnd != 0 {
            HStack {
                Text("경매진행중").font(.system(size: 16, weight: .bold))
                Spacer()
                Text("\(viewModel.untilEnd.toTime) 남음")
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 4)
            .foregroundColor(.white)
            .background { Color.prBlue }
        } else if viewModel.untilExpire != 0 {
            HStack {
                Text("선택대기중").font(.system(size: 16, weight: .bold))
                Spacer()
                Text("\(viewModel.untilExpire.toTime) 남음")
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 4)
            .foregroundColor(.white)
            .background { Color.prGreen }
        } else {
            HStack {
                Text("유효기간만료").font(.system(size: 16, weight: .bold))
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 4)
            .foregroundColor(.white)
            .background { Color.prGray }
        }
    }
}
