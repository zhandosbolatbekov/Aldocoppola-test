//
//  ImageManager.swift
//  Aldo-Coppola-Test
//
//  Created by Zhandos Bolatbekov on 4/25/18.
//  Copyright © 2018 Zhandos Bolatbekov. All rights reserved.
//

import Foundation
import Cache

// константы
private struct Constants {
    static let diskConfigName = "Images Disk Config"
}

struct ImageManager {
    
    // MARK: - переменные
    /// экземпляр кэша
    private static var imageStorage = try! Cache.Storage(diskConfig: DiskConfig(name: Constants.diskConfigName),
                                                         memoryConfig: MemoryConfig())
    
    // MARK: - функции
    /**
     Достает изображение из кэша
     
     - Parameter url: Ключ, по которому будет доставать изображение
     - Parameter completion: Функция, которая сработает, когда придет ответ от кэша
     */
    private static func fetchFromCache(withURL url: String, completion: @escaping (UIImage?) -> Void) {
        imageStorage.async.object(ofType: ImageWrapper.self, forKey: url) { result in
            DispatchQueue.main.async {
                switch result {
                case .value(let value):
                    completion(value.image)
                case .error(let error):
                    print("ОШИБКА ПРИ ЗАГРУЗКЕ ИЗОБРАЖЕНИЯ С КЭША: \(error.localizedDescription)")
                    print("URL: \(url)\n")
                    completion(nil)
                }
            }
        }
    }
    
    /**
     Скачивает изображение с кэша
     Если отсутствует, то скачивает с интернета и добавляет в кэш
     
     - Parameter url: Ключ, по которому будет доставать изображение
     - Parameter permamently: Переменная, которая отвечает на какой период сохранить изображение к кэше
     - Parameter completion: Функция, которая сработает, когда придет ответ
     */
    static func fetch(from url: String, permamently: Bool = false, completion: @escaping (UIImage?, String) -> Void) {
        fetchFromCache(withURL: url) { image in
            DispatchQueue.main.async {
                if let image = image {
                    completion(image, url)
                } else {
                    NetworkService.downloadImage(from: url) { image in
                        if let image = image {
                            insert(image, withURL: url, permamently: permamently)
                            completion(image, url)
                        } else {
                            completion(nil, url)
                        }
                    }
                }
            }
        }
    }
    
    /**
     Добавляем изображение в кэш
     
     - Parameter image: Изображение
     - Parameter url: Ключ, по которому будут сохранять изображение
     - Parameter permamently: Переменная, которая отвечает на какой период сохранить изображение к кэше
     - Parameter completion: Функция, которая сработает, когда придет ответ
     */
    static func insert(_ image: UIImage, withURL url: String, permamently: Bool = false, completion: (() -> Void)? = nil) {
        // либо 2 дня, либо вечно
        let expiry = permamently ? Expiry.never : Expiry.seconds(60 * 60 * 24 * 2)
        
        imageStorage.async.setObject(ImageWrapper(image: image), forKey: url, expiry: expiry) { result in
            DispatchQueue.main.async {
                switch result {
                case .value:
                    completion?()
                case .error(let error):
                    print("ОШИБКА ПРИ ЗАГРУЗКЕ ИЗОБРАЖЕНИЯ В КЭШ: \(error.localizedDescription)")
                    print("URL: \(url)\n")
                }
            }
        }
    }
    
    // удалить изображение из памяти
    static func remove(withURL url: String, completion: (() -> Void)? = nil) {
        imageStorage.async.removeObject(forKey: url) { result in
            DispatchQueue.main.async {
                switch result {
                case .value:
                    completion?()
                case .error(let error):
                    print("ОШИБКА ПРИ УДАЛЕНИИ ИЗОБРАЖЕНИЯ ИЗ КЭША: \(error.localizedDescription)")
                    print("URL: \(url)\n")
                }
            }
        }
    }
    
    /**
     Удаляет старые изображения из кэша
     Срок хранения изображения 2 дня
     */
    static func removeOldImages() {
        do {
            try imageStorage.removeExpiredObjects()
        } catch {
            print("ОШИБКА ПРИ УДАЛЕНИИ СТАРЫХ ИЗОБРАЖЕНИЙ: \(error.localizedDescription)\n")
        }
    }
    
    // очистить кэш полностью
    static func clear() {
        do {
            try imageStorage.removeAll()
            imageStorage = try Cache.Storage(diskConfig: DiskConfig(name: Constants.diskConfigName),
                                             memoryConfig: MemoryConfig())
        } catch {
            print("ОШИБКА ПРИ ОЧИСТКЕ КЭША ИЗОБРАЖЕНИЙ: \(error.localizedDescription)\n")
        }
    }
}
