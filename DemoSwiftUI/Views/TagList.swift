import SwiftUI

/// A view that displays a list of tags in a flowing layout
struct TagList: View {
    
    // MARK: - Properties
    
    @State var allTags: [String]
    @ObservedObject var viewModel: ShuffleViewModel
    
    // MARK: - Private Properties
    
    private var orderedTags: [String] { allTags }
    
    // MARK: - Private Methods
    
    /// Calculates the number of tags that can fit in each row
    private func rowCounts(_ geometry: GeometryProxy) -> [Int] {
        TagList.rowCounts(tags: orderedTags, padding: 26, parentWidth: geometry.size.width)
    }
    
    /// Retrieves the tag for a specific position in the layout
    private func tag(rowCounts: [Int], rowIndex: Int, itemIndex: Int) -> String {
        let sumOfPreviousRows = rowCounts.enumerated().reduce(0) { total, next in
            next.offset < rowIndex ? total + next.element : total
        }
        let orderedTagsIndex = sumOfPreviousRows + itemIndex
        guard orderedTags.indices.contains(orderedTagsIndex) else { return "[Unknown]" }
        return orderedTags[orderedTagsIndex]
    }
    
    // MARK: - Body
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                ForEach(0..<self.rowCounts(geometry).count, id: \.self) { rowIndex in
                    HStack {
                        ForEach(0..<self.rowCounts(geometry)[rowIndex], id: \.self) { itemIndex in
                            TagButton(
                                title: self.tag(rowCounts: self.rowCounts(geometry), rowIndex: rowIndex, itemIndex: itemIndex),
                                viewModel: self.viewModel
                            )
                        }
                        Spacer()
                    }.padding(.vertical, 4)
                }
                Spacer()
            }
        }
    }
}

// MARK: - String Extension

extension String {
    /// Calculates the width of the string when rendered with a given font
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
}

// MARK: - TagList Extension

extension TagList {
    /// Calculates how many tags can fit in each row based on the parent width
    static func rowCounts(tags: [String], padding: CGFloat, parentWidth: CGFloat) -> [Int] {
        let tagWidths = tags.map { $0.widthOfString(usingFont: UIFont.preferredFont(forTextStyle: .headline)) }
        
        var currentLineTotal: CGFloat = 0
        var currentRowCount: Int = 0
        var result: [Int] = []
        
        for tagWidth in tagWidths {
            let effectiveWidth = tagWidth + (2 * padding)
            if currentLineTotal + effectiveWidth <= parentWidth {
                currentLineTotal += effectiveWidth
                currentRowCount += 1
                if result.isEmpty {
                    result.append(1)
                } else {
                    result[result.count - 1] = currentRowCount
                }
            } else {
                currentLineTotal = effectiveWidth
                currentRowCount = 1
                result.append(1)
            }
        }
        return result
    }
}
