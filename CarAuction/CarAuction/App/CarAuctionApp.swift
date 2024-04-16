//
//  CarAuctionApp.swift
//  CarAuction
//
//  Created by Kang Minsu on 4/11/24.
//

import SwiftUI

@main
struct CarAuctionApp: App {
    init() {
        DIContainer.shared.registration()
    }
    
    var body: some Scene {
        WindowGroup {
            CarListScreen()
        }
    }
}
