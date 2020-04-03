import SwiftUI

class CategoriesViewModel: ObservableObject {
    @Published var categories = Categories.allCases
}
