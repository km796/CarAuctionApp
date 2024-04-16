//
//  CarDetailScreen.swift
//  CarAuction
//
//  Created by Kang Minsu on 4/15/24.
//

import SwiftUI

struct CarDetailScreen: View {
    @StateObject private var viewModel = CarDetailViewModel()
    let carId: Int
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading, spacing: 0) {
                AuctionHeaderView(viewModel: viewModel)
                CarouselImageView(images: viewModel.carDetail.detail?.images ?? [])
                    .frame(maxWidth: .infinity, idealHeight: 240, maxHeight: 240, alignment: .top)
                Text(viewModel.carDetail.detail?.name ?? "").font(.system(size: 24, weight: .bold))
                    .padding(.horizontal, 24)
                    .padding(.top, 20)
                LazyVGrid(
                    columns: [
                        GridItem(.fixed(100)),
                        GridItem(.flexible())
                    ],
                    alignment: .leading, spacing: 10
                ) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("주행거리")
                        Text("최초등록일")
                        Text("연료")
                        Text("지역")
                    }
                    VStack(alignment: .leading, spacing: 10) {
                        let mileage = viewModel.carDetail.detail?.mileage ?? 0
                        Text("\(mileage)km")
                        Text(viewModel.carDetail.detail?.initialRegistrationDate ?? "")
                        Text("\(viewModel.carDetail.detail?.fuel ?? "")")
                        Text("\(viewModel.carDetail.detail?.location ?? "")")
                    }
                }
                .font(.system(size: 16))
                .padding(.horizontal, 24)
                .padding(.top, 16)
                
                
                VStack(alignment: .leading) {
                    Text("경매결과")
                        .font(.system(size: 16, weight: .bold))
                        .padding(16)
                    LazyVGrid(
                        columns: [GridItem(.fixed(100)), GridItem(.flexible())],
                        alignment: .leading,
                        spacing: 10
                    ) {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("응찰딜러수")
                            Text("\(viewModel.carDetail.auction?.bidsCount ?? 0)")
                                .font(.system(size: 16, weight: .bold))
                        }
                        VStack(alignment: .leading, spacing: 10) {
                            Text("최고가")
                            Text("\(viewModel.carDetail.auction?.highestBidPrice ?? 0)")
                                .font(.system(size: 16, weight: .bold))
                        }
                    }
                    .padding(.leading, 16)
                    .padding(.bottom, 16)
                }
                .border(Color.black, width: 1)
                .padding(.horizontal, 24)
                .padding(.top, 72)
                
                Spacer()
            }
            .onAppear {
                Task {
                    await viewModel.getDetail(id: carId)
                    Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                        Task { await viewModel.updateRemainingTime() }
                    }
                }
            }
        }
    }
}
