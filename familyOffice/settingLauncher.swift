//
//  settingLauncher.swift
//  familyOffice
//
//  Created by Leonardo Durazo on 17/03/17.
//  Copyright © 2017 Leonardo Durazo. All rights reserved.
//

import UIKit

class SettingLauncher: NSObject, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let blackView = UIView()
    var view: HomeViewController!
    
    let collectionView = { () -> UICollectionView in
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        return cv
    }()
    
    func showSetting() {
        if let window = UIApplication.shared.keyWindow {
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            window.addSubview(blackView)
            window.addSubview(collectionView)
            
            let height : CGFloat = 200.0
            let y = window.frame.height - height
            collectionView.frame = CGRect(x: 0, y: y, width: window.frame.width, height: height)
            
            blackView.frame = window.frame
            blackView.alpha = 0
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .layoutSubviews, animations: {
                self.blackView.alpha = 1
                
                self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }, completion: nil)
        }
    }
    func handleDismiss() {
        UIView.animate(withDuration: 0.5, animations: {
            self.blackView.alpha = 0
            
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect(x: 0, y:window.frame.height-0, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
                
            }
        })
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return FAMILY_SERVICE.families.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! familySettingCell
        let family = FAMILY_SERVICE.families[indexPath.row]
        cell.image.layer.cornerRadius = cell.image.frame.size.width/2
        cell.image.clipsToBounds = true
        if !(family.photoURL?.isEmpty)! {
            cell.image.loadImage(urlString: family.photoURL!)
        }
        cell.nameLabel.text = family.name
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 80)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        FAMILY_SERVICE.selectFamily(family: FAMILY_SERVICE.families[indexPath.row])
        handleDismiss()
        if view != nil {
            self.view.reloadFamily()
            self.view.tabBarController?.navigationItem.title = FAMILY_SERVICE.families[indexPath.row].name
        }
       
    }
    
    func setView(view: UIViewController) -> Void {
        
        if let view = view as? HomeViewController {
            self.view = view
        }
    }
    override init(){
        super.init()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(familySettingCell.self, forCellWithReuseIdentifier: "cellId")
        
    }
    
}

class BaseCell: UICollectionViewCell {
   
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews()  {
    }
    
}

class familySettingCell: BaseCell {
    var nameLabel : UILabel = {
        let label = UILabel()
        label.text = "name"
        return label
    }()
    
    var image: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "familyImage")
       
        return image
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override func setupViews() {
        super.setupViews()
        addSubview(nameLabel)
        addSubview(image)
        addContraintWithFormat(format: "H:|-8-[v0(60)]-8-[v1]|", views: image, nameLabel)
        addContraintWithFormat(format: "V:|[v0]|", views: nameLabel)
        addContraintWithFormat(format: "V:[v0(60)]", views: image)
        addConstraint(NSLayoutConstraint(item: image, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
}
