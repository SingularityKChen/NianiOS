//
//  CommentEmoji.swift
//  Nian iOS
//
//  Created by Sa on 16/3/4.
//  Copyright © 2016年 Sa. All rights reserved.
//

import Foundation
import UIKit

class CommentEmoji: UITableViewCell {
    @IBOutlet var imageHead: UIImageView!
    @IBOutlet var labelName: UILabel!
    @IBOutlet var labelHolder: FLAnimatedImageView!
    var data: NSDictionary!
    
    func setup() {
        selectionStyle = .None
        labelName.textColor = UIColor.HighlightColor()
        imageHead.layer.masksToBounds = true
        imageHead.layer.cornerRadius = 16
        let uid = data.stringAttributeForKey("uid")
        let name = data.stringAttributeForKey("user")
        let time = data.stringAttributeForKey("lastdate")
        let content = data.stringAttributeForKey("content")
        let wImage = data.objectForKey("widthImage") as! CGFloat
        let hImage = data.objectForKey("heightImage") as! CGFloat
        let heightCell = data.objectForKey("heightCell") as! CGFloat
        
        imageHead.setHead(uid)
        labelHolder.frame.size = CGSizeMake(wImage, hImage)
        imageHead.setY(heightCell - 32 - 4)
        labelName.setY(heightCell - 22)
        
        imageHead.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "onHead"))
        
        
        if uid == SAUid() {
            imageHead.setX(globalWidth - 32 - 16)
            labelName.setX(globalWidth - 64 - 231)
            labelName.text = time
            labelName.textColor = UIColor.secAuxiliaryColor()
            labelName.textAlignment = NSTextAlignment.Right
            labelHolder.setX(globalWidth - labelHolder.width() - 60)
        } else {
            let attrStr = NSMutableAttributedString(string: "\(name)  \(time)")
            attrStr.addAttribute(NSForegroundColorAttributeName, value: UIColor.HighlightColor(), range: NSMakeRange(0, (name as NSString).length))
            attrStr.addAttribute(NSForegroundColorAttributeName, value: UIColor.secAuxiliaryColor(), range: NSMakeRange((name as NSString).length + 2, (time as NSString).length))
            labelName.attributedText = attrStr
            labelName.textAlignment = NSTextAlignment.Left
            labelHolder.setX(60)
            labelName.setX(64)
            imageHead.setX(16)
        }
        
        let arr = content.componentsSeparatedByString("-")
        if arr.count == 2 {
            let code = arr[0]
            let num = arr[1]
            let url = "http://img.nian.so/emoji/\(code)/\(num).gif"
            labelHolder.qs_setGifImageWithURL(NSURL(string: url)!, progress: { (now, total) -> Void in
                }, completed: { (Image, data, err, bool) -> Void in
            })
        }
    }
    
    override func prepareForReuse() {
        labelHolder.animatedImage = nil
    }
    
    func onHead(){
        let vc = PlayerViewController()
        vc.Id = data.stringAttributeForKey("uid")
        self.findRootViewController()?.navigationController?.pushViewController(vc, animated: true)
    }
    
}
