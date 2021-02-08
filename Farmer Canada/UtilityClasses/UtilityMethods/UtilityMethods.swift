//
//  UtilityMethods.swift
//  HarpersKabab
//
//  Created by Arun Kumar Rathore on 02/06/20.
//  Copyright © 2020 arunkumar. All rights reserved.
//

import UIKit

class UtilityMethods: NSObject {

//    Add border and shadow to view
    static func addBorderAndShadow(_ view : UIView, _ radius : CGFloat) -> Void {
        view.layer.cornerRadius = radius
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 1.0
    }
    
//    Add only border to view
    static func addBorder(_ view : UIView, _ color : UIColor, _ radius : CGFloat) -> Void {
        view.layer.cornerRadius = radius
        view.layer.borderColor = color.cgColor
        view.layer.borderWidth = 0.5
    }
    
//    Add only shadow to view
    static func addShadow(_ view : UIView) -> Void {
        view.layer.cornerRadius = 5.0
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 2.0
        view.layer.shadowPath = UIBezierPath(rect: view.bounds).cgPath
    }
    
    static func addShadow(_ view : UIView, _ radius : CGFloat) -> Void {
        view.layer.cornerRadius = radius
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 2.0
        view.layer.shadowPath = UIBezierPath(rect: view.bounds).cgPath
    }
    
//    Change image color
    static func changeImageColor(_ imageView : UIImageView, _ color : UIColor) {
        imageView.image = imageView.image?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = color
    }
    
//    Corner Radius of only two side of UIViews
    static func roundCorners(view :UIView, corners: UIRectCorner, radius: CGFloat){
        let path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        view.layer.mask = mask
    }
    
//    Calculate the percentage amount with total amount
    static func calculatePercentageAmount(_ percentage : Double, _ totalAmount : Double) -> Double {
        let val = totalAmount * percentage
        return val / 100.0
    }
    
//    Change Button icon color
    static func changeButtonIconColor(_ imageName : String, _ color : UIColor, _ button : UIButton) -> Void {
        let origImage = UIImage(named: imageName)
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        button.setImage(tintedImage, for: .normal)
        button.tintColor = color
    }
}
