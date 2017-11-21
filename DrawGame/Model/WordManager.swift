import Foundation

class WordManager {
    
    private static let words = ["perro", "casa", "gato", "conejo", "iglesia", "agua", "mar", "playa", "nubes", "manzana", "plátano", "café", "zapato", "pantalón", "camisa", "balón", "guantes", "sillón", "gorra", "lápiz", "mochila", "árbol", "mesa", "roca", "carro", "bicicleta", "lluvia", "tormenta", "chamarra", "televisión", "calle", "puerta", "ventana", "techo", "pistola", "montaña", "lago", "dinero", "billete", "moneda", "guitarra", "tambor", "libro"]
    
    static func getRandomWord() -> String {
        let x = Int(arc4random_uniform(UInt32(words.count)))
        return words[x]
    }
    
    static func getAnswerOptions(totalCount: Int, correctAnswer: String) -> [String] {
        var words = self.words
        var options = [String]()
        
        for _ in 0..<(totalCount - 1) {
            let x = Int(arc4random_uniform(UInt32(words.count)))
            let word = words[x]
            words.remove(at: x)
            options.append(word)
        }
        
        let correctAnswerIndex = Int(arc4random_uniform(UInt32(totalCount - 1)))
        options.insert(correctAnswer, at: correctAnswerIndex)
        
        return options
    }
}
