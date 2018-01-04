import UIKit

protocol CarouselItemCell {
    associatedtype Model
    func configure(model: Model)
    static func hasNib() -> Bool
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
    
    // If nothing is showing up, make sure collectionHeight is greater than item height
    // If you're using nibs, set width and height on the nib
    fileprivate var collectionHeight: CGFloat = 170 {
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
        
        if ItemCell.hasNib() {
           collectionView.register(UINib(nibName: String(describing: ItemCell.self), bundle: nil), forCellWithReuseIdentifier: ItemCell.reuseId())
        } else {
            collectionView.register(ItemCell.self, forCellWithReuseIdentifier: ItemCell.reuseId())
        }
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
            cell.tag = indexPath.row
            return cell
        }
        return ItemCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.didSelectCell?(indexPath)
    }
}

extension CarouselCell {
    static func register(to tableView: UITableView) {
        let className = String(describing: self)
        tableView.register(CarouselCell<ItemCell>.self, forCellReuseIdentifier: className)
    }
    
    static func dequeue(from tableView: UITableView, at indexPath: IndexPath) -> CarouselCell<ItemCell>? {
        let className = String(describing: self)
        if let cell = tableView.dequeueReusableCell(withIdentifier: className, for: indexPath) as? CarouselCell<ItemCell> {
            return cell
        }
        return nil
    }
}

extension CarouselCell {
    func reload(models: [ItemCell.Model], didSelectCell: ((IndexPath) -> Void)? = nil, collectionHeight: CGFloat? = nil) {
        collectionView.setContentOffset(collectionView.contentOffset, animated:false) // Stops collection view if it was scrolling.

        self.models = models
        self.didSelectCell = didSelectCell
        if let collectionHeight = collectionHeight {
            self.collectionHeight = collectionHeight
        }
        collectionView.reloadData()
    }

    func saveOffset(for row: Int) {
        storedOffsets[row] = collectionView.contentOffset.x
    }
    
    func restoreOffset(for row: Int) {
        collectionView.contentOffset.x = storedOffsets[row] ?? 0
    }
}
