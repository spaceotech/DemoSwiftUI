import SwiftUI

/// A view that represents a section with a title and a list of tags
struct SectionView: View {
    
    // MARK: - Properties
    
    /// The title of the section
    let title: String
    
    /// An array of tag strings to be displayed
    let tags: [String]
    
    /// The view model that manages the state of the shuffle feature
    var viewModel: ShuffleViewModel
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Section Title
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .lineLimit(nil)
                .multilineTextAlignment(.leading)
            
            // Tag List
            TagList(allTags: tags, viewModel: viewModel)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 20)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

// MARK: - Preview

struct SectionView_Previews: PreviewProvider {
    static var previews: some View {
        SectionView(
            title: "Sample Section",
            tags: ["Tag1", "Tag2", "Tag3"],
            viewModel: ShuffleViewModel()
        )
        .previewLayout(.sizeThatFits)
        .padding()
        .background(Color.gray.opacity(0.1))
    }
}
