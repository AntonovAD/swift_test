import Foundation

func inputInt(silence: Bool = false, placeholder: String = "значение") -> Int {
    silence ? nil : print("Введите \(placeholder):")
    let input: String = readLine(strippingNewline: true) ?? ""
    let number: Int? = Int(input)
    if number != nil {
        return number!
    } else {
        print("Ошибка ввода")
        exit(0)
    }
}

func inputString(silence: Bool = false, placeholder: String = "значение") -> String {
    silence ? nil : print("Введите \(placeholder):")
    let input: String = readLine(strippingNewline: true) ?? ""
    return input
}

let exercise: Int

if CommandLine.arguments.count == 1 {
    exercise = inputInt(placeholder: "номер задания")
} else {
    let arg = CommandLine.arguments[1]
    exercise = Int(arg)!
}

let availableExercise = [1,2,3,4,5]

if availableExercise.contains(exercise) {
    print("Задание \(exercise)")
} else {
    print("Такое задание не доступно")
    exit(0)
}

func exercise1() -> Void {
    let N: Int = inputInt(placeholder: "N") //23
    let M: Int = inputInt(placeholder: "M") //52
    let X: Int = inputInt(placeholder: "X") //8
    let Y: Int = inputInt(placeholder: "Y") //43

    let longerSide: Int = N>M ? N : M
    let shorterSide: Int = N>M ? M : N
    let diffToLongerSide: Int = shorterSide-X
    let leftToLongerSide: Int = diffToLongerSide<X ? diffToLongerSide : X
    let diffToShorterSide: Int = longerSide-Y
    let leftToShorterSide: Int = diffToShorterSide<Y ? diffToShorterSide : Y

    let needToAlive: Int = leftToShorterSide<leftToLongerSide ? leftToShorterSide : leftToLongerSide

    print("Ответ:")
    print(needToAlive) //8
}

func exercise2() -> Void {
    let S: Int = inputInt(placeholder: "S") //109
    let V: Int = inputInt(placeholder: "V") //60
    let T: Int = inputInt(placeholder: "T") //2

    let dirForward: Bool = V>0

    let completeLength: Int = V*T
    let lap: Int = dirForward ? Int(ceil(Double(completeLength/S))) : Int(floor(Double(completeLength/S)))
    let lapLength: Int = dirForward ? S*(lap-1) : S*lap

    let marker: Int = completeLength-lapLength

    print("Ответ:")
    print(marker) //120
}

func exercise3() -> Void {
    let N: Int = inputInt(placeholder: "N") //8
    var array: [Int] = [Int]() //[4, 3, 5, 2, 5, 1, 3, 5]
    print("Введите по очереди значения для array:")
    Array(1...N).forEach { item in
        let input: Int = inputInt(silence: true)
        array.append(input)
    }

    let resultDict: [Int:(index: Int, count: Int)] = array.enumerated().reduce(into: [:]) { result, item in
        if (Mirror(reflecting: result[item.element]).children.count>0) {
            result[item.element]?.count += 1
        } else {
            result[item.element] = (
                index: item.offset,
                count: 1
            )
        }
    }

    var uniqItems: [Int: Int] = resultDict.enumerated().reduce(into: [:]) { result, item in
        if (item.element.value.count == 1) {
            result[item.element.value.index] = item.element.key
        }
    }

    //print(uniqItems.values)

    //print(type(of: uniqItems))
    //print(uniqItems)

    let uniqItemsSorted: [(key: Int, value: Int)] = uniqItems.sorted(by: { $0.0 < $1.0 })

    //print(type(of: uniqItemsSorted))
    //print(uniqItemsSorted)

    print("Ответ:")
    print(uniqItemsSorted.map {$0.value}) //[4, 2, 1]
}

func exercise4() -> Void {
    let randomString: String = inputString(placeholder: "ip") //"127.0.0.1"

    var validationResult: Bool = true

    let splittedString: [String] = randomString.split(separator: ".").map(String.init)

    if (splittedString.count != 4) {
        validationResult = false
    } else {
        splittedString.forEach { item in
            let stringToInt: Int? = Int(item);

            if (stringToInt != nil && Double(stringToInt!).isFinite) {
                if (stringToInt! <= 255 && stringToInt! >= 0) {

                } else {
                    validationResult = false
                }
            } else {
                validationResult = false
            }
        }
    }

    print("Ответ:")
    print(validationResult ? "YES" : "NO")
}

func exercise5() -> Void {
    let N: Int = inputInt(placeholder: "N") //3
    var arrayN: [Int] = [Int]() //[1,3,2]
    print("Введите по очереди значения для arrayN:")
    Array(1...N).forEach { item in
        let input: Int = inputInt(silence: true)
        arrayN.append(input)
    }

    let M: Int = inputInt(placeholder: "M") //3
    var arrayM: [Int] = [Int]() //[4,3,2]
    print("Введите по очереди значения для arrayM:")
    Array(1...M).forEach { item in
        let input: Int = inputInt(silence: true)
        arrayM.append(input)
    }

    let resultArrDict: [Bool] = arrayN.map { item in arrayM.contains(item) }

    let resultArr: [Int] = arrayN.enumerated().reduce(into: []) { result, item in
        if (resultArrDict[item.offset]) {
            result.append(item.element)
        }
    }

    print("Ответ:")
    print(resultArr)
}

func executeExercise(number: Int) -> Void {
    switch number {
    case 1:
        exercise1()
        break
    case 2:
        exercise2()
        break
    case 3:
        exercise3()
        break
    case 4:
        exercise4()
        break
    case 5:
        exercise5()
        break
    default:
        print("Такого задания не существует")
    }
}

executeExercise(number: exercise)
