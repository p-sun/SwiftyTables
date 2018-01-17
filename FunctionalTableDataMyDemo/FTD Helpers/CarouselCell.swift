import UIKit

/* NOTE: if collectionHeight < item height, the app will enter a loop.
   Set a symbolic breakpoint at UICollectionViewFlowLayoutBreakForInvalidSizes to catch it.
 **/
struct CarouselState<ItemCell: CarouselItemCell>: StateType, Equatable {

	typealias View = CarouselView<ItemCell>
	
	fileprivate let itemModels: [ItemCell.ItemModel]
	fileprivate let didSelectCell: ((IndexPath) -> Void)?
	fileprivate let collectionHeight: CGFloat
    fileprivate let scrollDirection: UICollectionViewScrollDirection

	init(itemModels: [ItemCell.ItemModel],
         scrollDirection: UICollectionViewScrollDirection,
		 collectionHeight: CGFloat,
         didSelectCell: ((IndexPath) -> Void)?) {
		
		self.itemModels = itemModels
        self.scrollDirection = scrollDirection
		self.collectionHeight = collectionHeight
        self.didSelectCell = didSelectCell
	}
	
	static func updateView(_ view: View, state: CarouselState?) {
		guard let state = state else {
            // Prepare for reuse if needed
			return
		}
		
		view.reload(state: state)
	}
	
	static func ==(lhs: CarouselState<ItemCell>, rhs: CarouselState<ItemCell>) -> Bool {
        var equality = lhs.itemModels == rhs.itemModels
        equality = equality && lhs.collectionHeight == rhs.collectionHeight
        equality = equality && lhs.scrollDirection == rhs.scrollDirection
        return equality
	}
}

class CarouselView<ItemCell: CarouselItemCell>: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
	var carouselOffset: CGFloat {
		get {
			return collectionView.contentOffset.x + collectionView.contentInset.left
		}
		set {
			collectionView.contentOffset.x = newValue - collectionView.contentInset.left
		}
	}
	
	private var state: CarouselState<ItemCell>?
	private var cellHeightConstraint: NSLayoutConstraint!

	private var collectionView: UICollectionView!
    private var flowLayout = UICollectionViewFlowLayout()
    
    init() {
        super.init(frame: CGRect.zero)

		collectionView = createCollectionView()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.addSubview(collectionView)
        collectionView.pinToSuperView()

        cellHeightConstraint = self.heightAnchor.constraint(equalToConstant: 200)
        cellHeightConstraint.isActive = true
		
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
    
    func setContentInset(_ insets: UIEdgeInsets) {
        collectionView.contentInset = insets
    }
    
	func reload(state: CarouselState<ItemCell>) {
		// Stops collection view if it was scrolling.
        collectionView.setContentOffset(collectionView.contentOffset, animated:false)
        collectionView.cancelInteractiveMovement()
        cellHeightConstraint.constant = state.collectionHeight
        flowLayout.scrollDirection = state.scrollDirection
        self.state = state
		collectionView.reloadData()
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
	
	// Return item size for smoother scrolling.
    // Actual item size is calculated dynamically with the view's constraints, and is not affected by this.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let state = state else { return CGSize.zero }
        return ItemCell.sizeForItem(model: state.itemModels[indexPath.row])
    }
	
	// MARK: - Private
	private func createCollectionView() -> UICollectionView {
        // NOTE: Do NOT set minimumLineSpacing in the flow layout because the collectionView's contentSize will not size correctly. If absolutely needed, set spacing in your item cells instead.
        flowLayout.scrollDirection = .horizontal

		let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
		collectionView.backgroundColor = .white
		collectionView.showsHorizontalScrollIndicator = false

		return collectionView
	}
}
