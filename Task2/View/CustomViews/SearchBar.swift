import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    @FocusState private var isTextFieldFocused: Bool  // Focus durumunu kontrol etmek için

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
                .onTapGesture {
                    // İkon tıklandığında CustomTextField'a odaklan
                    isTextFieldFocused = true
                }
            
            CustomTextField(placeholder: "Ürün ara...", text: $searchText)
                .padding(7)
                .cornerRadius(10)
                .focused($isTextFieldFocused)  // Focus state'i bağla
        }
        .padding(.horizontal)
        .frame(height: 40)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 5)
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(searchText: .constant(""))
            .previewLayout(.sizeThatFits)
    }
}
