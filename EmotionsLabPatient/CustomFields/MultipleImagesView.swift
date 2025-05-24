
import SwiftUI


struct SingleImageWrapper: View {
    @ObservedObject var image: SingleImage
    var selectCurrentImageParentFunc: (SingleImage, Bool) -> Void
    
    init(image: SingleImage, selectCurrentImageParentFunc: @escaping (SingleImage, Bool) -> Void) {
        self.image = image
        self.selectCurrentImageParentFunc = selectCurrentImageParentFunc
    }
    
    var body: some View {
        Spacer()
        SingleImageWithAnimationView(currentImage: image, selectCurrentImageParentFunc: selectCurrentImageParentFunc)
        Spacer()
    }
}

struct ImageRow: View {
    let rowImages: [SingleImage]
    var selectCurrentImageParentFunc: (SingleImage, Bool) -> Void
    var body: some View {
        HStack {
            ForEach(Array(rowImages.enumerated()), id: \.offset) { pair in
                SingleImageWrapper(image: pair.element, selectCurrentImageParentFunc: selectCurrentImageParentFunc)
            }
        }
    }
}

struct MultipleImagesView: View {
    @Binding var emotionsImages: [String: [SingleImage]]
    @State var isSelected = false
    var selectCurrentImageParentFunc: (SingleImage, Bool) -> Void
    var body: some View {
        VStack {
            let rows = createRows()
            
            ForEach(Array(rows.enumerated()), id: \.offset) { pair in
                ImageRow(rowImages: pair.element, selectCurrentImageParentFunc: selectCurrentImageParentFunc)
            }
        }
    }
    
    private func createRows() -> [[SingleImage]] {
        // Flatten and shuffle all images
        let allImages = emotionsImages.values.flatMap { $0 }.shuffled()
        
        var rows: [[SingleImage]] = []
        for i in stride(from: 0, to: allImages.count, by: 4) {
            let upperBound = min(i + 4, allImages.count)
            let row = Array(allImages[i..<upperBound])
            rows.append(row)
        }
        
        return rows
    }
}

#Preview {
    @Previewable @State var emotionsImages: [String: [SingleImage]] = [
        "Happy": [
            SingleImage(imageName: "happy1", emotionName: "Happy"),
            SingleImage(imageName: "happy2", emotionName: "Happy"),
            SingleImage(imageName: "happy3", emotionName: "Happy")
        ],
        "Disgusted": [
            SingleImage(imageName: "disgusted1", emotionName: "Disgusted"),
            SingleImage(imageName: "disgusted2", emotionName: "Disgusted"),
            SingleImage(imageName: "disgusted3", emotionName: "Disgusted")
        ],
        "Feared": [
            SingleImage(imageName: "feared1", emotionName: "Feared"),
            SingleImage(imageName: "feared2", emotionName: "Feared"),
            SingleImage(imageName: "feared3", emotionName: "Feared")
        ],
        "Surprised": [
            SingleImage(imageName: "surprised1", emotionName: "Surprised"),
            SingleImage(imageName: "surprised2", emotionName: "Surprised"),
            SingleImage(imageName: "surprised3", emotionName: "Surprised")
        ]
    ]
    let dummyFunc: (SingleImage, Bool) -> Void = { image, isSelected in
        print("Dummy function called with: \(image), selected: \(isSelected)")
    }
    MultipleImagesView(emotionsImages: $emotionsImages, selectCurrentImageParentFunc: dummyFunc)
}
