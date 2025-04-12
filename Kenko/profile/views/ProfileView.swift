//
//  ProfileScreen.swift
//  Re_Note
//
//  Created by apple on 09/04/25.
//
import SwiftUI


struct ProfileView: View {
    var body: some View {
        VStack(spacing: 0) {
            // Gradient Top Section
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(hex: "#032329"),
                        Color(hex: "#124F5C"),
                        Color(hex: "#326672")
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                
                VStack(spacing: 12) {
                    HStack {
                        Text("Profile")
                            .font(.title).bold()
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.top, 40)

                    
                    VStack{
                        // Edit button aligned to the top trailing
//                        HStack {
//                            Spacer()
////                            Button(action: {
////                                // Handle edit
////                            }) {
////                                HStack(spacing: 4) {
////                                    Image("Pencil")
////                                        .resizable()
////                                        .frame(width: 16, height: 16)
////                                    Text("Edit")
////                                        .font(.callout)
////                                        .foregroundColor(.white)
////                                }
////                            }
//                        }
//                        .padding(.trailing)
                        
                        // Centered profile image
                        Image("profilePic")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 2))
                            .padding(.top, -8) // Optional: adjust spacing
                        
                        // Name
                        VStack(spacing: 4) {
                            Text("Likhith")
                                .foregroundColor(.white)
                                .font(.headline)
                                .bold()
                            Text("likhithu@renote")
                                .foregroundColor(.white)
                                .font(.caption)
                        }
                        .padding(.bottom)
                    }

                    // Profile Metrics
                    HStack(spacing: 0) {
                        ProfileMetricView(value: "64", unit: "kg", label: "Weight")
                        Divider().frame(height: 40).background(Color.gray)
                        ProfileMetricView(value: "175", unit: "cm", label: "Height")
                        Divider().frame(height: 40).background(Color.gray)
                        ProfileMetricView(value: "23", unit: "years", label: "Age")
                    }
                    .padding()
                    .background(Color(hex: "#2B2B2B"))
                    .cornerRadius(4)
                    .padding(.horizontal)

                }
            }
            .frame(height: 380)

            // Bottom Card Section
            VStack(spacing: 24) {
                ScrollView {
                    VStack(spacing: 16) {
                        // Connect Banner
                        HStack {
                            Text("Connect to ")
                                .foregroundColor(.white)
                            +
                            Text("health app")
                                .foregroundColor(Color(hex: "#58A7B5"))

                            Spacer()

                            Button(action: {
                                // Handle close
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.white.opacity(0.6))
                            }
                        }
                        .padding()
                        .background(Color(hex: "#2B2B2B"))
                        .cornerRadius(4)

                        // Preferences Card
                        VStack(spacing: 16) {
                            // Header
                            HStack {
                                Text("Preferences")
                                    .foregroundColor(.white)
                                    .font(.headline)
                                    .bold()
                                Spacer()

                            }

                            // Workout Section
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Workout")
                                    .foregroundColor(.white.opacity(0.8))
                                    .font(.subheadline)

                                PreferenceItem(label: "Goal weight", value: "50kg")
                                PreferenceItem(label: "Fitness goal", value: "Lose Fat")
                                PreferenceItem(label: "Activity goal", value: "4 days/week")
                            }
                            
                            Divider()

                            // Diet Section
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Diet")
                                    .foregroundColor(.white.opacity(0.8))
                                    .font(.subheadline)

                                PreferenceItem(label: "Nutrition preferences", value: "Vegan")
                                PreferenceItem(label: "Dietary restrictions", value: "Lactose Free")
                                PreferenceItem(label: "Cuisines", value: "Indian, Mediterranean")
                            }
                        }
                        .padding()
                        .background(Color(hex: "#2B2B2B"))
                        .cornerRadius(4)
                    }
                }
            }
            .padding()
            .background(Color.black)
            .cornerRadius(24, corners: [.topLeft, .topRight])
            .edgesIgnoringSafeArea(.bottom)

            Spacer()
        }
        .edgesIgnoringSafeArea(.top)
        .background(Color.black)
    }
}





