import SwiftUI

// Animasyonları merkezi bir yerden yönetmek için bir yardımcı fonksiyon oluşturuyoruz.
class ButtonAnimation {
    // Buton tıklanma animasyonu (küsme ve opaklık)
    static func applyPressAnimation(isPressed: Binding<Bool>) {
        withAnimation(.easeInOut(duration: 0.1)) {
            isPressed.wrappedValue = true
        }
        
        // 1 saniye sonra eski haline dönmesi
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            withAnimation(.easeInOut(duration: 0.3)) {
                isPressed.wrappedValue = false
            }
        }
    }
}
