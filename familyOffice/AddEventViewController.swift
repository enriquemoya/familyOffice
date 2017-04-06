//
//  AddEventViewController.swift
//  familyOffice
//
//  Created by Leonardo Durazo on 04/04/17.
//  Copyright © 2017 Leonardo Durazo. All rights reserved.
//

import UIKit

class AddEventViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        //setupMenuBar()
        setupCollectionView()
        
        let logOutButton = UIBarButtonItem(title: "Guardar", style: .plain, target: self, action:nil)
        logOutButton.tintColor = #colorLiteral(red: 1, green: 0.1757333279, blue: 0.2568904757, alpha: 1)
        navigationItem.rightBarButtonItems = [logOutButton]

        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    private func setupCollectionView() {
        if let flowlayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowlayout.scrollDirection = .horizontal
            flowlayout.minimumLineSpacing = 0
        }
        collectionView?.backgroundColor = UIColor.white
        self.collectionView!.register(AddEventTableViewController.self, forCellWithReuseIdentifier: "cellId")
        self.collectionView!.contentInset = UIEdgeInsets(top: 150, left: 0, bottom: 0, right: 0)
        self.collectionView!.scrollIndicatorInsets = UIEdgeInsets(top: 150, left: 0, bottom: 0, right: 0)
        
        collectionView?.isPagingEnabled = true
    }
    
   /*  let menuBar: MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    private func setupMenuBar() {
        
        self.view.addSubview(menuBar)
        self.view.addContraintWithFormat(format: "H:|[v0]|", views: menuBar)
        self.view.addContraintWithFormat(format: "V:|[v0(50)]|", views: menuBar)
        menuBar.chatController = self
        menuBar.topAnchor.constraint(equalTo: topLayoutGuide.topAnchor).isActive = true
    }*/
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! AddEventTableViewController
            
            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
       // menuBar.horizontalBarLeftAnchorContraint?.constant = scrollView.contentOffset.x / 3
    }
    
    func scrollMenuIndex(menuIndex: Int) -> Void {
        let indexPath = IndexPath(item: menuIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        _ = targetContentOffset.pointee.x / view.frame.width
        //let indexPath = IndexPath(item: Int(index), section: 0)
        //menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isTranslucent = true
        
    }
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    
}
