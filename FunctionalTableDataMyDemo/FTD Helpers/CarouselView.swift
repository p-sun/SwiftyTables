import UIKit

protocol CarouselStateType: StateType, Equatable {
	associatedtype ItemModel: Equatable
	var itemModels: [ItemModel] { get set }
}

extension CarouselStateType {
	static func ==(lhs: Self, rhs: Self) -> Bool {
		return lhs.itemModels == rhs.itemModels
	}
}

class CarouselView<ItemCell: UICollectionViewCell>: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout where ItemCell: CarouselItemCell {
    private var collectionViewHeightConstraint: NSLayoutConstraint!
	fileprivate var flowLayout: UICollectionViewFlowLayout!

    fileprivate var collectionView: UICollectionView!
    fileprivate var models: [ItemCell.ItemModel] = []
    fileprivate var didSelectCell: ((IndexPath) -> Void)?
	
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
        
        collectionViewHeightConstraint =         collectionView.heightAnchor.activateConstraint(equalToConstant: 10, priority: 999)
		
		if let itemCell = ItemCell.self as? CarouselItemNibView.Type {
			collectionView.register(itemCell.nibWithClassName(), forCellWithReuseIdentifier: ItemCell.reuseId())
		} else {
			collectionView.register(ItemCell.self, forCellWithReuseIdentifier: ItemCell.reuseId())
		}
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
	
	// MARK: - Public
	func reload(models: [ItemCell.ItemModel], didSelectCell: ((IndexPath) -> Void)? = nil, collectionHeight: CGFloat, spacing: CGFloat) {
		
		self.models = models
		self.didSelectCell = didSelectCell
		collectionViewHeightConstraint.constant = collectionHeight
		flowLayout.minimumLineSpacing = spacing
		collectionView.reloadData()
	}
	
	// MARK: - UICollectionView Delegates
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCell.reuseId(), for: indexPath) as? ItemCell {
            let model = models[indexPath.row]
            cell.configure(model: model)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.didSelectCell?(indexPath)
    }
	
	// Return item size instead of dynamic resizing for smoother scrolling.
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		
		return ItemCell.sizeForItem(model: models[indexPath.row])
	}
	
	// MARK: - Private
	private func createCollectionView() -> UICollectionView {
		flowLayout = UICollectionViewFlowLayout()
		flowLayout.scrollDirection = .horizontal
		flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
		
		let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
		collectionView.backgroundColor = .white
		collectionView.showsHorizontalScrollIndicator = false
		
		return collectionView
	}
}
