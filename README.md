SwiftAutolayoutCrash
====================

Simple crash case in autolayout when transitioning

Run the app, then press GO twice (transitioning via pushViewController)
then press BACK twice (transitioning via popViewController)

Crashes pretty horribly on IOS7.1.1 and IOS7.1.2 *devices*, not on the simulator.

The meaningful part is all in ViewController.swift

reproduced below:

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
