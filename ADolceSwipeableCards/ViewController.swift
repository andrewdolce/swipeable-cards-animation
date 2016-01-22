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

    private var cards = [Card]()
    private var cardViewsInStack = [UIView]()
    private var flyingCardView: UIView? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        createTestCards()
        createCardViews()
        createTapRecognizer()
    }

    private func createTestCards() {
        cards = [
            Card(color: UIColor.redColor()),
            Card(color: UIColor.orangeColor()),
            Card(color: UIColor.yellowColor()),
            Card(color: UIColor.greenColor()),
            Card(color: UIColor.blueColor()),
            Card(color: UIColor.purpleColor())
        ]
    }

    private func createCardViews() {
        cardViewsInStack = cards.map { card in
            let cardView = CardView(frame: self.cardContainerView.frame)
            cardView.backgroundColor = card.color

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

    private func updateCardViews() {
        let hiddenCardTransform = CGAffineTransformMakeScale(0.8, 0.8);

        let transformsFrontToBack = [
            CGAffineTransformIdentity,
            CGAffineTransformTranslate(CGAffineTransformMakeScale(0.9, 0.9), 0, -40),
            CGAffineTransformTranslate(CGAffineTransformMakeScale(0.8, 0.8), 0, -80)
        ]

        for (index, cardView) in cardViewsInStack.reverse().enumerate() {
            if index < transformsFrontToBack.count {
                cardView.transform = transformsFrontToBack[index]
                cardView.alpha = 1
            } else {
                cardView.transform = hiddenCardTransform
                cardView.alpha = 0
            }
        }
    }

    private func moveFrontCardToBack() {
        guard let frontCard = cards.last, let frontCardView = cardViewsInStack.last else {
            return
        }

        cards.popLast()
        cards.insert(frontCard, atIndex: 0)
        cardViewsInStack.popLast()

        throwCardView(frontCardView)

        UIView.animateWithDuration(0.5, animations: updateCardViews)
    }

    private func throwCardView(cardView: UIView) {
        let thrownTransform = CGAffineTransformTranslate(CGAffineTransformMakeRotation(CGFloat(M_1_PI) / 4.0), 400, 0)
        UIView.animateWithDuration(0.5, animations: {
            cardView.transform = thrownTransform
        }, completion: { finished in
            cardView.alpha = 0
            self.cardContainerView.sendSubviewToBack(cardView)
            self.cardViewsInStack.insert(cardView, atIndex: 0)
        })
    }

    // MARK: Gestures

    private func createTapRecognizer() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: "didTapCards:")
        cardContainerView.addGestureRecognizer(tapRecognizer)
    }

    dynamic private func didTapCards(recognizer: UITapGestureRecognizer) {
        moveFrontCardToBack()
    }
}





