import SwiftUI

struct MealsScreenView: View {
    @StateObject private var workoutViewModel = WorkoutViewModel()
    @StateObject private var viewModel = MealViewModel()
    @State private var expandedIndex: UUID? = nil
    @State private var isChatSheetPresented = false



    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 12) {
                Text("Meal Plan")
                    .font(.title).bold()
                    .foregroundColor(.white)
                
                Text("Balanced, tasty and built just for your goals!")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                
                VStack {
                    HStack {
                        VStack(alignment: .leading, spacing: 8){
                            Text("Grocery")
                                .foregroundColor(Color(hex: "#58A7B5"))
                                .font(.title3)
                                .bold()
                            
                            Text("Week 1")
                                .foregroundColor(.white)
                                .bold()
                                .font(.footnote)
                            
                            
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            
                        }) {
                            Text("View List")
                                .font(.subheadline.bold())
                                .foregroundColor(.black)
                                .padding(.vertical, 8)
                                .padding(.horizontal)
                                .background(Color(hex: "#58A7B5"))
                                .cornerRadius(30)
                            
                        }
                        
                    }
                    .padding(.vertical, 12)
                    .padding(.horizontal)
                    
                }
                .background(
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color(hex: "#1E1E1E"))
                )
                
                //            Scrollable Calendar
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(Array(workoutViewModel.weekDates.enumerated()), id: \.element.id) { index, workoutDate in
                            VStack {
                                Text(workoutDate.dayName)
                                    .font(.caption)
                                    .foregroundColor(workoutViewModel.selectedDateIndex == index ? .black : .white)
                                
                                Text(workoutDate.dayNumber)
                                    .font(.headline)
                                    .foregroundColor(workoutViewModel.selectedDateIndex == index ? .black : .white)
                            }
                            .frame(width: 32, height: 32)
                            .padding(8)
                            .background(
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(workoutViewModel.selectedDateIndex == index ? Color(hex: "#58A7B5") : Color.gray.opacity(0.2))
                            )
                            .onTapGesture {
                                workoutViewModel.selectDate(at: index)
                            }
                        }
                    }
                }
                .padding(.top)
                
                
                ScrollViewReader { proxy in
                    ScrollView {
                        VStack(spacing: 16) {
                            ForEach(Array(viewModel.mealDays.enumerated()), id: \.offset) { index, day in
                                MealDayCard(
                                    mealDay: day,
                                    isExpanded: viewModel.isExpanded(dayID: day.day ?? ""),
                                    isSelected: index == workoutViewModel.selectedDateIndex,
                                    onExpandToggle: {
                                        viewModel.toggleExpansion(for: day.day ?? "")
                                    }
                                )
                                .id(index) // 🔥 Assign ID for scrolling
                            }
                        }
                        .padding(.top)
                        .onChange(of: workoutViewModel.selectedDateIndex) { newIndex in
                            withAnimation {
                                proxy.scrollTo(newIndex, anchor: .center) // 🔥 Smooth scroll
                            }
                        }
                    }
                }
                
            }
            .padding()
            .background(Color.black.edgesIgnoringSafeArea(.all))
            .sheet(isPresented: $isChatSheetPresented) {
                ChatSheetView(
                    isPresented: $isChatSheetPresented,
                    viewModel: workoutViewModel,
                    mealViewModel: viewModel, // ✅ Make sure this is passed
                    isFromMealScreen: true
                )
            }
            VStack {
                Spacer()
                
                HStack {
                    
                    Spacer()
                    Button(action :{
                        isChatSheetPresented = true
                    }){
                        Image("Lunch")
                            .resizable()
                            .frame(width: 64, height: 64)
                            .clipShape(Circle())
                    }
                    .padding()
                    .padding(.bottom)
                    .padding(.trailing)
                }
            }

        }
    }
}
