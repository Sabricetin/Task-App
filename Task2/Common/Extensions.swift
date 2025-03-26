
import Foundation
import SwiftUI


extension Color {
    static let primaryBackgroundColor = Color("PrimaryBackgroundColor")
    static let primaryTextColor = Color("PrimaryTextColor")
    static let primaryViewBackgroundColor = Color("PrimaryViewBackgroundColor")
    static let primaryViewTextColor = Color("PrimaryViewTextColor")
}

// String extension
extension String {
    func toDate(format: String = "yyyy-MM-dd") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }
}

// Date extension
extension Date {
    func toString(format: String = "yyyy-MM-dd") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
