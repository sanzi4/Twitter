//
//  TweetTableViewCell.swift
//  Pods
//
//  Created by Sanzida Sultana on 10/5/20.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var userTweet: UILabel!
    
    @IBOutlet weak var userRetweeted: UIButton!
    @IBOutlet weak var userLiked: UIButton!
    
    var favorited:Bool = false
    var tweetId: Int = -1
  
    
    // if a user liked/unliked a tweet change the button
    func setFavorite(_isLiked:Bool){
        favorited = _isLiked
        if(favorited){
            userLiked.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
        }
        else{
            userLiked.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
            
        }
        
    }
    
    // if a user retweeted/ unretweeted a tweet
    func setRetweet(_isRetweet:Bool){
        if(_isRetweet){
            userRetweeted.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            userRetweeted.isEnabled = false
        }
        else{
            userRetweeted.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            userRetweeted.isEnabled = true

        }
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func userLikedTweet(_ sender: Any) {
        let toBeFavorited = !favorited
        
        if toBeFavorited {
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                print("User succesfully liked a tweet")
                self.setFavorite(_isLiked: true)
            }, failure: { (Error) in
                print("Couldn't favorite a tweet \(Error)")
            })
        } // if a user unfavorited a tweet we want to change the heart icon
        else {
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId, success: {
                print("User succesfully unliked a tweet")
                self.setFavorite(_isLiked: false)
            }, failure: { (Error) in
                print("Couldn't favorite a tweet \(Error)")
            })
        }
        
    }
    
    @IBAction func userRetweeted(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
            print("User succesfully liked a tweet")
            self.setRetweet(_isRetweet: true)
        }, failure: { (Error) in
            print("Couldn't retweet a tweet \(Error)")
        })
        
    }
           
    
}
