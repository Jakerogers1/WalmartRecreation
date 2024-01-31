//
//  ContentView.swift
//  WalmartRecreation
//
//  Created by jmanerr on 1/30/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            ShopView()
                .tabItem() {
                    Image(systemName: "building.columns")
                }
            HeartView()
                .tabItem() {
                    Image(systemName: "heart")
                }
            SearchView()
                .tabItem() {
                    Image(systemName: "magnifyingglass")
                }
            ServiceView()
                .tabItem() {
                    Image(systemName: "circle.grid.2x2")
                }
            ProfileView()
                .tabItem() {
                    Image(systemName: "person.circle")
                }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
