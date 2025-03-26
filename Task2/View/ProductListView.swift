import SwiftUI

struct ProductListView: View {
    @State private var searchText = ""
    @StateObject private var viewModel = ProductViewModel()

    var body: some View {
        NavigationView {
            VStack {
                // Arama çubuğu
                SearchBar(searchText: $searchText)
                
                // Ürün listesi
                List(viewModel.products.filter {
                    searchText.isEmpty || $0.title.lowercased().contains(searchText.lowercased())
                }, id: \.id) { product in
                    NavigationLink(destination: ProductDetailView(productId: product.id)) {
                        HStack {
                            // Ürün görseli
                            ProductImageView(imageUrl: product.thumbnail)
                            
                            VStack(alignment: .leading) {
                                Text(product.title)
                                    .font(.headline)
                                
                                // Ürün fiyatı
                                Text("\(product.price) ₺")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                
                                // Ürün kategorisi
                                Text(product.category)
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
                .navigationTitle("products")
                .onAppear {
                    viewModel.fetchProducts()
                }
                .background(GeometryReader { geometry in
                    Color.clear.onAppear {
                        // Kullanıcı listenin sonuna geldiğinde yeni verileri yükle
                        if geometry.frame(in: .global).maxY < UIScreen.main.bounds.height + 100 {
                           //burda siradaki sayfayi yukleyebiliriz
                        }
                    }
                })
            
                
            }
        }
       
    }
}

struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView()
            .previewLayout(.sizeThatFits)
    }
}
