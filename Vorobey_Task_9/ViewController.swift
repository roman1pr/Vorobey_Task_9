//
//  ViewController.swift
//  Vorobey_Task_9
//
//  Created by Roman Priiskalov on 27.09.2023.
//

import UIKit

// Коллекция с ячейками. Ячейки в один ряд. Горизонтальный cкрол.

//- Коллекция на весь экран.
//- Крайняя левая ячейка, которая поместилась целиком на экран, всегда имеет отступ слева на layout margins коллекции.
//- Когда отпускаем скрол, ячейки останавливаются по правишу выше.
//- Если сделать сильный скрол, коллекция пролетает пару ячеек и останавливается по правилу выше.
//- Нельзя использовать UICollectionViewCompositionalLayout.

class ViewController: UIViewController {
    
    private var myLabel: UILabel = {
        let label = UILabel()
        label.text = "Collection"
        label.font = .boldSystemFont(ofSize: 32)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var galleryCollectionView = AutoCollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(myLabel)
        view.addSubview(galleryCollectionView)
        
        let guide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            myLabel.topAnchor.constraint(equalToSystemSpacingBelow: guide.topAnchor, multiplier: 1.0),
            myLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            galleryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            galleryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            galleryCollectionView.bottomAnchor.constraint(equalToSystemSpacingBelow: guide.bottomAnchor, multiplier: 1.0),
            galleryCollectionView.topAnchor.constraint(equalTo: myLabel.bottomAnchor, constant: 24),
        ])
    }
    
}

class AutoCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let cellWidth: CGFloat = 320
    let margin: CGFloat = 10
    let spacing: CGFloat = 10
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = spacing
        
        super.init(frame: .zero, collectionViewLayout: layout)

        delegate = self
        dataSource = self
        register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.reuseID)
        
        contentInset = UIEdgeInsets(top: 0, left: margin, bottom: 0, right: margin)
        
        translatesAutoresizingMaskIntoConstraints = false
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseID, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: 450)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // The scrolling has finished
//        let visibleRect = CGRect(origin: self.contentOffset, size: self.bounds.size)
//        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
//        var visibleIndexPath = self.indexPathForItem(at: visiblePoint)
//
//        if visibleIndexPath == nil {
//            visibleIndexPath = indexPathsForVisibleItems.first
//        }
//
//        if let visibleIndexPath {
//            scrollToItem(at: visibleIndexPath, at: .left, animated: true)
//        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>){
        
        let targetOffsetX = targetContentOffset.pointee.x
        let targetPoint = CGPoint(x: targetOffsetX,
                                  y: self.bounds.midY)

        let targetIndexPath = self.indexPathForItem(at: targetPoint)
        let targetItemIndex: CGFloat = CGFloat(targetIndexPath?.row ?? 0)
        let newTargetOffsetX: CGFloat = (targetItemIndex * (cellWidth - 1) + targetItemIndex * spacing - margin)

        targetContentOffset.pointee = CGPoint(x: newTargetOffsetX, y: 0)
    }
}

class CollectionViewCell: UICollectionViewCell {
    static let reuseID = "CollectionViewCell"
    
    let myView: UIView = {
        let myView = UIView()
        myView.translatesAutoresizingMaskIntoConstraints = false
        myView.backgroundColor = .systemGray3
        myView.layer.cornerRadius = 4
        return myView
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        addSubview(myView)

        NSLayoutConstraint.activate([
            myView.leadingAnchor.constraint(equalTo: leadingAnchor),
            myView.trailingAnchor.constraint(equalTo: trailingAnchor),
            myView.topAnchor.constraint(equalTo: topAnchor),
            myView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
