//
//  LTDemoViewController.swift
//  LTMorphingLabelDemo
//
//  Created by Lex on 6/23/14.
//  Copyright (c) 2015 lexrus.com. All rights reserved.
//

import UIKit

class LTDemoViewController : UIViewController, LTMorphingLabelDelegate {
    
    fileprivate var i = -1
    fileprivate var textArray = [
        "What is design?",
        "Design", "Design is not just", "what it looks like", "and feels like.",
        "Design", "is how it works.", "- Steve Jobs",
        "Older people", "sit down and ask,", "'What is it?'",
        "but the boy asks,", "'What can I do with it?'.", "- Steve Jobs",
        "", "Swift", "Objective-C", "iPhone", "iPad", "Mac Mini",
        "MacBook Pro🔥", "Mac Pro⚡️",
        "爱老婆",
        "नमस्ते दुनिया",
        "हिन्दी भाषा"
    ]
    fileprivate var text: String {
        i = i >= textArray.count - 1 ? 0 : i + 1
        return textArray[i]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.delegate = self
        label.font = UIFont.boldSystemFont(ofSize: 85)
        
        let textField = UITextField()
        textField.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        view.addSubview(textField)
        textField.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
        textField.becomeFirstResponder()
    }

    @IBOutlet fileprivate var label: LTMorphingLabel!
    
    @IBAction func changeText(_ sender: AnyObject) {
        label.text = text
    }

    @IBAction func clear(_ sender: Any) {
        label.text = nil
    }
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        let seg = sender
        if let effect = LTMorphingEffect(rawValue: seg.selectedSegmentIndex) {
            label.morphingEffect = effect
            changeText(sender)
        }
    }

    @IBAction func toggleLight(_ sender: UISegmentedControl) {
        let isNight = Bool(sender.selectedSegmentIndex == 0)
        view.backgroundColor = isNight ? UIColor.black : UIColor.white
        label.textColor = isNight ? UIColor.white : UIColor.black
    }
    
    @IBAction func changeFontSize(_ sender: UISlider) {
        label.font = UIFont.init(name: label.font.fontName, size: CGFloat(sender.value))
        label.text = label.text
    }
    
    @objc func textChanged(_ textField: UITextField) {
        let string = textField.text ?? String()
        let attributedString = NSMutableAttributedString(string: string)
        
        let fontSize: CGFloat = string.count > 4 ? 70 : 85
        label.font = UIFont.boldSystemFont(ofSize: fontSize)
        if string.count > 6 {
            let range = NSMakeRange(6, string.count - 6)
            attributedString.addAttributes([.font: UIFont.init(name: label.font.fontName, size: label.font.pointSize*0.7)!, .baselineOffset: NSNumber(value: 25 + Float(label.font.pointSize - label.font.pointSize*0.7)/2)], range: range)
            let range2 = NSMakeRange(4, 6 - 4)
            attributedString.addAttributes([.font: UIFont.init(name: label.font.fontName, size: label.font.pointSize*0.8)!, .baselineOffset: NSNumber(value: -Float(label.font.pointSize - label.font.pointSize*0.8)/2)], range: range2)
        } else if string.count > 4 {
            let range = NSMakeRange(4, string.count - 4)
            attributedString.addAttributes([.font: UIFont.init(name: label.font.fontName, size: label.font.pointSize*0.8)!, .baselineOffset: NSNumber(value: -Float(label.font.pointSize - label.font.pointSize*0.8)/2)], range: range)
        }
        
        label.customAttributedText = attributedString
    }
}

extension LTDemoViewController {
    
    func morphingDidStart(_ label: LTMorphingLabel) {
        
    }
    
    func morphingDidComplete(_ label: LTMorphingLabel) {
        
    }
    
    func morphingOnProgress(_ label: LTMorphingLabel, progress: Float) {
        
    }
    
}
