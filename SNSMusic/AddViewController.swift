//
//  AddViewController.swift
//  SNSMusic
//
//  Created by 安藤奨 on 2019/07/28.
//  Copyright © 2019 安藤奨. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    
    var artists = [String]()
    
    var songs = [String]()
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var textFIeldSong: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didClickButton(_ sender: UIButton) {

        artists.append(textField.text!)
        textField.text = ""
        songs.append(textFIeldSong.text!)
        textFIeldSong.text = ""
        
        UserDefaults.standard.set(artists,forKey: "artistsList")
        UserDefaults.standard.set(songs, forKey: "songsList")
        
        let storyboard:UIStoryboard = self.storyboard!
        
        let nextView = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        
        self.present(nextView,animated: true,completion: nil)
    
    

    

        // Do any additional setup after loading the view.
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
