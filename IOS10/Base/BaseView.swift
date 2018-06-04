import Foundation
import UIKit

open class BaseView: UIView, InstantiableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        if self.subviews.count == 0{
            self.commonInit()
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        if self.subviews.count == 0 {
            self.commonInit()
        }
    }
    
    open func commonInit() {
        self.xibSetup(String(describing: type(of: self)))
        self.updateView()
    }
    
    open func updateView(){
        
    }
}
