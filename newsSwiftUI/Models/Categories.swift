import Foundation

enum Categories: String, Codable, CaseIterable {
    case all
    case business
    case entertainment
    case general
    case health
    case science
    case sports
    case technology
}

extension Categories: Identifiable {
    var id: Categories { self }
}
