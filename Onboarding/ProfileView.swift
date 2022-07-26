//
//  ProfileView.swift
//  Onboarding
//
//  Created by Shaheer Inayat Ali on 26/07/2022.
//

import SwiftUI

struct ProfileView: View {
    
    @AppStorage("name") var currentUsername: String?
    @AppStorage("age") var currentUserAge: Int?
    @AppStorage("gender") var currentUserGender: String?
    @AppStorage("signed_in") var currentUserSignedIn: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "person.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
            
            Text(currentUsername ?? "Your name here")
            Text("This user is \(currentUserAge ?? 18) old")
            Text("Their gender is \(currentUserGender ?? "Unknown")")
            
            Text("SIGN OUT")
                .foregroundColor(.white)
                .font(.headline)
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .background(.black)
                .cornerRadius(10)
                .onTapGesture {
                    signOut()
                }
        }
        .font(.title)
        .foregroundColor(.purple)
        .padding(60)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 6)
    }
    
    func signOut() {
        currentUsername =  nil
        currentUserAge = nil
        currentUserGender = nil
        withAnimation(.spring()) {
            currentUserSignedIn = false
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
