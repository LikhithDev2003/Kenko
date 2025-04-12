import SwiftUI

struct GoalSelectionCard: View {
    let title: String
    let subTitle: String?
    let icon: String
    let icon1: String
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 16) {
                if isSelected {
                    Image(icon1)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                }else {
                    Image(icon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                }
                
                VStack(alignment: .leading){
                    
                    Text(title)
                        .font(.callout)
                        .foregroundColor(isSelected ? .black : .white)
                    
                    if let subTitle = subTitle, !subTitle.isEmpty {
                        Text(subTitle)
                            .font(.caption)
                            .foregroundColor(isSelected ? .black : Color(hex: "#919191"))
                    }
                }
                Spacer()
                
                
            }
            .padding()
//            .padding(.vertical, 4)

            .background(
                RoundedRectangle(cornerRadius: 4)
                    .fill(
                        isSelected ? Color(hex: "#58A7B5") :Color(hex: "#2B2B2B")
                         )
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 4)
////                            .stroke(
////                                isSelected ? Color(hex: "#58A7B5") : Color.clear,
////                                lineWidth: 1
////                            )
//                    )
            )
        }
    }
}
