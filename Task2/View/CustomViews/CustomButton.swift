import SwiftUI

struct CustomButton: View {
    var title: String
    var action: () -> Void
    
    @State private var isPressed = false  // Butonun basılı olup olmadığını takip eder
    
    var body: some View {
        Button(action: {
            withAnimation(.easeInOut(duration: 0.1)) {
                isPressed = true  // Buton basıldığında animasyonu başlat
            }
            action()  // Buton tıklama aksiyonunu tetikler
            
            // 1 saniye sonra eski haline dönmesi için
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.easeInOut(duration: 0.3)) {
                    isPressed = false  // Buton eski haline döner
                }
            }
        }) {
            Text(title)
                .font(.headline)
                .foregroundColor(.primaryViewText)
                .padding()
                .frame(maxWidth: .infinity)
                .background(.primaryViewBackground)
                .cornerRadius(10)
                .scaleEffect(isPressed ? 0.95 : 1)  // Butonun tıklanma animasyonu
                .opacity(isPressed ? 0.8 : 1)      // Butonun tıklanırken opaklığının azalması
                .animation(.easeInOut(duration: 0.1), value: isPressed) // Animasyonu tanımlıyoruz
        }
        .padding(.horizontal)
    }
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            CustomButton(title: "Ürünü Ekle", action: { print("Button tapped") })
                .previewLayout(.sizeThatFits)
                .previewDisplayName("Light Mode")
                .preferredColorScheme(.light)
            
            CustomButton(title: "Ürünü Ekle", action: { print("Button tapped") })
                .previewLayout(.sizeThatFits)
                .previewDisplayName("Dark Mode")
                .preferredColorScheme(.dark)
        }
    }
}
