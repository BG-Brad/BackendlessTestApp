//
//  LoginView.swift
//  BackendlessTestApp
//
//  Created by brad on 6/17/21.
//

import SwiftUI

struct LoginView: View {
    
    @State var username = ""
    @State var password = ""
    @State var authenticated = false
    let token = "277f777777757e257a33272f7a45ca34ef75d35d7cad5522de465553a673fca6"
    @EnvironmentObject var observedObject : ObservedObjectes
    @EnvironmentObject var nfcScanner : NFCController
    @ObservedObject var userSettings = UserSettings()
    
    
    var body: some View {
        if observedObject.isAuthenticatedUser == true  {
            HomeView().environmentObject(self.nfcScanner).environmentObject(self.observedObject)
        } else {
        VStack {
            Text("Authentication Test")
            Form {
                TextField("Username", text: $username, onCommit: {self.userSettings.username = "\(username)"})
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                SecureField("Password", text: $password, onCommit: {self.userSettings.password = "\(password)"})
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
            }.frame(height: 300)
            Text("\(observedObject.message)")
            Spacer()
            
            Button( action: {
                loginUser()
            }) {
                Text("Login")
            }
            
          
            Spacer()
            
        }
        }
    }
    func loginUser() {
        
        let token = "277f777777757e257a33272f7a45ca34ef75d35d7cad5522de465553a673fca6"
        
        
        let auth = "\(userSettings.username):\(userSettings.password)".data(using: String.Encoding.utf8)!.base64EncodedString(options: [])
        let parameters = "{\n    \"operation\": \"list_users\",\n    \"options\": {\n        \"types\": [\"ENDUSER\"],\n        \"name_like\": \"api\"\n    }"
        let postData = parameters.data(using: .utf8)
        
        var request = URLRequest(url: URL(string: "https://businessapi.mosyle.com/v1/users")!,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("\(token)", forHTTPHeaderField: "accesstoken")
        request.addValue("Basic \(auth)", forHTTPHeaderField: "Authorization")
        
        request.httpMethod = "POST"
        request.httpBody = postData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                
                return
            }
            print(String(data: data, encoding: .utf8)!)
            
            let response = (String(data: data, encoding: .utf8)!)
            
            if response.contains("OK")
            {
                DispatchQueue.main.async {
                    self.observedObject.isAuthenticatedUser = true
                    self.observedObject.message = "Welcome"
                }
                
            }
            else if response.contains("WRONG_PASSWORD") {
                DispatchQueue.main.async {
                    self.observedObject.message = "Invalid Password"
                }
            }
            else if response.contains("Whoops") {
                DispatchQueue.main.async {
                    self.observedObject.message = "User Not Authorized"
                }
            }
            
        }
        task.resume()
        
    }
    
    
    
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}



