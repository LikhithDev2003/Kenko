import SwiftUI


struct StepOneView: View {
    let onContinue: () -> Void
    @State private var selectedField: String?
    @ObservedObject var viewModel : PreferencesViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            // Title & Subtitle
            VStack(alignment: .leading, spacing: 4) {
                Text("Let’s Get to ")
                    .foregroundColor(.white)
                    .font(.title3) +
                Text("Know You")
                    .foregroundColor(Color(hex: "#58A7B5"))
                    .font(.title3)
                    .bold()

                Text("Share your basics to personalize your experience.")
                    .font(.subheadline)
                    .foregroundColor(Color(hex: "#EFEFEF"))
            }
            .padding(.vertical)

            // Form Fields
            ScrollView {
                Group {
                    VStack {
                        DropDownField(
                            label: "Gender",
                            value: viewModel.gender.isEmpty ? "Select" : viewModel.gender,
                            isSelected: selectedField == "Gender",
                            onTap: { toggleField("Gender") }
                        )
                        
                        if selectedField == "Gender" {
                            VStack(spacing: 0) {
                                ForEach(["Male", "Female", "Other"], id: \.self) { option in
                                    Divider()
                                    Text(option)
                                        .foregroundColor(.white)
                                        .padding()
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .background(Color(hex: "#1E1E1E"))
                                        .onTapGesture {
                                            viewModel.gender = option
                                            selectedField = nil
                                        }
                                }
                            }
                            .background(Color(hex: "#2B2B2B"))
                            .cornerRadius(6)
                        }
                    }

                    VStack {
                        DropDownField(
                            label: "Date of Birth",
                            value: dobFormatted,
                            isSelected: selectedField == "Date of Birth",
                            onTap: { toggleField("Date of Birth") }
                        )
                        if selectedField == "Date of Birth" {
                            DatePicker(
                                "",
                                selection: $viewModel.dob,
                                displayedComponents: [.date]
                            )
                            .datePickerStyle(.wheel)
                            .labelsHidden()
                            .frame(maxWidth: .infinity)
                            .background(Color(hex: "#1E1E1E"))
                            .cornerRadius(6)
                            .environment(\.colorScheme, .dark)
                            .onChange(of: viewModel.dob) { _ in selectedField = nil }
                        }
                    }

                    VStack {
                        DropDownField(
                            label: "Height",
                            value: "\(viewModel.height) cm",
                            isSelected: selectedField == "Height",
                            onTap: { toggleField("Height") }
                        )
                        if selectedField == "Height" {
                            Picker("", selection: $viewModel.height) {
                                ForEach(100...250, id: \.self) { num in
                                    Text("\(num) cm")
                                        .foregroundColor(.white)
                                }
                            }
                            .pickerStyle(.wheel)
                            .frame(height: 100)
                            .background(Color(hex: "#2B2B2B"))
                            .onChange(of: viewModel.height) { _ in selectedField = nil }
                        }

                    }

                    HStack(spacing: 12) {
                        // Weight
                        VStack(alignment: .leading, spacing: 4) {
                            DropDownField(
                                label: "Weight",
                                value: "\(viewModel.weight) kg",
                                isSelected: selectedField == "Weight",
                                onTap: { toggleField("Weight") }
                            )
                            
                            ZStack {
                                if selectedField == "Weight" {
                                    Picker("", selection: $viewModel.weight) {
                                        ForEach(30...150, id: \.self) { num in
                                            Text("\(num) kg")
                                                .foregroundColor(.white)
                                        }
                                    }
                                    .pickerStyle(.wheel)
                                    .background(Color(hex: "#2B2B2B"))
                                    .clipped()
                                    .onChange(of: viewModel.weight) { _ in selectedField = nil }
                                } else {
                                    Color.clear
                                }
                            }
                            .frame(height: 100) // Reserve space to keep alignment
                        }
                        .frame(maxWidth: .infinity)

                        // Goal Weight
                        VStack(alignment: .leading, spacing: 4) {
                            DropDownField(
                                label: "Goal weight",
                                value: "\(viewModel.goalWeight) kg",
                                isSelected: selectedField == "Goal weight",
                                onTap: { toggleField("Goal weight") }
                            )
                            
                            ZStack {
                                if selectedField == "Goal weight" {
                                    Picker("", selection: $viewModel.goalWeight) {
                                        ForEach(30...150, id: \.self) { num in
                                            Text("\(num) kg")
                                                .foregroundColor(.white)
                                        }
                                    }
                                    .pickerStyle(.wheel)
                                    .background(Color(hex: "#2B2B2B"))
                                    .clipped()
                                    .onChange(of: viewModel.goalWeight) { _ in selectedField = nil }
                                } else {
                                    Color.clear
                                }
                            }
                            .frame(height: 100) // Matches the same height
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
            }

            

            

            
            Button(action: onContinue) {
                Text("Continue")
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(hex: "#58A7B5"))
                    .cornerRadius(30)
            }

        }
        .padding(.horizontal)
    }
    
    var dobFormatted: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: viewModel.dob)
    }

    func toggleField(_ field: String) {
        selectedField = selectedField == field ? nil : field
    }
}
