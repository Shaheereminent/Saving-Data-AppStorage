//
//  OnBoardingView.swift
//  Onboarding
//
//  Created by Shaheer Inayat Ali on 26/07/2022.
//

import SwiftUI

struct OnboardingView: View {
    
    /*
     determining which screen user is
     0 - Welcome Screen
     1 - Add name
     2 - Add age
     3 - Add gender
     */
    @State var onboardingState: Int = 0
    let transition: AnyTransition = .asymmetric(
        insertion: .move(edge: .trailing),
        removal: .move(edge: .leading))
    
    @State var name: String = ""
    
    @State var age: Double = 50
    
    @State var gender: String = ""
    
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    
    @AppStorage("name") var currentUsername: String?
    @AppStorage("age") var currentUserAge: Int?
    @AppStorage("gender") var currentUserGender: String?
    @AppStorage("signed_in") var currentUserSignedIn: Bool = false
    
    var body: some View {
        ZStack {
            // content
            ZStack {
                switch onboardingState {
                case 0:
                    welcomeSection
                        .transition(transition)
                case 1:
                    addNameSection
                        .transition(transition)
                case 2:
                    addAgeSection
                        .transition(transition)
                case 3:
                    addGenderSection
                        .transition(transition)
                default:
                    RoundedRectangle(cornerRadius: 25.0)
                        .foregroundColor(.green)
                }
            }
            
            // Button
            VStack {
                Spacer()
                bottomButton
                    .padding(30)
            }
            
        } // : ZStack button sign in
        .alert(isPresented: $showAlert, content: {
            return Alert(title: Text(alertTitle))
        })
        
    }
} // : Onboarding File View End


struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
            .background(Color.purple)
    }
}

// MARK: COMPONENTS
extension OnboardingView {
    
    private var bottomButton: some View {
        Text(onboardingState == 0 ? "SIGN UP" :
                onboardingState == 3 ? "FINISH" :
                "NEXT"
        )
        .font(.headline)
        .foregroundColor(.purple)
        .frame(height: 60)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(10)
        .onTapGesture {
            handleNextButtonPressed()
        }
    } // : Bottom Button View
    
    
    // MARK: Welcome Section Private Var
    private var welcomeSection: some View {
        VStack(spacing: 40) {
            Spacer()
            Image(systemName: ("heart.text.square.fill"))
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .foregroundColor(.white)
            
            Text("Find your match")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .overlay(
                    Capsule(style: .continuous)
                        .frame(height: 3)
                        .offset(y: 5)
                        .foregroundColor(.white)
                    , alignment: .bottom
                )
            
            Text("This is the number 1 App for finding your match online praciting using @Appstorage and other SwiftUI Techniques")
                .fontWeight(.medium)
                .foregroundColor(.white)
        
            Spacer()
            Spacer()
            
        } // : VStack Welcome Content Container
        .multilineTextAlignment(.center)
        .padding(.horizontal, 40)
        
    } // : extension welcome wection end
    
    // MARK: Add Name Section
    private var addNameSection: some View {
        
        VStack(spacing: 20) {
            Spacer()
            
            Text("What's your name?")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            
            TextField("Write your name here...", text: $name)
                .font(.headline)
                .frame(height: 60)
                .padding(.horizontal)
                .background(Color.white)
                .cornerRadius(10)
            
            Spacer()
            Spacer()
            
        } // : VStack Add Name Container
        .padding(30)
        
    } // extension Add Name Section end
    
    // MARK: Add Age Section
    private var addAgeSection: some View {
        
        VStack(spacing: 20) {
            Spacer()
            
            Text("What's your age?")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            
            Text("\(String(format: "%.0f", age))")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            
            Slider(value: $age, in: 18...100, step: 1)
                .accentColor(.white)
            
            Spacer()
            Spacer()
            
        } // : VStack Add Age Container
        .padding(30)
        
    } // Add Age Section End
    
    // MARK: Add Gender Section
    private var addGenderSection: some View {
        
        VStack(spacing: 20) {
            Spacer()
            
            Text("What's your gender?")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            
            
            
            Picker("Select your gender",
                   selection: $gender,
                   content: {
                Section("Select your gender") {
                    Text("Male").tag("Male")
                    Text("Female").tag("Female")
                    Text("Non-Binary").tag("Non-Binary")
                }
            })
            .frame(height: 60)
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .cornerRadius(10)
            .pickerStyle(MenuPickerStyle())
            
            
            
            Spacer()
            Spacer()
            
        } // : VStack Add Gender Container
        .padding(30)
        
    } // Add Gender Section End
    
} // : Extension obboarding end


// MARK: FUNCTIONS
extension OnboardingView {
    
    func handleNextButtonPressed() {
        // CHECK INPUTS
        switch onboardingState {
        case 1:
            guard name.count >= 3 else {
                showAlert(title: "3 letters name is required")
                return
            }
        case 3:
            guard gender.count > 1 else {
                showAlert(title: "Please select a gender")
                return
            }
        default:
            break
        }
        
        
        // GO TO NEXT SCREEN
        if onboardingState == 3 {
            signIn()
        } else {
            withAnimation(.spring()) {
                onboardingState += 1
            }
        }

    }
    
    func signIn() {
        currentUsername = name
        currentUserAge = Int(age)
        currentUserGender = gender
        withAnimation(.spring()) {
            currentUserSignedIn = true
        }
        
    }
    
    func showAlert(title: String) {
        alertTitle = title
        showAlert.toggle()
    }
    
} // Functions onboarding view end
