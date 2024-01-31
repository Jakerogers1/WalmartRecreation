//
//  SearchView.swift
//  WalmartRecreation
//
//  Created by jmanerr on 1/30/24.
//

import SwiftUI

struct SearchView: View {
    @StateObject private var vm = SearchViewModel()
    @State private var selectedProduct: Product?
    @State private var products: [Product] = []

    var body: some View {
        NavigationView {
            List {
                Section {
                    VStack {
                        HStack {
                            Button {
                            } label: {
                                Image(systemName: "lessthan")
                                    .font(.system(size: 18))
                                    .font(.headline)
                                    .foregroundColor(.primary)
                            }
                            Spacer()
                            Button {
                                Task {
                                    await vm.searchProducts(title: vm.title)
                                }
                            } label: {
                                Image(systemName: "magnifyingglass")
                                    .font(.system(size: 18))
                                    .font(.headline)
                                    .foregroundColor(.primary)
                            }
                            TextField("Search", text: $vm.title)
                                .font(.system(size: 18))
                            Image(systemName: "barcode.viewfinder")
                                .font(.system(size: 18))
                                .font(.headline)
                                .foregroundColor(.primary)
                                .padding()
                            Spacer()
                            Image(systemName: "cart")
                                .font(.system(size: 18))
                                .font(.headline)
                                .foregroundColor(.primary)
                            
                        }
                        Spacer()
                        HStack {
                            Image("Image")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .clipShape(Circle())
                                .padding(.leading)
                            Text("How do you want your items?")
                                .font(.system(size: 12))
                            Spacer()
                            Text("|")
                                .font(.system(size: 12))
                            Spacer()
                            Text("27516")
                                .font(.system(size: 12))
                                .padding(.trailing)
                            
                        }
                        HStack {
                            Spacer()
                        }
                    }
                }
                .background(Color.blue)
                .listRowInsets(EdgeInsets( top: 0, leading: 0, bottom: 0, trailing: 0))
                Section {
                    switch vm.state {
                    case .success(let product):
                        ProductList(product)
                    case .idle:
                        idleView
                    case .loading:
                        loadingView
                    case .error(let error):
                        errorView(error)
                    }
                }
            }
        }
        .sheet(item: $selectedProduct) { product in
            ProductDetailView(product: product)
        }
    }

    @ViewBuilder
    private var idleView: some View {
        EmptyView()
    }

    @ViewBuilder
    private var loadingView: some View {
        Text("Loading...")
    }

    @ViewBuilder
    private func ProductList(_ results: [Product]) -> some View {
        ForEach(results) { product in
            NavigationLink(destination: ProductDetailView(product: product)) {
                HStack {
                    if let thumbnailURL = product.thumbnail {
                        AsyncImage(url: thumbnailURL) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 60, height: 90)
                                    .cornerRadius(8)
                            case .failure:
                                Image(systemName: "photo")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 60, height: 90)
                                    .cornerRadius(8)
                            @unknown default:
                                Text("Unexpected state")
                            }
                        }
                    }
                    // Whats shown on successful search
                    VStack(alignment: .leading) {
                        Text(" Now $\(String(format: "%.2f", product.price ?? 0))")
                            .foregroundColor(.green)
                            .padding(.bottom)
                        Text("\(product.title ?? "")")
                            .foregroundColor(.primary)
                            .lineLimit(1)
                            .font(.system(size: 16))
                        HStack {
                            if ((product.rating)! >= 1.0) {
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                                    .font(.system(size: 12))
                            } else if ((product.rating)! >= 0.5) {
                                Image(systemName: "star.leadinghalf.filled")
                                    .foregroundColor(.yellow)
                                    .font(.system(size: 12))
                            } else {
                                Image(systemName: "star")
                                    .font(.system(size: 12))
                            }
                            if ((product.rating)! >= 2.0) {
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                                    .font(.system(size: 12))
                            } else if ((product.rating)! >= 1.5) {
                                Image(systemName: "star.leadinghalf.filled")
                                    .foregroundColor(.yellow)
                                    .font(.system(size: 12))
                            } else {
                                Image(systemName: "star")
                                    .font(.system(size: 12))
                            }
                            if ((product.rating)! >= 3.0) {
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                                    .font(.system(size: 12))
                            } else if ((product.rating)! >= 2.5) {
                                Image(systemName: "star.leadinghalf.filled")
                                    .foregroundColor(.yellow)
                                    .font(.system(size: 12))
                            } else {
                                Image(systemName: "star")
                                    .font(.system(size: 12))
                            }
                            if ((product.rating)! >= 4.0) {
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                                    .font(.system(size: 12))
                            } else if ((product.rating)! >= 3.5) {
                                Image(systemName: "star.leadinghalf.filled")
                                    .foregroundColor(.yellow)
                                    .font(.system(size: 12))
                            } else {
                                Image(systemName: "star")
                                    .font(.system(size: 12))
                            }
                            if ((product.rating)! >= 5.0) {
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                                    .font(.system(size: 12))
                            } else if ((product.rating)! >= 4.5) {
                                Image(systemName: "star.leadinghalf.filled")
                                    .foregroundColor(.yellow)
                                    .font(.system(size: 12))
                            } else {
                                Image(systemName: "star")
                                    .font(.system(size: 12))
                            }
                            Spacer()
                        }
                    }.frame(height: 90)
                }
            }
        }
    }


    @ViewBuilder
    private func errorView(_ error: Error) -> some View {
        Text(error.localizedDescription)
    }
}

struct ProductDetailView: View {
    let product: Product

    var body: some View {
        VStack {
            Text("\(product.title ?? "")")
                .font(.title)
            Spacer()
            if let thumbnailURL = product.thumbnail {
                AsyncImage(url: thumbnailURL) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 300, height: 300)
                            .cornerRadius(10)
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .cornerRadius(8)
                    @unknown default:
                        Text("Unexpected state")
                    }
                }
            }
            Text("\(product.description ?? "")")
                .font(.body)
                .padding()
            Text("Currently have \(product.stock ?? 0) in stock")
                .font(.body)
            Spacer()
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
