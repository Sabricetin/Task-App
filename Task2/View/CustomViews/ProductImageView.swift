import SwiftUI
import Combine

struct ProductImageView: View {
    @StateObject private var viewModel = ImageViewModel()
    var imageUrl: String
    
    var body: some View {
        if let image = viewModel.image {
            // Image(uiImage:) ile UIImage'ı Image türüne dönüştürüyoruz
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .cornerRadius(10)
        } else {
            ProgressView()
                .onAppear {
                    viewModel.loadImage(imageUrl: imageUrl)
                }
        }
    }
}

struct ProductImageView_Previews: PreviewProvider {
    static var previews: some View {
        ProductImageView(imageUrl: "https://imgv3.fotor.com/images/slider-image/A-clear-close-up-photo-of-a-woman.jpg")
            .previewLayout(.sizeThatFits)
    }
}
