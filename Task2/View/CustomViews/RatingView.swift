import SwiftUI

struct RatingView: View {
    var rating: Double
    var maxRating: Int = 5

    var body: some View {
        HStack {
            ForEach(0..<maxRating, id: \.self) { index in
                Image(systemName: index < Int(rating) ? "star.fill" : "star")
                    .foregroundColor(index < Int(rating) ? .yellow : .gray)
            }
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: 3.5)
            .previewLayout(.sizeThatFits)
    }
}
