//
//  HomeView.swift
//  BackendlessTestApp
//
//  Created by brad on 6/2/21.
//

import SwiftUI
import Backendless

@objcMembers class Computers: NSObject {
    var owner, phone: String?
    var created: Int?
    var osVersion, computersClass, model, serialNumber: String?
    var ownerID: String?
    var updated: Int?
    var email: String?
    var objectID : String?
}

var computerStore : DataStoreFactory = Backendless.shared.data.of(Computers.self)

struct HomeView: View {
    
    let API_HOST = "https://api.backendless.com"
    let APP_ID =  "C08AEFD1-0A68-2B5B-FF64-3E9E8B5D3900"
    let API_KEY = "37018558-C87F-4698-8335-75C87FBE433F"
    let REST_API_KEY = "A8742242-F7D8-4462-B416-370DCE64BF43"
    
    @State var computersList = [ComputerData]()
    @State var data = ""
    @EnvironmentObject var nfcScanner : NFCController
    @State var showSheet = false
    
    var body: some View {
        NavigationView {
            if nfcScanner.objectID.count > 5 {
                
                ComputersDetailView(objectID: nfcScanner.objectID)
            }
                else {
            VStack {
                Button(action: {
                    self.nfcScanner.startNFCReaderSession(invalidateAfterFirstRead: true)
                    print("ID: \(nfcScanner.objectID)")
                }) {
                    
                    Image(systemName: "wave.3.forward.circle.fill")
                        .imageScale(.large)
                    Text("Tap To Scan NFC  Tag")
                        .font(.title3)
                }
                
            List {
                ForEach(computersList, id: \.self) { computers in
                    NavigationLink(destination: ComputersDetailView(objectID: computers.objectId!)) {
                        Text(computers.serial_number ?? "-")
                    }
                    
                }
            }
               // NavigationLink(destination: ComputersDetailView(objectID: nfcData.nfcTag)) {
             
               // }
        }
            .navigationTitle(Text("Computers"))
        }
        
        }.onAppear() {
            itemLookup()
        }
    }
    func itemLookup() {
        guard let url = URL(string: "https://api.backendless.com/\(APP_ID)/\(REST_API_KEY)/data/Computers") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request) { ( data, _, _) in
            guard let data = data else { return }
            
            let movieDetails = try! JSONDecoder().decode([ComputerData].self, from: data)
            // print(movieDetails[1].objectId)
            DispatchQueue.main.async {
                self.computersList = movieDetails
            }
            
        }.resume()
        
    }
    
    
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


