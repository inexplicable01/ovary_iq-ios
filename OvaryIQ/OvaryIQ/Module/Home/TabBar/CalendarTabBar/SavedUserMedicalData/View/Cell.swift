//
//  CustomFscalendarCell.swift
//  OvaryIQ
//
//  Created by Mobcoder on 09/03/22.
//

import Foundation
//CustomFscalendarCell
class Cell: FSCalendarCell {
//    var isSelectedDate: Bool = false {
//        didSet {
//            contentView.backgroundColor = isSelectedDate ? .red : .clear
//            contentView.clipsToBounds = false
////            if isSelectedDate {
////                let myView = SavedUserMedicalData()
////               // let frame = self.convert(self.bounds, to: self.superview)
////                //myView.bounds = frame
////                print("frame is...", frame)
////               self.contentView.addSubview(myView)
////                self.contentView.bringSubviewToFront(myView)
////               // self.contentView.addSubview(myView)
////            }
//
//        }
//    }

    override init!(frame: CGRect) {
        super.init(frame: frame)
       // contentView.clipsToBounds = false
        // add your views here
    }

    required init!(coder aDecoder: NSCoder!) {
        queuedFatalError("init(coder:) has not been implemented")
    }

}
