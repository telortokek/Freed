//
//  OverlayInsertView.swift
//  Freed
//
//  Created by alvin anderson on 28/04/22.
//

import UIKit

class OverlayInsertView: UIViewController {
    
    var hasSetPointOrigin = false
    var pointOrigin: CGPoint?
    @IBOutlet weak var TimePicker: UITextField!
    @IBOutlet weak var TimePicker2: UITextField!
    @IBOutlet weak var SaveButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        view.addGestureRecognizer(panGesture)
        let time = Date()
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_gb")
        formatter.dateFormat = "hh:mm:ss"
        TimePicker.text = formatter.string(from: time)
        TimePicker.textColor = .link
        TimePicker2.text = formatter.string(from: time)
        TimePicker2.textColor = .link
        
        let picker = UIDatePicker()
        picker.datePickerMode = .time
        picker.addTarget(self, action: #selector(timePickerValueChanged(sender:)), for: UIControl.Event.valueChanged)
        picker.frame.size = CGSize(width: 0, height: 250)
        TimePicker.inputView = picker
        TimePicker2.inputView = picker
    }
    
    @objc func timePickerValueChanged(sender: UIDatePicker){
        //when time is changed it will appear here
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_gb")
        formatter.dateFormat = "hh:mm:ss"
        TimePicker.text = formatter.string(from: sender.date)
        TimePicker2.text = formatter.string(from: sender.date)
    }
    override func viewDidLayoutSubviews() {
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            pointOrigin = self.view.frame.origin
        }
    }
    
    public var completionHandler: ((String) -> Void)?
    
    @IBOutlet var field: UITextField!
//    @IBAction func didTapSave(){
//        completionHandler?(field.text ?? <#default value#>!)
//
//        dismiss(animated: true, completion: nil)
//    }
    @objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        // Not allowing the user to drag the view upward
        guard translation.y >= 0 else { return }
        
        // setting x as 0 because we don't want users to move the frame side ways!! Only want straight up or down
        view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)
        
        if sender.state == .ended {
            let dragVelocity = sender.velocity(in: view)
            if dragVelocity.y >= 1300 {
                self.dismiss(animated: true, completion: nil)
            } else {
                // Set back to original position of the view controller
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
                }
            }
        }
    }
}
