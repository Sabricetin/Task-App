import Foundation

// JSON'dan Model'e dönüştürme işlemleri için yardımcı fonksiyonlar
func parseJSON<T: Decodable>(data: Data, modelType: T.Type) -> T? {
    let decoder = JSONDecoder()
    do {
        let decodedData = try decoder.decode(modelType, from: data)
        return decodedData
    } catch {
        print("JSON parsing error: \(error.localizedDescription)")
        return nil
    }
}
