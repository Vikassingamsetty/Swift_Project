//
//  ViewController.swift
//  AppleLogin
//
//  Created by Singamsetty Vikas on 08/02/22.
//

import UIKit
import AuthenticationServices

class ViewController: UIViewController {

    var appleLogInButton : ASAuthorizationAppleIDButton = {
        let button = ASAuthorizationAppleIDButton()
        button.addTarget(self, action: #selector(handleLogInWithAppleID), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func viewWillLayoutSubviews() {
        view.addSubview(appleLogInButton)
        
        appleLogInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30) .isActive = true
        appleLogInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        appleLogInButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        appleLogInButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    @objc func handleLogInWithAppleID() {
        
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName,.email]
        
        //Shows popup to login
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
        
    }

}

// MARK: Extension
extension ViewController: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        switch authorization.credential {
            
        case let credentials as ASAuthorizationAppleIDCredential:
            let user = User(credentials: credentials)
            
            print(user, "Login successfull")
            
            //Option to check the state of the credentails
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            appleIDProvider.getCredentialState(forUserID: credentials.user) {  (credentialState, error) in
                 switch credentialState {
                    case .authorized:
                        // The Apple ID credential is valid.
                        break
                    case .revoked:
                        // The Apple ID credential is revoked.
                        break
                 case .notFound:
                        // No credential was found, so show the sign-in UI.
                        break
                    default:
                        break
                 }
            }
            
        default:
            break
        }
        
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        
        print("Error with credentials \(error)")
    }
    
}

extension ViewController: ASAuthorizationControllerPresentationContextProviding {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        
        return view.window!
    }
    
}




// MARK: Model For user
struct User {
    let id: String
    let firstName: String
    let lastName: String
    let email: String
    
    init(credentials: ASAuthorizationAppleIDCredential) {
        self.id = credentials.user
        self.firstName = credentials.fullName?.givenName ?? ""
        self.lastName = credentials.fullName?.familyName ?? ""
        self.email = credentials.email ?? ""
    }
    
}

extension User: CustomDebugStringConvertible {
    var debugDescription: String {
        return """
        ID: \(id),
        FIRSTNAME: \(firstName),
        LASTNAME: \(lastName),
        EMAIL: \(email)
        """
    }
}
