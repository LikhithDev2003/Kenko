import SwiftUI

struct CustomTabView: View {
    @State private var selectedTab: Tab = .workout
    @ObservedObject private var appState = AppState.shared

    
    enum Tab: String, CaseIterable {
        case  workout, meals, profile
        
        var title: String {
            switch self {
            case .workout: return "Workout"
            case .meals: return "Meals"
            case .profile: return "Profile"
            }
        }
        
        var iconName: String {
            switch self {
            case .workout: return "Workout"
            case .meals: return "Meals"
            case .profile: return "Profile"
            }
        }
        
        var selectedIconName: String {
            return self.iconName + "1"
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            
            // Your main content can go here
            NavigationStack {
                switch selectedTab {
                    
                case .workout:
                    WorkoutScreenView()
                case .meals:
                    MealsScreenView()
                case .profile:
                    ProfileView()
                }
            }
            
//            Divider()
            if appState.isTabBarVisible {
                HStack {
                    ForEach(Tab.allCases, id: \.self) { tab in
                        Spacer()
                        
                        Button(action: {
                            selectedTab = tab
                        }) {
                            VStack(spacing: 4) {
                                Image(tab == selectedTab ? tab.selectedIconName : tab.iconName)
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                
                                Text(tab.title)
                                    .font(.caption)
                                    .bold(tab == selectedTab)
                                    .foregroundColor(.white)
                            }
                        }
                        
                        Spacer()
                    }
                }
                .padding(.vertical, 24)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color.black.opacity(1),
                            Color(hex: "#02161A"),
                            Color(hex: "#032329")
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .cornerRadius(0)
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}
