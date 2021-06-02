//
//  JSONView.swift
//  BackendlessTestApp
//
//  Created by brad on 6/1/21.
//

import SwiftUI


struct JSONView: View {
    @State var objectID = ""

    @State private var movieDetails = MovieObject(objectId: "", title: "", description: "", rating: "", release_year: "")
    
    var body: some View {

            VStack {
            Text(movieDetails.title ?? "Title")
            Text(movieDetails.description ?? "Description")
            }.onAppear() {
                print("ID: \(objectID)")
                itemLookup(objectID: "\(objectID)")
            }
        
    }
    func itemLookup(objectID: String) {
        guard let url = URL(string: "https://api.backendless.com/C08AEFD1-0A68-2B5B-FF64-3E9E8B5D3900/A8742242-F7D8-4462-B416-370DCE64BF43/data/Movies/\(objectID)") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request) { ( data, _, _) in
            guard let data = data else { return }
            
            let movieDetails = try! JSONDecoder().decode(MovieObject.self, from: data)
            print(movieDetails)
            DispatchQueue.main.async {
                self.movieDetails = movieDetails
            }
            
        }.resume()
        
    }
    
    
}

struct JSONView_Previews: PreviewProvider {
    static var previews: some View {
        JSONView()
    }
}
