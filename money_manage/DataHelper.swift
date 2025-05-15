//
//  DataHelper..swift
//  money_manage
//
//  Created by aru on 2025/05/15.
//

import Foundation

func readCSV(filename:String) -> [String]{
    var textData:[String] = []
    let csvBundle = Bundle.main.path(forResource: filename, ofType: "csv")!
    do{
        let csvData = try String(contentsOfFile: csvBundle,encoding: String.Encoding.utf8)
        let lineChange = csvData.replacingOccurrences(of: "\r", with: "\n")
        textData = lineChange.components(separatedBy: "\n")
        textData.removeLast()
    }catch {
        print("can't read CSV")
    }
    return textData
}

//jsonファイルをdecode
func loadChatTemplates() -> ChatTemplates? {
    guard let url = Bundle.main.url(forResource: "chat_template", withExtension: "json") else {
        print("JSONファイルが見つかりません")
        return nil
    }
    do {
        let data = try Data(contentsOf: url)
        let decoded = try JSONDecoder().decode(ChatTemplates.self, from: data)
        return decoded
    } catch {
        print("デコードエラー: \(error.localizedDescription)")
        return nil
    }
}
