//
//  ViewController.swift
//  ADolceSwipeableCards
//
//  Created by Andrew Dolce on 1/21/16.
//  Copyright © 2016 Intrepid Pursuits. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cardContainerView: UIView!

    private var cardColors = [UIColor]()
    private var cardViews = [UIView]()

    override func viewDidLoad() {
        super.viewDidLoad()

        createTestCards()
        createCardViews()
    }

    private func createTestCards() {
        cardColors = [
            UIColor.redColor(),
            UIColor.orangeColor(),
            UIColor.yellowColor(),
            UIColor.greenColor(),
            UIColor.blueColor(),
            UIColor.purpleColor()
        ]
    }

    private func createCardViews() {
        cardViews = cardColors.map { color in
            let cardView = CardView(frame: self.cardContainerView.frame)
            cardView.backgroundColor = color

            self.cardContainerView.addSubview(cardView)

            let margins = self.cardContainerView.layoutMarginsGuide
            cardView.leadingAnchor.constraintEqualToAnchor(margins.leadingAnchor).active = true
            cardView.trailingAnchor.constraintEqualToAnchor(margins.trailingAnchor).active = true
            cardView.topAnchor.constraintEqualToAnchor(margins.topAnchor).active = true
            cardView.bottomAnchor.constraintEqualToAnchor(margins.bottomAnchor).active = true

            cardView.translatesAutoresizingMaskIntoConstraints = false

            return cardView
        }
    }
}

