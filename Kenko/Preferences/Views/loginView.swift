import SwiftUI

struct WelcomeScreen: View {
    var body: some View {
        ZStack {
            
            Image("LoginBg")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            // Gradient Overlay
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.clear,
                    Color.black.opacity(0.9),
                    Color.black
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)

            // Content
            VStack {
                Spacer()

                VStack(alignment: .leading, spacing: 20) {
                    
                    VStack (spacing: 2){
                        Text("Welcome to")
                            .foregroundColor(.white)
                            .font(.headline)
                        
                        Text("Kenko!")
                            .foregroundColor(Color(hex: "#58A7B5"))
                            .font(.title)
                            .bold()
                    }

                    Text("Unlock your best self—one step at a time.\nYour journey to a healthier, stronger you starts today.")
                        .foregroundColor(.white.opacity(0.7))
                        .font(.footnote)
                        .italic()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 24)
                .padding(.bottom, 40)

                // Sign in with Apple Button
                SignInWithAppleButton()
                    .padding(.horizontal, 64)
                    .padding(.bottom, 40)
            }
            .padding(.bottom, 80)
        }
    }
}


struct SignInWithAppleButton: View {
    var body: some View {
        Button(action: {
            
        }) {
            HStack {
                Image(systemName: "apple.logo")
                    .font(.headline)
                Text("Sign in with Apple")
                    .fontWeight(.medium)
            }
            .foregroundColor(.black)
            .frame(maxWidth: .infinity)
            .padding(.vertical,12)
            .background(Color.white)
            .cornerRadius(32)
        }
    }
}

