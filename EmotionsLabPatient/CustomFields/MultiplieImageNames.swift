import SwiftUI

struct MultiplieImageNames: View {
    @Binding var emotionNumbersShown: [String: Int]
    
    var body: some View {
        VStack(alignment: .center) {
            let allEmotions = emotionNumbersShown.flatMap { emotion, count in
                Array(repeating: emotion, count: count)
            }.shuffled()
            
            let rows = stride(from: 0, to: allEmotions.count, by: 4).map {
                Array(allEmotions[$0..<min($0 + 4, allEmotions.count)])
            }
            
            ForEach(rows.indices, id: \.self) { rowIndex in
                HStack(alignment: .center, spacing: 0) {
                    Spacer()
                    
                    ForEach(rows[rowIndex].indices, id: \.self) { colIndex in
                        SingleImageNameWithAnimation(text: rows[rowIndex][colIndex])

                            .padding(.horizontal, CGFloat.random(in: 10...40))
                    }
                    
                    Spacer()
                }
                .padding(.vertical, 5)
            }
            
            // Push content to the top by adding a spacer that takes remaining space
            Spacer()
        }
        .padding(.top, 20) // Add some padding at the top of the screen
    }
}

#Preview {
    @State var emotionNumbersShown = [
        "happy" : 3,
        "sad" : 3,
        "angry" : 3,
        "surprised" : 3,
    ]
    MultiplieImageNames(emotionNumbersShown: $emotionNumbersShown)
}
