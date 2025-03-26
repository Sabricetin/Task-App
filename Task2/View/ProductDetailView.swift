import SwiftUI

struct ProductDetailView: View {
    @StateObject private var viewModel = ProductDetailViewModel()
    let productId: Int

    var body: some View {
        ScrollView {
            if let productDetail = viewModel.selectedProductDetail {
                VStack(spacing: 20) {
                    // Ürün görseli
                    ProductImageView(imageUrl: productDetail.images.first ?? "")
                    
                    // Ürün adı
                    Text(productDetail.title)
                        .font(.title)
                        .bold()
                    
                    // Ürün açıklaması
                    Text(productDetail.description)
                        .font(.body)
                        .padding(.bottom)

                    // Ürün fiyatı
                    Text("\(productDetail.price) ₺")
                        .font(.title2)
                        .foregroundColor(.green)
                    
                    // Ürün kategorisi
                    Text("Kategori: \(productDetail.category)")
                        .font(.subheadline)
                        .foregroundColor(.gray)

                    // Puanlama
                    RatingView(rating: productDetail.rating)
                    
                    // Yorumlar
                    VStack(alignment: .leading) {
                        ForEach(productDetail.reviews, id: \.reviewerName) { review in
                            VStack(alignment: .leading) {
                                Text(review.reviewerName)
                                    .font(.subheadline).bold()
                                Text(review.comment)
                                    .font(.body)
                                Text("Puan: \(review.rating)")
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                            }
                            .padding()
                        }
                    }
                    
                    // Ürün geri iade politikası
                    Text("İade Politikası: \(productDetail.returnPolicy)")
                        .font(.footnote)
                        .foregroundColor(.gray)
                    
                    // Minimum sipariş miktarı
                    Text("Minimum Sipariş Miktarı: \(productDetail.minimumOrderQuantity)")
                        .font(.footnote)
                        .foregroundColor(.gray)

                    // Custom Button: Sepete Ekle Butonu
                    CustomButton(title: "Sepete Ekle", action: {
                        print("Ürün sepete eklendi")
                    })
                    .padding(.top)  // Buton ile içerik arasında biraz boşluk bırakabilirsiniz
                }
                .padding()
            } else {
                // Yükleme ekranı
                LoadingView()
            }
               
        }
        .navigationTitle("productDetail")
        .onAppear {
            viewModel.fetchProductDetail(for: productId)
        }
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(productId: 1)
            .previewLayout(.sizeThatFits)
    }
}
