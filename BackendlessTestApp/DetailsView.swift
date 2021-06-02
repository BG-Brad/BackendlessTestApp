//
//  DetailsView.swift
//  BackendlessTestApp
//
//  Created by brad on 6/1/21.
//

import SwiftUI
import Backendless


struct MovieDetails : Codable, Identifiable {
    var id = UUID()
    var created: Int?
    var rating, movieClass, movieDescription: String?
    var releaseYear : Int?
    var ownerID: String?
    var title: String?
    var updated: String?
    var objectID: String?
}

class FetchData : ObservableObject {
    @Published var movieDetails = [MovieDetails]()

    init() {
        let url = URL(string: "https://api.backendless.com/C08AEFD1-0A68-2B5B-FF64-3E9E8B5D3900/A8742242-F7D8-4462-B416-370DCE64BF43/data/Movies/71F85F4F-35AE-46BF-B3F8-D3B26E720891")!
        URLSession.shared.dataTask(with: url) {(data, response, error) in
            do {
                if let jsonData = data {
                    let decodedData = try JSONDecoder().decode([MovieDetails].self, from: jsonData)
                    DispatchQueue.main.async {
                        self.movieDetails = decodedData
                        print(decodedData)
                    }
                } else {
                    print("no data")
                }
            } catch {
                print(error.localizedDescription)
            }
            
        }.resume()
        
    }

    
}



struct DetailsView: View {
    
    @State var objectID : String
    @ObservedObject var loadData = FetchData()

    
    var body: some View {
        VStack {
            List(loadData.movieDetails) { details in
                VStack {
                    Text(details.title ?? "")
                    Text(details.movieDescription ?? "")
                }
                
            }
        }
    }

}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(objectID: "71F85F4F-35AE-46BF-B3F8-D3B26E720891")
    }
}


/*
 let dataStore = Backendless.shared.data.ofTable("Contact")
 dataStore.findById(objectId: "862D8AB3-02F1-4932-FF70-527C3638B200", responseHandler: { foundObject in
     print("Found object: \(foundObject as! [String: Any])")
 }, errorHandler: { fault in
     print("Error: \(fault.message ?? "")")
 })
 
 
 
 dataStore.findById(objectId: "\(objectID)", responseHandler: {
     foundObject in
     print(foundObject)
     print("Keys: \(foundObject.values)")

     if let foundObject = foundObject as? [MovieDetails] {
         self.movieDetails = foundObject
     }
     print("details \(movieDetails)")
     
     
 }, errorHandler: { fault in
     print("Error: \(fault.message ?? "")")
 })
 */
