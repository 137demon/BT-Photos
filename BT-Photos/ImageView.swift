//
//  ImageView.swift
//  BT-Photos
//
//  Created by 137demon on 10/01/1946 Saka.
//
//"albumId": 1,
//"id": 3,
//"title": "officia porro iure quia iusto qui ipsa ut modi",
//"url": "https://via.placeholder.com/600/24f355",
//"thumbnailUrl": "https://via.placeholder.com/150/24f355"

import UIKit

protocol ImageViewDelegate {
    func showDetailedViewWithDictionary(view : ImageView)
}

class ImageView : UIImageView, UIGestureRecognizerDelegate {
    var delegate : ImageViewDelegate!
    var imageDetails : NSDictionary!
    
    func addGesture() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped(gestureRecognizer:)))
        self.addGestureRecognizer(tapRecognizer)
        tapRecognizer.delegate = self
        self.isUserInteractionEnabled = true
    }
    
    @objc func tapped(gestureRecognizer: UITapGestureRecognizer) {
           // Remove the blue view.
        delegate.showDetailedViewWithDictionary(view: self)
        print("Clicked")
    }
    
    func setDictionary(dict : NSDictionary){
        imageDetails = dict
        self.addGesture()
//        let thumbnailpath = self.getThumbnailPath() as String
//        let img = UIImage(data: self.getDataWith(urlPath: thumbnailpath))
//        let img  = UIImage(named: "Hinata-Hyuga-Cover.jpg")
//        self.image = img
    }
    
    func getTitle() -> String {
        guard let title = imageDetails["title"] as? String else {
            return "Missing"
        }
        return title
    }
    
    func getId() -> Int {
        guard let id = imageDetails["id"] as? Int else {
            return 0
        }
        return id
    }
    
    func getAlbumId() -> Int {
        guard let albumID = imageDetails["albumId"] as? Int else {
            return 0
        }
        return albumID
    }
    
    func getThumbnailPath() -> String{
        guard let thumbnailUrl = imageDetails["thumbnailUrl"] as? String else {
            return ""
        }
        return thumbnailUrl
    }
    
    func getImagePath() -> String{
        guard let url = imageDetails["url"] as? String else {
            return ""
        }
        return url
    }
    
    func setThumbnail() {
        let thumbnailpath = self.getThumbnailPath() as String
        let imgData = self.getDataWith(urlPath: thumbnailpath)
        DispatchQueue.main.async {
            let img = UIImage(data: imgData)
            self.image = img
        }
    }
    
    func getDataWith(urlPath : String) -> Data {
        guard let urlStr = urlPath as? String else{
            return Data()
        }
        do{
            let url = URL(string: urlStr)!
            let data = try Data(contentsOf: url)
            return data
        }
        catch{
            return Data()
        }
    }
    
}
