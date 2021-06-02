//
//  ContentView.swift
//  BackendlessTestApp
//
//  Created by brad on 6/1/21.
//

/// Commented Out 6/2/21 - Brad - For Testing

/*

import SwiftUI
import Backendless


@objcMembers class Movies: NSObject {
    var objectId: String?
    var title: String?
    var desc: String?
    var rating: String?
    var release_year: String?
    var created: Date?
}

var moviesStore : DataStoreFactory = Backendless.shared.data.of(Movies.self)



struct ContentView: View {
    
    let API_HOST = "https://api.backendless.com"
    let APP_ID =  "C08AEFD1-0A68-2B5B-FF64-3E9E8B5D3900"
    let API_KEY = "37018558-C87F-4698-8335-75C87FBE433F"
    
    @State var moviesList = [Movies]()
    @State var tappedObject = ""
    
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(moviesList, id: \.self) { movies in
                    //NavigationLink(destination: ObjectDetailView(objectID: tappedObject))
                    NavigationLink(destination: JSONView(objectID: movies.objectId!)) {
                        Text(movies.title ?? "Not Found").onTapGesture {
                            print(movies.objectId ?? "")
                            print(movies.title ?? "")
                        }
                    }
                }
            }
        }
        .onAppear() {
            initBackendless()
            getMovies()
            enableRealTime()
        }
    }
    
    func initBackendless() {
        Backendless.shared.hostUrl = API_HOST
        Backendless.shared.initApp(applicationId: APP_ID, apiKey: API_KEY)
        
        // we need this mapping because the description Swift property cannot be overridden
        moviesStore.mapColumn(columnName: "description", toProperty: "desc")
    }
    func getMovies() {
        let queryBuilder = DataQueryBuilder()
        queryBuilder.setPageSize(pageSize: 100)
        queryBuilder.setSortBy(sortBy: ["created"])
        moviesStore.find(queryBuilder: queryBuilder, responseHandler: {
            foundMovies in
            if let foundMovies = foundMovies as? [Movies] {
                self.moviesList = foundMovies
            }
        }, errorHandler: {fault in
            self.showError(fault: fault)
            
        })
        
    }
    func showError(fault: Fault) {
        let alert = UIAlertController(title: "Error", message: fault.message ?? "An error occurred", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        //            self.present(alert, animated: true, completion: nil)
    }
    func enableRealTime() {
        let rtHandlers = moviesStore.rt
        
        let _ = rtHandlers?.addCreateListener(responseHandler: { movie in
            if let movie = movie as? Movies  {
                self.moviesList.append(movie)
            }
            
        }, errorHandler: {fault in
            self.showError(fault: fault)
            
        })
        
        let _ = rtHandlers?.addUpdateListener(responseHandler: { movie in
            if let movie = movie as? Movies,
               let existingMovie = self.moviesList.first(where: { $0.objectId == movie.objectId }),
               let index = self.moviesList.firstIndex(of: existingMovie) {
                self.moviesList.remove(at: index)
            }
            
        }, errorHandler: {fault in
            self.showError(fault: fault)
            
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
*/
