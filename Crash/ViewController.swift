
import UIKit

class TestViewController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Disable this line to get a sense of the navigation transitions
        self.view.backgroundColor = UIColor.whiteColor()

        let (add, views) = makeAdder(self.view)

        let iconFrame = UIView.newAutoLayoutView()
        add(iconFrame, "iconFrame")
        fillIconFrame(iconFrame)

        let bOK = UIButton.buttonWithType(.System) as UIButton
        bOK.addTarget(self, action: Selector("next:"), forControlEvents: .TouchUpInside)
        bOK.setTitle("GO", forState: .Normal)
        add(bOK, "ok")
        
        let l = UILabel.newAutoLayoutView()
        add(l, "text")
        l.text = "To Crash: Press GO At least twice, then back twice"
        l.autoCenterInSuperview()
        
        //THIS WORKS FINE
        //l.autoSetDimension(.Width, toSize: self.view.frame.size.width * 0.8)
        
        //THIS CRASHES
        l.autoMatchDimension(.Width, toDimension: .Width, ofView: self.view, withMultiplier: 0.8)
        
        VFL(self.view, "V:[iconFrame][text][ok]", .AlignAllCenterX, nil, views)

        iconFrame.autoMatchDimension(.Width, toDimension: .Width, ofView: l)
        bOK.autoMatchDimension(.Width, toDimension: .Width, ofView: l)
    }

    func fillIconFrame(iconFrame:UIView) {
        let (iconAdd, iconViews) = makeAdder(iconFrame)
        
        let icon = UIView.newAutoLayoutView()
        icon.backgroundColor = UIColor.redColor()
        icon.setTranslatesAutoresizingMaskIntoConstraints(false)
        iconAdd(icon, "i")
        let sz:CGFloat = 48
        icon.autoSetDimension(.Width, toSize:sz)
        icon.autoSetDimension(.Height, toSize:sz)

        let lName = UILabel.newAutoLayoutView()
        lName.text = "NAME"
        iconAdd(lName, "name")
        
        VFL(iconFrame, "|[i][name]|", nil, nil, iconViews)
    }
    
    func next(sender:AnyObject) {
        self.navigationController.pushViewController(TestViewController(), animated: true)
    }
    
    override init() {
        super.init(nibName: nil, bundle:nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
}

func makeAdder(parentView:UIView) -> ((UIView, String) -> String, NSMutableDictionary) {
    let d = NSMutableDictionary()
    let adder = { (v: UIView, s: String) -> (String) in
        parentView.addSubview(v)
        d[s] = v
        return s
    }
    return (adder, d)
}

func VFL(view:UIView, visualFormat:String, options:NSLayoutFormatOptions, metrics:NSDictionary!, views:NSDictionary!) -> [AnyObject] {
    let a = NSLayoutConstraint.constraintsWithVisualFormat(visualFormat
        ,options:options
        ,metrics:metrics
        ,views:views)
    view.addConstraints(a)
    return a
}
