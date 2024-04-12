struct DummyUsers {
    static func create() -> [Person] {
        let names = ["Queen", "Senorita", "Girly", "Gal", "Sis", "Chica", "Missy", "Homegirl", "Baby Face", "Angel", "Baby Girl", "Cupcake", "Coco", "Sunshine", "Heartbeat", "Pumpkin", "Cookie", "Fox", "Buddy", "King", "Champ", "Bro", "Amigo", "Bubba", "Chief", "Buck", "Coach", "Junior", "Senior", "Dude",
                     "Buster"]
        var persons: [Person] = []
        for index in 0..<names.count {
            let id = String(format: "fs%02d", index + 1)
            let person = Person(id: id, username: names[index], email: "\(names[index])@icloud.com", avatarLink: "https://raw.githubusercontent.com/VladimirFibe/FirstStep/main/FirstStep/Assets.xcassets/fsimages/\(id).imageset/\(id).jpg")
            persons.append(person)
        }
        return persons
    }
}
