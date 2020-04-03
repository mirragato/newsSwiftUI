import SwiftUI

struct CategoryRowView: View {
    var category: Categories

    var body: some View {
        GeometryReader { geometry in
            Text(self.category.rawValue)
                .foregroundColor(.blue)
                .bold()
                .padding()
                .frame(alignment: .center)
        }
    }
}

#if DEBUG
struct CategoryRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CategoryRowView(category: .all)
            CategoryRowView(category: .science)
        }.previewLayout(.fixed(width: 600, height: 124))
    }
}
#endif
