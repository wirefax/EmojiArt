//
//  EmojiArtViewController.swift
//  EmojiArt
//
//  Created by Maksym Logvin on 3/10/19.
//  Copyright © 2019 Maksym Logvin. All rights reserved.
//

import UIKit

class EmojiArtViewController: UIViewController, UIDropInteractionDelegate {

    //Зона сброса после drag-n-drop
    //Добавляем немного интерактива в виде UIDropInteraction и делаем себя (контроллер) делегатом
    @IBOutlet weak var dropZone: UIView! {
        didSet {
            dropZone.addInteraction(UIDropInteraction(delegate: self))
        }
    }
    
    //Реализовываем необязательные методы из протокола UIDropInteractionDelegate
    //Они необходимы нам для того чтобы наш Drop заработал
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: NSURL.self) && session.canLoadObjects(ofClass: UIImage.self) //Говорим что будем обрабатывать только изображения и урлы этих изображений
    }
    
    //Если перетаскивание проходит первый этап проверки на тип
    //Дальше реализовывается метод копирования так как всегда изображение будет приходить извне и нет причин отказываться так что не будет .cancel
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        return UIDropProposal (operation: .copy)
    }
    
    //Здесь пользователь уже оторвал палец от экрана и наш груз полетел в зону сброса
    //Замыкание выполняется после того как уже получены данные NSURL
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        imageFetcher = ImageFetcher() { (url, image) in //Так как после выборки данных imageFetcher не находится на main.queue то возращаемся туда
            DispatchQueue.main.async {
                self.emojiArtView.backgroundImage = image
            }
        }
        session.loadObjects(ofClass: NSURL.self) {nsurls in
            if let url = nsurls.first as? URL { //на случай если в момент перетаскивания другими пальцами были добавлены еще элементы, получаем урл сммого первого элемента массива сброшенных урлов
            self.imageFetcher.fetch(url)
            }
        }
        session.loadObjects(ofClass: UIImage.self) {images in
            if let image = images.first as? UIImage {
            self.imageFetcher.backup = image
            }
        }
        
    }
    
    var imageFetcher: ImageFetcher!
    
    //Зона рисовки фонового изображения
    @IBOutlet weak var emojiArtView: EmojiArtView!
    
}
