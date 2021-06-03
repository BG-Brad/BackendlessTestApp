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
    @State var showHome = false
    
    var body: some View {
        ZStack {
            Image("multi")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .edgesIgnoringSafeArea(.all)
        //    ScrollView {
                VStack {
                    Spacer()
                    VStack {
                        HStack {
                            
                            Text("Asset")
                                .font(Font.custom("BigCityGrotesquePro-Regular", size: 35))
                                .foregroundColor(.white)
                            Text("ID")
                                .font(Font.custom("BigCityGrotesquePro-Regular", size: 35))
                                .bold()
                                .foregroundColor(.black)
                                .offset(x: -8)
                        }
                        HStack {
                            Text("Powered By")
                                .italic()
                                .font(Font.custom("BigCityGrotesquePro-Regular", size: 18))
                                
                                .foregroundColor(.white)
                            Text("Black")
                                .font(Font.custom("BigCityGrotesquePro-Regular", size: 18))
                                .foregroundColor(.black)
                            Text("Glove")
                                .font(Font.custom("BigCityGrotesquePro-Bold", size: 18))
                                .foregroundColor(.black)
                                .offset(x: -8)
                        }
                    }.offset(y: -25)
                    
                    //   Spacer().frame(height: 40)
                    if ((computerDetails.model?.contains("MacBook")) == true) {
                        Image("macbook")
                            .resizable()
                            .frame(width: 200, height: 150)
                            .onTapGesture {
                                self.nfcScanner.objectID = "0"
                               self.nfcScanner.nfcScanned.toggle()
                            }
                    } else if ((computerDetails.model?.contains("iMac")) == true) {
                        Image("imac")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200, height: 150)
                            .onTapGesture {
                                self.nfcScanner.objectID = "0"
                               self.nfcScanner.nfcScanned.toggle()
                            }
                        
                    }
                    Group {
                        Text(computerDetails.model ?? "")
                            .font(Font.custom("BigCityGrotesquePro-Regular", size: 35))
                            .italic()
                            .padding(.bottom, 15)
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                        VStack {
                            Text("Serial Number:")
                                .font(.subheadline)
                                .padding(.bottom, 10)
                            Text(computerDetails.serial_number ?? "")
                                .font(Font.custom("BigCityGrotesquePro-Bold", size: 30))
                        }
    
                    }.foregroundColor(.black)
                    Group {
                        Text("Property Of:")
                            .font(Font.custom("BigCityGrotesquePro-Regular", size: 35))
                            .padding(.bottom, 4)
                            .padding(.top, 30)
                        Text("\(computerDetails.owner ?? "")")
                            .font(Font.custom("BigCityGrotesquePro-Bold", size: 30))
                            .padding(.bottom, 45)
                    }.foregroundColor(.black)
                    Group {
                        Text("If Found: ")
                        Link("Call: \(computerDetails.phone ?? "")", destination: URL(string: "tel:\(computerDetails.phone ?? "")")!).foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        Link("Email: \(computerDetails.email ?? "")", destination: URL(string: "mailto:\(computerDetails.email ?? "")")!).foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    }.font(Font.custom("BigCityGrotesquePro-Regular", size: 28)).foregroundColor(.black)
                    //   Spacer().frame(height: 40)
                    
//                    if nfcScanner.nfcScanned {
//                        HStack {
//                            //GroupBox {
//                            Button(action: {
//                                self.nfcScanner.objectID = "0"
//                                self.nfcScanner.nfcScanned.toggle()
//                            }) {
//                                Text("Go Home")
//                            }
//                            //}
//                            GroupBox {
//                                Button(action: {
//                                    self.nfcScanner.startNFCReaderSession(invalidateAfterFirstRead: true)
//                                }) {
//                                    Text("Scan Another Tag")
//                                }
//                            }
//                        }
//                    }
                    
                Spacer()
                Spacer()
                } 
               // .offset(y: 50)
                .onAppear() {
                    itemLookup(objectID: objectID)
                }
                
         //   }
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
