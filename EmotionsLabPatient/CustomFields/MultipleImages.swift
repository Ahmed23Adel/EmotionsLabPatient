import SwiftUI


struct MultipleImages: View {
    @Binding var emotionsImages: [String: [ImageData]]
    @State var isSelected = false
    var body: some View {
        VStack {
            // Flatten and shuffle all images
            let allImages: [ImageData] = emotionsImages.values.flatMap { $0 }.shuffled()
            // Divide images into rows of 4
            let rows = stride(from: 0, to: allImages.count, by: 4).map {
                Array(allImages[$0..<min($0 + 4, allImages.count)])
            }
            
            // Iterate over the rows of images
            ForEach(0..<rows.count, id: \.self) { rowIndex in
                HStack {
                    // Iterate over the images in the current row
                    ForEach(rows[rowIndex]) { imageData in
                        Spacer()
                        SingleImageWithAnimation(imgName: imageData.imageName, isSelected: Binding<Bool>(
                            get: { imageData.isSelected },
                            set: { newValue in
                                // Find and update the image in the dictionary
                                if let index = emotionsImages[imageData.emotionName]?.firstIndex(where: { $0.id == imageData.id }) {
                                    emotionsImages[imageData.emotionName]?[index].isSelected = newValue
                                }
                            }
                        ))
                        Spacer()
                    }
                }
            }
        }
    }
}

#Preview {
    @State var emotionsImages: [String: [ImageData]] = [
        "Happy": [
            ImageData(imageName: "happy1", emotionName: "Happy", isSelected: false),
            ImageData(imageName: "happy2", emotionName: "Happy", isSelected: false),
            ImageData(imageName: "happy3", emotionName: "Happy", isSelected: false)
        ],
        "Disgusted": [
            ImageData(imageName: "disgusted1", emotionName: "Disgusted", isSelected: false),
            ImageData(imageName: "disgusted2", emotionName: "Disgusted", isSelected: false),
            ImageData(imageName: "disgusted3", emotionName: "Disgusted", isSelected: false)
        ],
        "Feared": [
            ImageData(imageName: "feared1", emotionName: "Feared", isSelected: false),
            ImageData(imageName: "feared2", emotionName: "Feared", isSelected: false),
            ImageData(imageName: "feared3", emotionName: "Feared", isSelected: false)
        ],
        "Surprised": [
            ImageData(imageName: "surprised1", emotionName: "Surprised", isSelected: false),
            ImageData(imageName: "surprised2", emotionName: "Surprised", isSelected: false),
            ImageData(imageName: "surprised3", emotionName: "Surprised", isSelected: false)
        ]
    ]
    MultipleImages(emotionsImages: $emotionsImages)
}
