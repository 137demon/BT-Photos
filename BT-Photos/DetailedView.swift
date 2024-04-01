//
//  DetailedView.swift
//  BT-Photos
//
//  Created by 137demon on 11/01/1946 Saka.
//

import UIKit

class DetailedView: UIViewController {
    @IBOutlet weak var titleText : UILabel!
    @IBOutlet weak var albumIDText : UILabel!
    @IBOutlet weak var idText : UILabel!
    @IBOutlet weak var imageView : UIImageView!
    var queue = OperationQueue()
    
    var id = 0
    var imgTitle = ""
    var albumID = 0
    var urlPath = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTheRespectiveDetail()

        // Do any additional setup after loading the view.
    }
    
    func setTheRespectiveDetail() {
        queue.cancelAllOperations()
        
        idText.text = "ID : \(id)"
        titleText.text = "Title : \(imgTitle)"
        albumIDText.text = "AlbumID : \(albumID)"
        let photoDetails = ImageView()
        queue.addOperation {
            
            let imgData = photoDetails.getDataWith(urlPath: self.urlPath)
            DispatchQueue.main.async {
                let img = UIImage(data: imgData)
                self.imageView.image = img
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
