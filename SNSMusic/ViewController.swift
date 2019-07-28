//
//  ViewController.swift
//  SNSMusic
//
//  Created by 安藤奨 on 2019/07/28.
//  Copyright © 2019 安藤奨. All rights reserved.
//

import UIKit
import Koloda

class ViewController: UIViewController {
    
    var images: [String] = []
    
    var KolodaData: [[String: Any]] = [] {
        didSet {
            kolodaView.reloadData()
        }
    }

    @IBOutlet weak var uploadView: UIView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        kolodaView.delegate = self
        kolodaView.dataSource = self
        
        if UserDefaults.standard.object(forKey: "artistsList") != nil{
            var artists = UserDefaults.standard.object(forKey:"artistsList") as! [String]
        }
        if UserDefaults.standard.object(forKey: "songsList") != nil{
            var songs = UserDefaults.standard.object(forKey: "songsList") as! [String]
        }
        
        let url: URL = URL(string: "http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/wa/wsSearch?term=\(artists[IndexPath.row])&limit=1")!
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
        
        
        
        
        // Do any additional setup after loading the view.
    }


}

extension ViewController: KolodaViewDelegate, KolodaViewDataSource{
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        
    }
    
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return images.count
    }
    
    
}

