//
//  ComputersDetailView.swift
//  BackendlessTestApp
//
//  Created by brad on 6/2/21.
//

import SwiftUI

struct ComputersDetailView: View {
    @State var objectID = ""
    @State private var computerDetails = ComputerData(owner: "", phone: "", created: 0, osVersion: "", computersClass: "", model: "", serial_number: "", ownerID: "", updated: 0, objectId: "", email: "")
    
    @EnvironmentObject var nfcScanner : NFCController
    
    var body: some View {
        ZStack {
            DetailLayoutView().onAppear() {
                itemLookup(objectID: objectID)
            }
            VStack {
                Group {
                    Text(computerDetails.model ?? "")
                    .font(Font.custom("BigCityGrotesquePro-Regular", size: 35))
                    .italic()
                    .padding(.bottom, 2)
                Text(computerDetails.serial_number ?? "")
                    .font(Font.custom("BigCityGrotesquePro-Bold", size: 30))
                Image(systemName: "square.and.arrow.up")
                    .font(.title)
                    .padding(.top, 5)
                    .padding(.bottom, 60)
                }.foregroundColor(.black)
                Group {
                Text("Property Of:")
                    .font(Font.custom("BigCityGrotesquePro-Regular", size: 35))
                    .padding(.bottom, 4)
                Text("\(computerDetails.owner ?? "")")
                    .font(Font.custom("BigCityGrotesquePro-Bold", size: 30))
                    .padding(.bottom, 45)
                }.foregroundColor(.black)
            Group {
            Text("If Found: ")
                Text("Call: \(computerDetails.phone ?? "")")
            Text("Email: \(computerDetails.email ?? "")")
            }.font(Font.custom("BigCityGrotesquePro-Regular", size: 28)).foregroundColor(.black)
          //  Spacer()
            
            }
        
        }
     
    }
    func itemLookup(objectID: String) {
        guard let url = URL(string: "https://api.backendless.com/C08AEFD1-0A68-2B5B-FF64-3E9E8B5D3900/A8742242-F7D8-4462-B416-370DCE64BF43/data/Computers/\(objectID)") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request) { ( data, _, _) in
            guard let data = data else { return }
            
            let compData = try! JSONDecoder().decode(ComputerData.self, from: data)
            print(compData)
            DispatchQueue.main.async {
                self.computerDetails = compData
                
            }
            
        }.resume()
        
    }
    
    
}

struct ComputersDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ComputersDetailView()
    }
}
