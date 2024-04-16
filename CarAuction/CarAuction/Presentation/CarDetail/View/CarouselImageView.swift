//
//  CarouselImageView.swift
//  CarAuction
//
//  Created by Kang Minsu on 4/16/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct CarouselImageView: View {
    let images: [CarDetailDTO.Image]
    
    var body: some View {
        TabView {
            ForEach(images, id: \.self) { image in
                WebImage(url: URL(string: image.url)) { image in
                    image.resizable()
                } placeholder: {
                        Rectangle().foregroundColor(.gray)
                }
                .indicator(.activity)
                .transition(.fade(duration: 0.5))
                .aspectRatio(contentMode: .fill)
                .scaledToFill()
                .frame(height: 240, alignment: .center)
                .clipped()
            }
        }
        .tabViewStyle(PageTabViewStyle())
    }
}
