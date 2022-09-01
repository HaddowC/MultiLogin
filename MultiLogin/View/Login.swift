//
//  Login.swift
//  MultiLogin
//
//  Created by Calum Haddow on 01/09/2022.
//

import SwiftUI


struct Login: View {
    @StateObject var loginModel: LoginViewModel = .init()
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack(alignment: .leading, spacing: 15) {
                Image(systemName: "triangle")
                    .font(.system(size: 38))
                    .foregroundColor(.indigo)
                
                (Text("Welcome, ")
                    .foregroundColor(.black) +
                Text("\nLogin to continue")
                    .foregroundColor(.gray)
                )
                .font(.title)
                .fontWeight(.semibold)
                .lineSpacing(10)
                .padding(.top,20)
                .padding(.trailing,15)
                
                // MARK: Custom Textfield
                CustomTextField(hint: "1 6505551234", text: $loginModel.mobileNo)
                    .disabled(loginModel.showOTPField)
                    .opacity(loginModel.showOTPField ? 0.4 : 1)
                    .overlay(alignment: .trailing, content: {
                        Button("Change") {
                            withAnimation(.easeInOut) {
                                loginModel.showOTPField = false
                                loginModel.otpCode = ""
                                loginModel.CLIENT_CODE = ""
                            }
                        }
                        .font(.caption)
                        .foregroundColor(.indigo)
                        .opacity(loginModel.showOTPField ? 1 : 0)
                        .padding(.trailing,15)
                    })
                    .padding(.top,50)
                
                
                CustomTextField(hint: "OTP Code", text: $loginModel.otpCode)
                    .disabled(!loginModel.showOTPField)
                    .opacity(!loginModel.showOTPField ? 0.4 : 1)
                    .padding(.top,20)
                
                
                Button(action: loginModel.showOTPField ? loginModel.verifyOTPCode : loginModel.getOTPCode){
                    HStack(spacing: 15) {
                        Text(loginModel.showOTPField ? "Verify Code" : "Get Code")
                            .fontWeight(.semibold)
                            //.contentTransition(.identity)
                        
                        Image(systemName: "line.diagonal.arrow")
                            .font(.title3)
                            .rotationEffect(.init(degrees: 45))
                        
                    } // End of HStack
                    .foregroundColor(.black)
                    .padding(.horizontal,25)
                    .padding(.vertical)
                    .background {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(.black.opacity(0.05))
                    }
                }
                .padding(.top,30)
                
            } // End of VStack
            .padding(.leading,60)
            .padding(.vertical,15)
            
        } // END OF SCROLL VIEW
        .alert(loginModel.errorMessage, isPresented: $loginModel.showError) {
        }
    }
}



struct Login_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
