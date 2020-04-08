import SwiftUI

struct CategoriesUIView: View {
    @ObservedObject var viewModel: CategoriesViewModel

    init(viewModel: CategoriesViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            List(viewModel.categories, id: \.rawValue) { CategoryRowView(category: $0)
            }
                .navigationBarTitle(Text(String.choose), displayMode: .large)
            .onAppear { UITableView.appearance().tableFooterView = UIView() }
        }
    }
}

struct CategoriesUIView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesUIView(viewModel: CategoriesViewModel())
    }
}
