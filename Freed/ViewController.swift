//
//  ViewController.swift
//  Freed
//
//  Created by alvin anderson on 27/04/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var label: UILabel!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @objc func showMiracle(){
        let slideVC = OverlayInsertView()
//        let slideVC = storyboard?.instantiateViewController(identifier: "other") as! OverlayInsertView
        slideVC.modalPresentationStyle = .custom
        slideVC.transitioningDelegate = self
        slideVC.completionHandler = {
            text in self.label.text = text
        }
        self.present(slideVC, animated: true, completion: nil)
    }
    @IBAction func onButton(_ sender: UIButton) {
        showMiracle()
        }
    }

extension ViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented, presenting: presenting)
    }
}
