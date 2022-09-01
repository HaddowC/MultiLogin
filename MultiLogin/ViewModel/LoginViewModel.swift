//
//  LoginViewModel.swift
//  MultiLogin
//
//  Created by Calum Haddow on 01/09/2022.
//

import Firebase
import SwiftUI


class LoginViewModel: ObservableObject {
    
    // MARK: View Properties
    @Published var mobileNo: String = ""
    @Published var otpCode: String = ""
    
    @Published var CLIENT_CODE: String = ""
    @Published var showOTPField: Bool = false
    
    // MARK: Error Properties
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    
    // MARK: Firebase API's
    func getOTPCode() {
        UIApplication.shared.closeKeyboard()
        Task {
            do {
                // MARK: Disable it when testing with Real Device
                Auth.auth().settings?.isAppVerificationDisabledForTesting = true
                
                let code = try await PhoneAuthProvider.provider().verifyPhoneNumber("+\(mobileNo)", uiDelegate: nil)
                await MainActor.run(body: {
                    CLIENT_CODE = code
                    // MARK: Enabling OTP Field when it's success
                    withAnimation(.easeInOut) { showOTPField = true}
                })
            } catch {
                await handleError(error: error)
            }
        }
        
    }
    
    func verifyOTPCode() {
        UIApplication.shared.closeKeyboard()
        Task {
            do {
                let credential = PhoneAuthProvider.provider().credential(withVerificationID: CLIENT_CODE, verificationCode: otpCode)
                
                try await Auth.auth().signIn(with: credential)
                
                // MARK: User Logged in successfully
                print("success!")
            } catch {
                await handleError(error: error)
            }
        }
        
    }
    
    // MARK: Handling Error
    func handleError(error: Error) async {
        await MainActor.run(body: {
            errorMessage = error.localizedDescription
            showError.toggle()
        })
    }
    
}

extension UIApplication {
    func closeKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}


