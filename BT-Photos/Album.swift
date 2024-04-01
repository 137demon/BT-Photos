//
//  Album.swift
//  BT-Photos
//
//  Created by 137demon on 11/01/1946 Saka.
//

import UIKit

protocol AlbumDelegate {
    func afterFetchedAlbumDetailSuccess()
    func afterFetchedAlbumDetailError(message : String)
}

class Album: NSObject {
    var delegate : AlbumDelegate!
    var searchDic = [NSDictionary]()
    
    func getAlbumDetails(withID : Int) {
        let url1 = URL(string: "https://jsonplaceholder.typicode.com/albums/\(withID)/photos")!
        URLSession.shared.dataTask(with: url1) { data, response, error in
            guard let data = data else {
                self.delegate.afterFetchedAlbumDetailError(message: "kindly check your internet connection and try again.")
                return }
                            do {
                                let string = String(data: data, encoding: .utf8)
                                let jsonData = string!.data(using: .utf8)!
                                self.searchDic = try (JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [NSDictionary])!
                                self.delegate.afterFetchedAlbumDetailSuccess()
            //                    if let array = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any]{
            //                        completion(array, nil)
            //                    }
                            } catch {
                                self.delegate.afterFetchedAlbumDetailError(message: "Unable to parse data, please try again with different ID.")
                            }
        }.resume()
    }

}

struct ErrorFetching{
    
}
