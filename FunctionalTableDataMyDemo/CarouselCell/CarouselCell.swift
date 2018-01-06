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

protocol CarouselItemNibView {}

extension CarouselItemNibView {
	static func nibWithClassName() -> UINib {
		return UINib(nibName: String(describing: self), bundle: nil)
	}
}

class CarouselCell<ItemCell: UICollectionViewCell>: UIView, UICollectionViewDelegate, UICollectionViewDataSource where ItemCell: CarouselItemCell{
    private var collectionViewHeightConstraint: NSLayoutConstraint!
    fileprivate var collectionView: UICollectionView!
    fileprivate var models: [ItemCell.Model] = []
    fileprivate var didSelectCell: ((IndexPath) -> Void)?
    
    // If nothing is showing up, make sure collectionHeight is greater than item height
    // If you're using nibs, set width and height on the nib
    fileprivate var collectionHeight: CGFloat = 170 {
        didSet {
            collectionViewHeightConstraint.constant = collectionHeight
        }
    }
	
	var carouselOffset: CGFloat {
		get {
			return collectionView.contentOffset.x
		}
		set {
			collectionView.contentOffset.x = newValue
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
		
		if let itemCell = ItemCell.self as? CarouselItemNibView.Type {
			collectionView.register(itemCell.nibWithClassName(), forCellWithReuseIdentifier: ItemCell.reuseId())
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
    func reload(models: [ItemCell.Model], didSelectCell: ((IndexPath) -> Void)? = nil, collectionHeight: CGFloat? = nil) {
        // Stops collection view if it was scrolling.
        collectionView.setContentOffset(collectionView.contentOffset, animated: false)
		
        self.models = models
        self.didSelectCell = didSelectCell
        if let collectionHeight = collectionHeight {
            self.collectionHeight = collectionHeight
        }
        collectionView.reloadData()
    }
}
