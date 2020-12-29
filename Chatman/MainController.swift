//
//  MainController.swift
//  Chatman
//
//  Created by ozan honamlioglu on 20.12.2020.
//

import Foundation
import UIKit
import LBTATools

class PostCell: LBTAListCell<String> {
    
    let imageView = UIImageView(backgroundColor: .red)
    let nameLabel = UILabel(text: "Name label")
    let dateLabel = UILabel(text: "Friday at 11:10AM")
    let postText = UILabel(text: "Here is my text")
    let photosGridController = PhotosGridController()
    
    override func setupViews() {
        backgroundColor = .white
        
        stack(
            hstack(
                imageView.withHeight(40).withWidth(40),
                stack(nameLabel, dateLabel),
                spacing: 8
            ).padLeft(12).padRight(12).padTop(12),
            postText,
            photosGridController.view,
            spacing: 8
        )
    }
}

class MainController: LBTAListHeaderController<PostCell, String, StoryHeader>, UICollectionViewDelegateFlowLayout {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .init(white: 0.9, alpha: 1)
        self.items = ["Hello", "World", "!", "", "", ""]
        setupNavBar()
    }
    
    let fbLogoImageView = UIImageView(image: UIImage(named: "fb_logo"), contentMode: .scaleAspectFill)
    let searchButton = UIButton(title: "Search", titleColor: .black)
    
    fileprivate func setupNavBar() {
        let width = view.frame.width - 120 - 16 - 60
        
        navigationController?.navigationBar.tintColor = .white
        let titleView = UIView(backgroundColor: .clear)
        
        titleView.frame = .init(x: 0, y: 0, width: width, height: 50)
        titleView.hstack(
                fbLogoImageView.withWidth(120),
                UIView(backgroundColor: .clear).withWidth(width),
                searchButton.withWidth(60)
            )
        navigationItem.titleView = titleView
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let safeAreaTop = UIApplication.shared.windows.filter{$0.isKeyWindow}.first?.safeAreaInsets.top ?? 0
        
        let magicalSafeAreaTop: CGFloat = safeAreaTop + (navigationController?.navigationBar.frame.height ?? 0)
        let offset = scrollView.contentOffset.y + magicalSafeAreaTop
        let alpha: CGFloat = 1 - (offset / 60)
        
        [fbLogoImageView, searchButton].forEach{$0.alpha = alpha}
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y: -offset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: 0, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 12, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 400)
    }
    
}

import SwiftUI
struct MainPreview: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> some UIViewController {
            return UINavigationController(rootViewController: MainController());
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
}
