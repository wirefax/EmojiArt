//
//  EmojiArtView.swift
//  EmojiArt
//
//  Created by Maksym Logvin on 3/10/19.
//  Copyright © 2019 Maksym Logvin. All rights reserved.
//

import UIKit

class EmojiArtView: UIView {

    //Когда устанавливается значение переменной мы отдаем команду системе что нам необходимо перерисовать наш экран
    var backgroundImage: UIImage? { didSet {setNeedsDisplay()}}

    //Для того чтобы система перерисовывала то что нам нужно мы переопределяем функцию рисования
    override func draw (_ rect: CGRect) {
        backgroundImage?.draw(in: bounds)
    }
    
    //Крошечная подпорка от Татьяны Корниловой которая фиксит потерю шрифта при сбросе объекта типа строки с аттрибутами
//    private var font: UIFont {
//        return
//            UIFontMetrics(forTextStyle: .body).scaledFont(for:
//                UIFont.preferredFont(forTextStyle: .body).withSize(64.0))
//    }
//    
//    private func addLabel (with attributedString: NSAttributedString,
//                           centeredAt point: CGPoint) {
//        let label = UILabel()
//        label.backgroundColor = .clear
//        label.attributedText =
//            attributedString.font != nil
//            ? attributedString
//            : NSAttributedString(string: attributedString.string,
//                                 attributes: [.font: self.font])
//        label.sizeToFit()
//        label.center = point
//        addEmojiArtGestureRecognizers(to: label)
//        addSubview(label)
//    }
}
