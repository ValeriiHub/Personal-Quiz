//
//  Questions.swift
//  Personal Quiz
//
//  Created by Valerii D on 25.04.2021.
//

struct Questions {
    var text: String
    var type: ResponseType
    var answers: [Answer]
}

extension Questions {
    static func getQuestion() -> [Questions] {
        return [Questions(text: "Какую пищу вы предпочитаете?",
                          type: .single,
                          answers: [
                            Answer(text: "Стейк", type: .dog),
                            Answer(text: "Рыба", type: .cat),
                            Answer(text: "Морковь", type: .rabbit),
                            Answer(text: "Кукуруза", type: .turtle)
                          ]
            ), Questions(text: "что вам нравится больше?",
                         type: .multiple,
                         answers: [
                           Answer(text: "Плавать", type: .dog),
                           Answer(text: "Спать", type: .cat),
                           Answer(text: "Обниматься", type: .rabbit),
                           Answer(text: "Есть", type: .turtle)
                         ]
            ), Questions(text: "любители вы поездки на машине?",
                         type: .ranged,
                         answers: [
                           Answer(text: "Ненавижу", type: .dog),
                           Answer(text: "Нервничаю", type: .cat),
                           Answer(text: "Не замечаю", type: .rabbit),
                           Answer(text: "Обожаю", type: .turtle)
                         ]
            )
        ]
    }
}
