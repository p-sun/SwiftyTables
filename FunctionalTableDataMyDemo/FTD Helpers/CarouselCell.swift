import UIKit

typealias CarouselCell<T: CarouselItemCell> = HostCell<CarouselView<T>, CarouselState<T>, LayoutMarginsTableItemLayout>

struct CarouselState<ItemCell: CarouselItemCell>: StateType, Equatable {

	typealias View = CarouselView<ItemCell>
	
	fileprivate let itemModels: [ItemCell.ItemModel]
	fileprivate let didSelectCell: ((IndexPath) -> Void)?
	fileprivate let collectionHeight: CGFloat
	fileprivate let spacing: CGFloat
	
	init(itemModels: [ItemCell.ItemModel],
		 didSelectCell: ((IndexPath) -> Void)?,
		 collectionHeight: CGFloat = 300,
		 spacing: CGFloat = 0) {
		
		self.itemModels = itemModels
		self.didSelectCell = didSelectCell
		self.collectionHeight = collectionHeight
		self.spacing = spacing
		
		if firstCollectionCellHeight() > collectionHeight {
			assertionFailure("ERROR: CarouselCell's collection view must be taller than its individual cells plus margins.")
		}
	}
	
	static func updateView(_ view: View, state: CarouselState?) {
		guard let state = state else {
			return
		}
		
		view.reload(state: state)
	}
	
	static func ==(lhs: CarouselState<ItemCell>, rhs: CarouselState<ItemCell>) -> Bool {
		return lhs.itemModels == rhs.itemModels
			&& lhs.collectionHeight == rhs.collectionHeight
			&& lhs.spacing == rhs.spacing
	}
	
	private func firstCollectionCellHeight() -> CGFloat {
		if let firstModel = itemModels.first {
			return ItemCell.sizeForItem(model: firstModel).height
		}
		return 0
	}
}

class CarouselView<ItemCell: CarouselItemCell>: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
	var carouselOffset: CGFloat {
		get {
			return collectionView.contentOffset.x
		}
		set {
			collectionView.contentOffset.x = newValue
		}
	}
	
	private var state: CarouselState<ItemCell>?
	private var collectionViewHeightConstraint: NSLayoutConstraint!
	
	private var collectionView: UICollectionView!
	
    init() {
        super.init(frame: CGRect.zero)

		collectionView = createCollectionView()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.addSubview(collectionView)
        collectionView.pinToSuperView()
        
        collectionViewHeightConstraint = collectionView.heightAnchor.activateConstraint(equalToConstant: 300, priority: 999)
		
		if let itemCell = ItemCell.self as? CarouselItemNibView.Type {
			collectionView.register(itemCell.nibWithClassName(), forCellWithReuseIdentifier: ItemCell.reuseId())
		} else {
			collectionView.register(ItemCell.self, forCellWithReuseIdentifier: ItemCell.reuseId())
		}
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
	
	override func layoutSubviews() {
		super.layoutSubviews()
		collectionView.frame = self.bounds
	}

	// MARK: - Public
	func reload(state: CarouselState<ItemCell>) {
		// Stops collection view if it was scrolling.
//		collectionView.setContentOffset(collectionView.contentOffset, animated:false)
//		collectionView.cancelInteractiveMovement()
		
		self.state = state
		
		let flowLayout = collectionView.collectionViewLayout as! CarouselCollectionLayout
		flowLayout.minimumLineSpacing = state.spacing		

		if let firstModel = state.itemModels.first {
			let itemSize = ItemCell.sizeForItem(model: firstModel)
			var width: CGFloat = 0
			width = itemSize.width * CGFloat(state.itemModels.count)
			width += state.spacing * CGFloat(state.itemModels.count - 1)
			flowLayout.contentSize = CGSize(width: width, height: state.collectionHeight)
		}
		
		collectionViewHeightConstraint.constant = state.collectionHeight
		collectionView.reloadData()
		
		print("collection view contentSize \(collectionView.collectionViewLayout.collectionViewContentSize)") // This starts with 0, 0
		
//		if self.superview != nil {
//			UIView.performWithoutAnimation {
////				collectionView.collectionViewLayout.invalidateLayout()
////				collectionView.collectionViewLayout.prepare()
//				collectionView.contentSize = CGSize(width: 600, height: 500)
////				collectionView.layoutIfNeeded()
//			}
//		}
		
//		collectionView.collectionViewLayout.invalidateLayout()
//		collectionView.setNeedsLayout()
//		collectionView.layoutIfNeeded()
	}
	
	// MARK: - UICollectionView Delegates
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.state?.itemModels.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCell.reuseId(), for: indexPath) as? ItemCell, let state = state {
            let model = state.itemModels[indexPath.row]
            cell.configure(model: model)
            cell.tag = indexPath.row
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		state?.didSelectCell?(indexPath)
    }
	
	// Return item size instead of dynamic resizing for smoother scrolling.
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		guard let state = state else { return CGSize.zero }
		return ItemCell.sizeForItem(model: state.itemModels[indexPath.row])
	}
	
	// MARK: - Private
	private func createCollectionView() -> UICollectionView {
		let flowLayout = CarouselCollectionLayout()
		
		let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
		collectionView.backgroundColor = .white
		collectionView.showsHorizontalScrollIndicator = false
		
		return collectionView
	}
}

class CarouselCollectionLayout: UICollectionViewFlowLayout {
	
	var contentSize: CGSize = CGSize.zero
	
	override init() {
		super.init()
		self.scrollDirection = .horizontal
		self.estimatedItemSize = CGSize(width: 1, height: 1)
		self.minimumLineSpacing = 0
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override var collectionViewContentSize: CGSize {
		return contentSize
	}
}
