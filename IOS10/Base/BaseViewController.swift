import UIKit

open class BaseViewController: UIViewController {
    
    override open var prefersStatusBarHidden: Bool {
        return false
    }
    
    var fromOrientation : UIInterfaceOrientation?
    
    //MARK: - Instance
    /// Used to get instance of ViewController from Storyboard
    ///
    /// - returns: instance of BaseViewController
    public class func instance() -> BaseViewController {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: Bundle(for: self))
        let vc = storyboard.instantiateViewController(withIdentifier: String(describing: self))
        return (vc as? BaseViewController)!
    }
    
    // MARK: SnapshotImage
    var snapshotImage: UIImage?
    
    // MARK: - Life Cycle
    override open func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override open func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.snapshotImage = view.snapshotImage()
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.snapshotImage = view.snapshotImage()
    }
    
    // MARK: - Public
    
    public func setStatusBarBackgroundColor(color: UIColor) {
        
        guard let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else { return }
        
        statusBar.backgroundColor = color
    }
    
    public func showAlert(_ title : String, message : String, okButtonTitle: String?, cancelButtonTitle: String?, okCompletion : ((UIAlertAction) -> Void)?, cancelCompletion : ((UIAlertAction) -> Void)?) {
        
        let alertController =  UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if let _okButtonTitle = okButtonTitle {
            alertController.addAction(UIAlertAction(title: _okButtonTitle, style: .default, handler: okCompletion))
        }
        
        if let _cancelButtonTitle = cancelButtonTitle {
            alertController.addAction(UIAlertAction(title: _cancelButtonTitle, style: .cancel, handler: cancelCompletion))
        }
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Override
    /// Used to set type of StatusBar for the current ViewController
    ///
    /// - returns: UIStatusBarStyle
    func statusBarStyle() -> UIStatusBarStyle {
        return .lightContent
    }
    
    func createImageBack(_ img: UIImage) {
        let img_view = UIImageView(image: img)
        img_view.frame = CGRect(x:0, y:0, width:view.frame.width, height:view.frame.height)
        img_view.contentMode = .scaleToFill
        view.insertSubview(img_view, at: 0)
    }
    
    // MARK: For disable ControlCenter Native and notificationCenter
    override open func preferredScreenEdgesDeferringSystemGestures() -> UIRectEdge {
        return [.top, .bottom]
    }
}

//MARK: UIPopoverPresentationControllerDelegate
extension BaseViewController: UIPopoverPresentationControllerDelegate {
    
    public func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
