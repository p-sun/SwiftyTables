import UIKit

protocol CarouselItemCell {
    associatedtype Model
    func configure(model: Model)
}

extension CarouselItemCell {
    static func reuseId() -> String {
        return String(describing: self)
    }
}

class CarouselCell<ItemCell: UICollectionViewCell>: UIView, UICollectionViewDelegate, UICollectionViewDataSource where ItemCell: CarouselItemCell{
    private var collectionViewHeightConstraint: NSLayoutConstraint!
    fileprivate var collectionView: UICollectionView!
    fileprivate var storedOffsets = [Int: CGFloat]()
    fileprivate var models: [ItemCell.Model] = []
    fileprivate var didSelectCell: ((IndexPath) -> Void)?
    
    var collectionHeight: CGFloat = 130 {
        didSet {
            collectionViewHeightConstraint.constant = collectionHeight
        }
    }
    
    init() {
        super.init(frame: CGRect.zero)

        collectionView = createCollectionView()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.addSubview(collectionView)
        collectionView.pinToSuperView()
        
        collectionViewHeightConstraint =         collectionView.heightAnchor.activateConstraint(equalToConstant: collectionHeight, priority: 999)
        
        collectionView.register(ItemCell.self, forCellWithReuseIdentifier: ItemCell.reuseId())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = CGSize(width: 80, height: 80) // An arbitary number smaller than collectionView height
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCell.reuseId(), for: indexPath) as? ItemCell {
            let model = models[indexPath.row]
            cell.configure(model: model)
            return cell
        }
        return ItemCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.didSelectCell?(indexPath)
    }
}

extension CarouselCell {
    func reload(models: [ItemCell.Model], didSelectCell: ((IndexPath) -> Void)? = nil) {
        collectionView.setContentOffset(collectionView.contentOffset, animated:false) // Stops collection view if it was scrolling.

        self.models = models
        self.didSelectCell = didSelectCell
        collectionView.reloadData()
    }
    
//    func setCollectionViewDataSourceDelegate<D: UICollectionViewDataSource & UICollectionViewDelegate>(_ dataSourceDelegate: D, forRow row: Int) {
//
//        collectionView.delegate = dataSourceDelegate
//        collectionView.dataSource = dataSourceDelegate
//        collectionView.tag = row
//        collectionView.setContentOffset(collectionView.contentOffset, animated:false) // Stops collection view if it was scrolling.
//
//        collectionView.reloadData()
//    }
    
    func saveOffset(for row: Int) {
        storedOffsets[row] = collectionViewOffset
    }
    
    func restoreOffset(for row: Int) {
        collectionViewOffset = storedOffsets[row] ?? 0
    }
    
    var collectionViewOffset: CGFloat {
        set { collectionView.contentOffset.x = newValue }
        get { return collectionView.contentOffset.x }
    }
}

