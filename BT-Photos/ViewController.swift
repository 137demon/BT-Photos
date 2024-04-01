//
//  ViewController.swift
//  BT-Photos
//
//  Created by 137demon on 10/01/1946 Saka.
//

import UIKit
import EventKitUI

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, ImageViewDelegate, AlbumDelegate{
    @IBOutlet var idText : UITextField!
    @IBOutlet var errorText : UITextView!
    @IBOutlet var collectionView : UICollectionView!
    @IBOutlet var transparentView : UIView!
    var queue = OperationQueue()
    var albumFetch = Album()
    
    override func viewDidLoad() {
        albumFetch.delegate = self
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func setInitialValues() {
        errorText.isHidden = true
        idText.text = ""
        transparentView.isHidden = true
        albumFetch.searchDic.removeAll()
        collectionView.reloadData()
    }

    @IBAction func searchClicked(){
        errorText.isHidden = true
        if(self.validateID()){
            let a = Int((idText?.text!)!)
            transparentView.isHidden = false
            albumFetch.getAlbumDetails(withID: a ?? 0)
        }
        else{
            errorText.isHidden = false
        }
    }
    
    func validateID() -> Bool {
        guard let text = idText.text else {
            errorText.text = "Enter a ID value from 1 - 100."
            return false
        }
        guard let intValue = Int(text) else {
            errorText.text = "Enter Numberic value from 1 - 100."
            return false
        }
        if intValue < 1 || intValue > 100 {
            errorText.text = "Enter a ID value from 1 - 100."
            return false
        }
        
        return true
    }
    
    func afterFetchedAlbumDetailSuccess() {
        queue.cancelAllOperations()
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.transparentView.isHidden = true
        }
    }
    
    func afterFetchedAlbumDetailError(message : String) {
        DispatchQueue.main.async {
            self.errorText.text = message
            self.errorText.isHidden = false
            self.transparentView.isHidden = true
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard (albumFetch.searchDic as [NSDictionary]?) != nil else {
            return 0
        }
        return albumFetch.searchDic.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let view = ImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        view.setDictionary(dict: albumFetch.searchDic[indexPath.count])
        view.delegate = self
        
        queue.addOperation {
            view.setThumbnail()
        }
        
        let collectionItem = collectionView.dequeueReusableCell(withReuseIdentifier: "Collection", for: indexPath)
        collectionItem.addSubview(view)
        return collectionItem
    }
    
    func showDetailedViewWithDictionary(view : ImageView) {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailedView") as? DetailedView
        
        secondViewController?.id = view.getId()
        secondViewController?.albumID = view.getAlbumId()
        secondViewController?.imgTitle = view.getTitle()
        secondViewController?.urlPath = view.getImagePath()
        
        self.navigationController?.pushViewController(secondViewController!, animated: true)
    }
    
}

