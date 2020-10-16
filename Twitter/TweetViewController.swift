//
//  TweetViewController.swift
//  Twitter
//
//  Created by Sanzida Sultana on 10/16/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {

    @IBOutlet weak var tweetTextFeild: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // can take text in display keyboard
        tweetTextFeild.becomeFirstResponder()

        // Do any additional setup after loading the view.
    }
    
    // When composing a tweet user canceled the tweet
    @IBAction func userCancelTweet(_ sender: Any) {
        
        // Cancel this View Controller
        dismiss(animated: true, completion: nil)
    }
    
    
    // Composing the tweet and User wants to post it
    @IBAction func userTweeted(_ sender: Any) {
        
        // From the Twitter Developer API
        
        // check the tweet Text feild is empty
        if(tweetTextFeild.text.isEmpty) {
            print("ERRORR : Empty Text Field!!")
        }
        
        // then if the text field box is not empty call Twitter API to post the Tweet
        
        else {
            TwitterAPICaller.client?.postTweet(tweetString: tweetTextFeild.text, success: {
                self.dismiss(animated: true, completion: nil)
            }, failure: { (error) in
                print("Error posting Tweet: \(error)" )
                self.dismiss(animated: true, completion: nil)
            })
        }
        
        
        
        
    }
    
}
