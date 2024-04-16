//
//  CarCell.swift
//  CarAuction
//
//  Created by Kang Minsu on 4/11/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct CarCell: View {
    let car: CarEntity
    
    var body: some View {
        NavigationLink(destination: CarDetailScreen(carId: car.id)) {
            VStack(alignment: .leading, spacing: 8) {
                CarPhotoView(car: car)
                
                VStack(alignment: .leading) {
                    Text(car.name)
                        .font(.system(size: 14, weight: .bold))
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                    
                    HStack {
                        Text(verbatim: "\(car.year)년")
                        Text("•")
                        Text(car.mileage)
                    }
                    .font(.system(size: 12))
                    
                    Spacer()
                }
            }
            .frame(maxWidth: CarCell.width, maxHeight: CarCell.height, alignment: .leading)
        }.buttonStyle(PlainButtonStyle())
    }
    
    static let width: CGFloat = CarPhotoView.width
    static let height: CGFloat = 226
}

struct CarListCell: View {
    let carListEntity: CarListEntity
    var body: some View {
        switch carListEntity.column {
        case .one:
            if let car = carListEntity.results.first {
                NavigationLink(destination: CarDetailScreen(carId: car.id)) {
                    HStack(alignment: .top, spacing: 12) {
                        CarPhotoView(car: car)
                        CarTextView(car: car)
                    }.padding(24)
                }.buttonStyle(PlainButtonStyle())
            }
        case .two:
            HStack(alignment: .top, spacing: 12) {
                if let car1 = carListEntity.results.first {
                    CarCell(car: car1)
                }
                if let car2 = carListEntity.results[safe: 1] {
                    CarCell(car: car2)
                } else {
                    Spacer().frame(width: CarCell.width, height: CarCell.height)
                }
            }.padding(24)
        }
    }
}

struct CarPhotoView: View {
    let car: CarEntity
    @State private var untilEnd: TimeInterval = 0
    @State private var untilExpire: TimeInterval = 0
    
    var body: some View {
        ZStack(alignment: .bottom) {
            WebImage(url: URL(string: car.imageUrl)) { image in
                image.resizable()
            } placeholder: {
                    Rectangle().foregroundColor(.gray)
            }
            .indicator(.activity)
            .transition(.fade(duration: 0.5))
            .aspectRatio(contentMode: .fill)
            .scaledToFill()
            .frame(width: CarPhotoView.width, height: CarPhotoView.height, alignment: .center)
            .clipped()

            if untilEnd != 0 {
                HStack {
                    Text("경매진행중").font(.system(size: 12, weight: .bold))
                    Spacer()
                    Text("\(untilEnd.toTime)").font(.system(size: 12))
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 4)
                .foregroundColor(.white)
                .background { Color.prBlue }
            } else if untilExpire != 0 {
                HStack {
                    Text("선택대기중").font(.system(size: 12, weight: .bold))
                    Spacer()
                    Text("\(untilExpire.toTime)").font(.system(size: 12))
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 4)
                .foregroundColor(.white)
                .background { Color.prGreen }
            } else {
                HStack {
                    Text("유효기간만료").font(.system(size: 12, weight: .bold))
                    Spacer()
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 4)
                .foregroundColor(.white)
                .background { Color.prGray }
            }

        }
        .frame(width: CarPhotoView.width, height: CarPhotoView.height, alignment: .center)
        .onAppear {
            updateRemainingTime()
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                updateRemainingTime()
            }
        }
    }
    
    private func updateRemainingTime() {
        guard let endAt = car.auctionEndAt.toDate,
              let expireAt = car.auctionExpireAt.toDate
        else { return }
        untilEnd = max(endAt.timeIntervalSinceNow, 0)
        untilExpire = max(expireAt.timeIntervalSinceNow, 0)
    }
    
    static var width: CGFloat = 150
    static var height: CGFloat = 150
}

struct CarTextView: View {
    let car: CarEntity
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(car.name).font(.system(size: 14, weight: .bold))
            LazyVGrid(
                columns: [
                    GridItem(.fixed(35)),
                    GridItem(.flexible())
                ],
                alignment: .leading, spacing: 10
            ) {
                VStack(alignment: .leading, spacing: 10) {
                    Text("연식")
                    Text("주행")
                    Text("지역")
                }
                VStack(alignment: .leading, spacing: 10) {
                    Text(verbatim: "\(car.year)년")
                    Text("\(car.mileage) km")
                    Text("\(car.city)")
                }
            }.font(.system(size: 12))
            Spacer()
        }.frame(width: CarPhotoView.width, height: CarPhotoView.height, alignment: .leading)
    }
}
