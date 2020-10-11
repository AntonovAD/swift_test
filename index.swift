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

func exercise1(_ N: Int, _ M: Int, _ X: Int, _ Y: Int) -> Void {
    let longerSide: Int = N>M ? N : M
    let shorterSide: Int = N>M ? M : N
    let diffToLongerSide: Int = shorterSide-X
    let leftToLongerSide: Int = diffToLongerSide<X ? diffToLongerSide : X
    let diffToShorterSide: Int = longerSide-Y
    let leftToShorterSide: Int = diffToShorterSide<Y ? diffToShorterSide : Y

    let needToAlive: Int = leftToShorterSide<leftToLongerSide ? leftToShorterSide : leftToLongerSide

    print("Ответ:")
    print(needToAlive)
}

func exercise2(_ S: Int, _ V: Int, _ T: Int) -> Void {
    let dirForward: Bool = V>0

    let completeLength: Int = V*T
    let lap: Int = dirForward ? Int(ceil(Double(completeLength/S))) : Int(floor(Double(completeLength/S)))
    let lapLength: Int = dirForward ? S*(lap-1) : S*lap

    let marker: Int = completeLength-lapLength

    print("Ответ:")
    print(marker)
}

func exercise3(_ N: Int, _ array: [Int]) -> Void {
    let resultDict: [Int:(index: Int, count: Int)] = array.enumerated().reduce(into: [:]) { result, item in
        if (Mirror(reflecting: result[item.element]!).children.count>0) {
            result[item.element]?.count += 1
        } else {
            result[item.element] = (
                index: item.offset,
                count: 1
            )
        }
    }

    let uniqItems: [Int: Int] = resultDict.enumerated().reduce(into: [:]) { result, item in
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
    print(uniqItemsSorted.map {$0.value})
}

func exercise4(_ randomString: String) -> Void {
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

func exercise5(_ N: Int, _ arrayN: [Int], _ M: Int, _ arrayM: [Int]) -> Void {
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
        let N: Int, M: Int, X: Int, Y: Int
        if CommandLine.arguments.count == 1 {
            N = inputInt(placeholder: "N") //23
            M = inputInt(placeholder: "M") //52
            X = inputInt(placeholder: "X") //8
            Y = inputInt(placeholder: "Y") //43
        } else {
            N = Int(CommandLine.arguments[2])!
            M = Int(CommandLine.arguments[3])!
            X = Int(CommandLine.arguments[4])!
            Y = Int(CommandLine.arguments[5])!
        }
        exercise1(N, M, X, Y) //8
        break
    case 2:
        let S: Int, V: Int, T: Int
        if CommandLine.arguments.count == 1 {
            S = inputInt(placeholder: "S") //109
            V = inputInt(placeholder: "V") //60
            T = inputInt(placeholder: "T") //2
        } else {
            S = Int(CommandLine.arguments[2])!
            V = Int(CommandLine.arguments[3])!
            T = Int(CommandLine.arguments[4])!
        }
        exercise2(S, V, T) //120
        break
    case 3:
        let N: Int
        var array: [Int] = [Int]()
        if CommandLine.arguments.count == 1 {
            N = inputInt(placeholder: "N") //8
            array = [Int]() //[4, 3, 5, 2, 5, 1, 3, 5]
            print("Введите по очереди значения для array:")
            Array(1...N).forEach { item in
                let input: Int = inputInt(silence: true)
                array.append(input)
            }
        } else {
            N = Int(CommandLine.arguments[2])!
            Array(3...N+2).forEach { item in
                let arg: Int = Int(CommandLine.arguments[item])!
                array.append(arg)
            }
        }
        exercise3(N, array) //[4, 2, 1]
        break
    case 4:
        let randomString: String
        if CommandLine.arguments.count == 1 {
            randomString = inputString(placeholder: "ip") //"127.0.0.1"
        } else {
            randomString = CommandLine.arguments[2]
        }
        exercise4(randomString)
        break
    case 5:
        let N: Int, M: Int
        var arrayN: [Int] = [Int](), arrayM: [Int] = [Int]()
        if CommandLine.arguments.count == 1 {
            N = inputInt(placeholder: "N") //3
            arrayN = [Int]() //[1,3,2]
            print("Введите по очереди значения для arrayN:")
            Array(1...N).forEach { item in
                let input: Int = inputInt(silence: true)
                arrayN.append(input)
            }

            M = inputInt(placeholder: "M") //3
            arrayM = [Int]() //[4,3,2]
            print("Введите по очереди значения для arrayM:")
            Array(1...M).forEach { item in
                let input: Int = inputInt(silence: true)
                arrayM.append(input)
            }
        } else {
            N = Int(CommandLine.arguments[2])!
            Array(3...N+2).forEach { item in
                let arg: Int = Int(CommandLine.arguments[item])!
                arrayN.append(arg)
            }

            M = Int(CommandLine.arguments[N+3])!
            Array(N+4...M+6).forEach { item in
                let arg: Int = Int(CommandLine.arguments[item])!
                arrayM.append(arg)
            }
        }
        exercise5(N, arrayN, M, arrayM) //[3, 2]
        break
    default:
        print("Такого задания не существует")
    }
}

executeExercise(number: exercise)
