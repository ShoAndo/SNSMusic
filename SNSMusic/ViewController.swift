//
//  ViewController.swift
//  SNSMusic
//
//  Created by 安藤奨 on 2019/07/28.
//  Copyright © 2019 安藤奨. All rights reserved.
//

import UIKit
import Koloda

class ViewController: UIViewController,KolodaViewDelegate, KolodaViewDataSource {
    
    
    var images: [UIImage] = []
    
    var KolodaData: [[String: Any]] = []

    @IBOutlet weak var label: UILabel!
    
    
    @IBOutlet weak var kolodaView: KolodaView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        kolodaView.delegate = self
        kolodaView.dataSource = self
        
       
    }
    
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        var artists = [String]()
        var songs = [String]()
        
        if UserDefaults.standard.object(forKey: "artistsList") != nil{
            artists = UserDefaults.standard.object(forKey:"artistsList") as! [String]
        }
        if UserDefaults.standard.object(forKey: "songsList") != nil{
            songs = UserDefaults.standard.object(forKey: "songsList") as! [String]
        }
        
       
        let url: URL = URL(string: "http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/wa/wsSearch?term=\(artists[index])&limit=1")!
        let task: URLSessionTask = URLSession.shared.dataTask(with: url, completionHandler: {data, response, error in
            do {
                let items = try JSONSerialization.jsonObject(with: data!) as! NSDictionary
                
                var result: [[String: Any]] = []
                
                for(key, data) in items {
                    if (key as! String == "results"){
                        let resultArray = data as! NSArray
                        for (eachMusic) in resultArray{
                            let dicMusic:NSDictionary = eachMusic as! NSDictionary
                            
                            print(dicMusic["trackName"]!)
                            print(dicMusic["artworkUrl100"]!)
                            
                            let data: [String: Any] = ["name": dicMusic["trackName"]!, "imageUrl": dicMusic["artworkUrl100"]!]
                            
                            
                            
                            result.append(data)
                            let url = URL(string: data["imageUrl"] as! String)
                            
                            let imageData :Data = (try! Data(contentsOf: url!,options: NSData.ReadingOptions.mappedIfSafe))
                            let img = UIImage(data:imageData)
                            self.images.append(img!)
                        }
                    }
                }
                
                DispatchQueue.main.async() { () -> Void in
                    //                    collectiondataはcollectionDatawのこと
                    self.KolodaData = result
                }
                
            } catch {
                print(error)
            }
        })
        task.resume()
        
        label.text = songs[index]
        
        //        imageViewに生成した画像を設定
        let imageView = UIImageView(image: images[index])
        //        ImageViewを返す
        return imageView
        
       
        
        
    }
    
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return images.count
    }
    
    
}

