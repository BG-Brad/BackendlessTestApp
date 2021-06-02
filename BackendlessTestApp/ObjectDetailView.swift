//
//  ObjectDetailView.swift
//  BackendlessTestApp
//
//  Created by brad on 6/1/21.
//

import SwiftUI
import Backendless


@objcMembers class MovieDetails: NSObject {
    var objectId: String?
    var title: String?
    var desc: String?
    var rating: String?
    var release_year: String?
    var created: Date?
}


struct ObjectDetailView: View {
    @State var objectID = ""
    @State var movieDetails = [MovieDetails]()
    
    
    var body: some View {
        VStack {
            Text("something here")
                .onAppear() {
                    FetchData()
                }
        }
    }
        func FetchData() {
        let query = DataQueryBuilder()
        query.setWhereClause(whereClause: "objectId = '\(objectID)'")

        let dataStore = Backendless.shared.data.ofTable("Movies")
        dataStore.find(queryBuilder: query, responseHandler: {
            foundObject in
            print("found Object: \(foundObject)")
            if let movieDetails = foundObject as? [MovieDetails] {
                DispatchQueue.main.async {

                    self.movieDetails = movieDetails
                print("Details: \(movieDetails)")
                }
            }
        }, errorHandler: {fault in
            print("")

        })
    }
}

func showError(fault: Fault) {
    let alert = UIAlertController(title: "Error", message: fault.message ?? "An error occurred", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
    //            self.present(alert, animated: true, completion: nil)
}

struct ObjectDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ObjectDetailView(objectID: "71F85F4F-35AE-46BF-B3F8-D3B26E720891")
    }
}
