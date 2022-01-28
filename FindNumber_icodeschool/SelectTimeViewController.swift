import UIKit

class SelectTimeViewController: UIViewController {
    
    @IBOutlet weak var tableViewSettings: UITableView!{
        didSet{
            tableViewSettings?.dataSource = self    //задаем DataSource для TableView и подписываем SelectTimeVC  под протокол в extension
            tableViewSettings?.delegate = self      //позволяет взаимодействовать с таблицей и отслеживать действия выбора ячеек
        }
    }
    
    var data: [Int] = []    // принимаем сюда данные с SettingsTableViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
 //       tableViewSettings.reloadData()      //обновление данных
        
    }
    
}

// MARK: - отображение ячеек на экране
extension SelectTimeViewController: UITableViewDataSource, UITableViewDelegate { //
   
    func numberOfSections(in tableView: UITableView) -> Int {       //по дефолту return 1 - метод можно полностью убрать*
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return data.count   //подсчитываем кол-во элементов для дальнейшего создания под них строк
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "timeCell", for: indexPath) //переиспользование ячеек "dequeueReusableCell", то есть ячейки, которых не видно на экране будут использоваться для новых данных. (т.е. всего 20 ячеек, но на экране создается только 17+1 скрытая, то есть памяти приложению надо на 18 ячеек, а не на 20)
        
        var content = cell.defaultContentConfiguration()
        //content.text = "section - \(indexPath.section) row - \(indexPath.row)"
        content.text = String(data[indexPath.row])
        cell.contentConfiguration = content
        
        return cell
    }
    
    //для .delegate необходимо реализовать didSelectRowAt
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableViewSettings.deselectRow(at: indexPath, animated: true)   //убираем серую полоску при нажатии на строчку
        
//        UserDefaults.standard.setValue(data[indexPath.row], forKey: "timeForGame")      //UserDefaults небольшое хранилище для данных небольшого объема, такие как настройки.ключ для хранения значений - это timeForGame
//
//        UserDefaults.standard.integer(forKey: "timeForGame")      //Читаем значения из UserDefauls, если нет значения,то метод .integer for key вернет 0 (если bool, то false, float вернет 0.0)
//
//        if UserDefaults.standard.object(forKey: "") != nil{        //Если надо поместить в UserDefaul другой тип данных например строку, то исп .object, где в случае отсутствия значения будет возвращен nil
//
//        }
//
        Settings.shared.currentSettings.timeForGame = data[indexPath.row]       //сохраняем настройку и возвращаемся назад
        navigationController?.popViewController(animated: true)
    }
    
    
}
