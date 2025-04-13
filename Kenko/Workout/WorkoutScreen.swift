import SwiftUI

struct WorkoutScreenView: View {
    @StateObject private var viewModel = WorkoutViewModel()
    @State private var selectedPlanForDetail: WorkoutDayEntity?
    @State private var isChatSheetPresented = false
    

    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 12) {
                Text("Workouts")
                    .font(.title).bold()
                    .foregroundColor(.white)
                
                Text("Let’s crush your goals, Likhith!")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(Array(viewModel.weekDates.enumerated()), id: \.element.id) { index, workoutDate in
                            VStack {
                                Text(workoutDate.dayName)
                                    .font(.caption)
                                    .foregroundColor(viewModel.selectedDateIndex == index ? .black : .white)
                                
                                Text(workoutDate.dayNumber)
                                    .font(.headline)
                                    .foregroundColor(viewModel.selectedDateIndex == index ? .black : .white)
                            }
                            .frame(width: 32, height: 32)
                            .padding(8)
                            .background(
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(viewModel.selectedDateIndex == index ? Color(hex: "#58A7B5") : Color.gray.opacity(0.2))
                            )
                            .onTapGesture {
                                withAnimation {
                                    viewModel.selectDate(at: index)
                                }
                            }
                        }
                    }
                }
                .padding(.top)
                
                ScrollViewReader { proxy in
                    ScrollView {
                        VStack(spacing: 16) {
                            ForEach(Array(viewModel.workoutDays.enumerated()), id: \.offset) { index, dayEntity in
                                WorkoutCardView(
                                    plan: dayEntity,
                                    isSelected: index == viewModel.selectedDateIndex,
                                    onViewDetail: {
                                        AppState.shared.isTabBarVisible = false
                                        selectedPlanForDetail = dayEntity
                                    }
                                )
                                .id(index)
                            }
                        }
                        .onChange(of: viewModel.selectedDateIndex) { newIndex in
                            withAnimation {
                                proxy.scrollTo(newIndex, anchor: .center)
                            }
                        }
                    }
                }
                
                
                NavigationLink(
                    destination: selectedPlanForDetail.map { PlanDetailScreen(plan: $0) },
                    isActive: Binding(
                        get: { selectedPlanForDetail != nil },
                        set: { if !$0 { selectedPlanForDetail = nil } }
                    )
                ) {
                    EmptyView()
                }
                .hidden()
                
            }
            .padding()
            .background(Color.black.edgesIgnoringSafeArea(.all))
            .sheet(isPresented: $isChatSheetPresented) {
                ChatSheetView(
                    isPresented: $isChatSheetPresented,
                    viewModel: viewModel,
                    isFromMealScreen: false // ✅ Set the flag
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
