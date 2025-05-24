import SwiftUI


struct MultiplieImageNamesView: View {
    @Binding var emotionNames: [String: [SingleImageName]]
    @StateObject private var viewModel = MultiplieImageNamesViewModel()
    var selectCurrentNameParentFunc: (SingleImageName) -> Void
    var body: some View {
        VStack(alignment: .center) {
            // Extract content to a separate view for clarity
            ImageRowsContent(rows: viewModel.shuffledRows, selectCurrentNameParentFunc: selectCurrentNameParentFunc)
            Spacer()
        }
        .padding(.top, 20)
        .onAppear {
            viewModel.setEmotionNames(emotionNames: emotionNames)
        }
    }
    
    private struct ImageRowsContent: View {
        let rows: [[SingleImageName]]
        var selectCurrentNameParentFunc: (SingleImageName) -> Void
        var body: some View {
            VStack(alignment: .center) {
                ForEach(rows.indices, id: \.self) { rowIndex in
                    SingleImageRow(row: rows[rowIndex], selectCurrentNameParentFunc: selectCurrentNameParentFunc)
                        .padding(.vertical, 5)
                }
            }
        }
    }
    
    private struct SingleImageRow: View {
        let row: [SingleImageName]
        @State private var imageNames: [SingleImageName]
        var selectCurrentNameParentFunc: (SingleImageName) -> Void
        init(row: [SingleImageName], selectCurrentNameParentFunc: @escaping (SingleImageName) -> Void) {
            self.row = row
            self._imageNames = State(initialValue: row)
            self.selectCurrentNameParentFunc = selectCurrentNameParentFunc
        }
        
        var body: some View {
            HStack(alignment: .center, spacing: 0) {
                Spacer()
                ForEach(imageNames.indices, id: \.self) { colIndex in
                    SingleImageNameWithAnimationView(currentSingleName: imageNames[colIndex], selectCurrentNameParentFunc: selectCurrentNameParentFunc)
                        .padding(.horizontal, 15)
                }
                Spacer()
            }
        }
    }
}
#Preview {
    @Previewable @State var emotionNames = [
        "happy" : [
            SingleImageName(emotionName: "happy"),
            SingleImageName(emotionName: "happy"),
            SingleImageName(emotionName: "happy"),
        ],
        "angry" : [
            SingleImageName(emotionName: "angry"),
            SingleImageName(emotionName: "angry"),
            SingleImageName(emotionName: "angry"),
        ],
        "feared" : [
            SingleImageName(emotionName: "feared"),
            SingleImageName(emotionName: "feared"),
            SingleImageName(emotionName: "feared"),
        ],
        "disguisted" : [
            SingleImageName(emotionName: "disguisted"),
            SingleImageName(emotionName: "disguisted"),
            SingleImageName(emotionName: "disguisted"),
        ],
    ]
    let dummyFunc: (SingleImageName) -> Void = { image in
        print("Dummy function called with: \(image)")
    }
    MultiplieImageNamesView(emotionNames: $emotionNames, selectCurrentNameParentFunc: dummyFunc)
}
