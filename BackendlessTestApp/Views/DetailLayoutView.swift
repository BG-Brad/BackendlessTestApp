//
//  DetailLayoutView.swift
//  BackendlessTestApp
//
//  Created by brad on 6/2/21.
//

import SwiftUI

struct DetailLayoutView: View {
    
    @EnvironmentObject var nfcScanner : NFCController
    @State var showHome = false
    
    var body: some View {
        if showHome == true {
            HomeView()
        } else {
            ZStack {
               
                Image("multi")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .edgesIgnoringSafeArea(.all)
                
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
                    Text("Powered By")
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .italic()
                    HStack {
                        Image("Logo_trans")
                            .resizable()
                            .frame(width: 100, height: 100)
                            // .padding()
                            .aspectRatio(contentMode: .fit)
                          
                        HStack {
                            Text("Black")
                                .font(Font.custom("BigCityGrotesquePro-Regular", size: 32))
                                .foregroundColor(.black)
                            Text("Glove")
                                .font(Font.custom("BigCityGrotesquePro-Bold", size: 32))
                                .foregroundColor(.black)
                                .offset(x: -8)
                        }
                    } // Logo Hstack
                    .offset(y: -20)
                    Spacer()
                } // Main VStack
                
                .offset(y: 45)
            }
        }
    }
}

struct DetailLayoutView_Previews: PreviewProvider {
    static var previews: some View {
        DetailLayoutView()
    }
}
