import Foundation

// MARK: - Localizations

typealias Localizations = String
extension Localizations {
    private var localizedString: String {
        return NSLocalizedString(self,
                                 bundle: Bundle(for: MockClassInBundle.self),
                                 comment: "")
    }

    static var ok = "OK".localizedString
    static var choose = "Choose".localizedString
    static var loading = "Loading".localizedString
    static var errorWrong = "ErrorWrong".localizedString
}

private class MockClassInBundle {}
