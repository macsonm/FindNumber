//
//  Settings.swift
//  FindNumber_icodeschool
//
//  Created by Maxim M on 28.01.2022.
//

import Foundation

enum KeysUserDefaults{
    static let settingGame = "settingsGame"
    
    static let recordGame = "recordGame"
}

struct SettingsGame: Codable {       //структура для сохранения настроек в UserDefauls.standard.integer; для сохранения экзепляра необходимо перевести его в тип Data, для этого подписываемся под Codable
    var timerState: Bool
    var timeForGame: Int
    
}



class Settings {
    static var shared = Settings()      //singleton - не будет уничтожен пока программа работает
    
    private let defaultSettings = SettingsGame(timerState: true, timeForGame: 30)
    
    var currentSettings: SettingsGame {     //сохраняем экземпляр структуры SettingsGame в хранилище UserDefaults

//MARK: - ???????
        get{        //получение настроек
            if let data = UserDefaults.standard.object(forKey: KeysUserDefaults.settingGame) as? Data {
                return try! PropertyListDecoder().decode(SettingsGame.self, from: data)     //try!
            } else {
                if let data = try? PropertyListEncoder().encode(defaultSettings){
                    UserDefaults.standard.setValue(data, forKey: KeysUserDefaults.settingGame)
            }
                return defaultSettings
            }
            
        }
        set{    //сохраняем натсройки - преобразуем эксзепляр, который пришел, т.е. кодируем newValue
            
//            do{     //обработка ошибок
//            let data  = try PropertyListEncoder().encode(newValue)
//            }catch{
//                print(error)
//            }
            if let data = try? PropertyListEncoder().encode(newValue){
                UserDefaults.standard.setValue(data, forKey: KeysUserDefaults.settingGame)
            }
    }

    }
    
    func resetSettings() {
        currentSettings = defaultSettings
    }
}
