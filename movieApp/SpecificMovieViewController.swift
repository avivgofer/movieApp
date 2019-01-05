//
//  SpecificMovieViewController.swift
//  movieApp
//
//  Created by    aviv gofer on 04/01/2019.
//  Copyright © 2019 aviv gofer. All rights reserved.
//

import UIKit
import WebKit


class SpecificMovieViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var progressItem: UIActivityIndicatorView!
    @IBOutlet weak var movieDescText: UITextView!
    @IBOutlet weak var movieHourLabel: UILabel!
    @IBOutlet weak var movieRateLabel: UILabel!
    @IBOutlet weak var movieCategoryLabel: UILabel!
    @IBOutlet weak var movieYearLabel: UILabel!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var myWebView: WKWebView!
    @IBOutlet weak var movieImageView: UIImageView!
    
    var movie : FullMovie?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setPreference()
    }
    
    @IBAction func backClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func setPreference(){
        myWebView.navigationDelegate = self
        progressItem.isHidden = false
        progressItem.startAnimating()
        movieNameLabel.text = movie!.name
        movieYearLabel.text = movie!.year
        movieDescText.text = movie!.description
        movieCategoryLabel.text = movie!.category
        movieRateLabel.text = movie!.rate
        movieHourLabel.text = movie!.hour
        
        if movie?.promoUrl != "" {
            playVideo(videoId:String(movie!.promoUrl.split(separator: "=")[1]))
        }
        
        if movie?.imageUrl != "" {
            let stringUrl = "https:" + String(movie!.imageUrl.split(separator: ":")[1])
            let url:NSURL = NSURL(string:stringUrl)!
            do{
                let data:NSData = try NSData(contentsOf: url as URL)
                movieImageView.image = UIImage(data: data as Data)
            }catch let error as NSError {
                print(error)
            }
        }
        
    }
    
    func playVideo(videoId:String) {
        let url = URL(string: "https://www.youtube.com/embed/\(videoId)")
        myWebView.load(URLRequest(url: url!))
    }
    
    func webView(_ webView: WKWebView,
                 didFinish navigation: WKNavigation!) {
        progressItem.stopAnimating()
        progressItem.isHidden = true
    }
    
}
