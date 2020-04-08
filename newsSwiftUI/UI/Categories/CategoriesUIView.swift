import SwiftUI

struct CategoriesUIView: View {
    @ObservedObject var viewModel: CategoriesViewModel

    init(viewModel: CategoriesViewModel) {
        self.viewModel = viewModel
        UITableView.appearance().tableFooterView = UIView()
        UITableView.appearance().separatorStyle = .none
    }

    var body: some View {
        NavigationView {
            List(viewModel.categories, id: \.rawValue) { category in
                VStack {
                    CategoryRowView(category: category)
                    Divider()
                }
            }
                .navigationBarTitle(Text(String.choose), displayMode: .large)
            
        }
    }
}

struct CategoriesUIView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesUIView(viewModel: CategoriesViewModel())
    }
}
