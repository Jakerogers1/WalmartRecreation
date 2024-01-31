//
//  SearchViewModel.swift
//  WalmartRecreation
//
//  Created by jmanerr on 1/30/24.
//

import Foundation


enum SearchLoadingState{
    case idle
    case loading
    case success(results: [Product])
    case error (error: Error)
}

@MainActor
class SearchViewModel: ObservableObject {
    // Inputs
    private let service = ProductService()
    @Published var state: SearchLoadingState = .idle
    @Published var title = ""
    @MainActor
    func searchProducts(title: String) async {
        do {
            self.state = .loading
            let products = try await ProductService.findProducts(title: title)
            let convertedProducts = products.map { product in
                let newProduct = product
                return newProduct
            }
                self.state = .success(results: convertedProducts)
        } catch {
                self.state = .error(error: error)

        }
    }


}
