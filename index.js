console.log('Вариант 2');
console.log('Задание 1');
const N = 23;
const M = 52;
const X = 8;
const Y = 43;
console.log({
    N,M,X,Y
});

let longerSide, shorterSide;
if (N>M) {
    longerSide = N;
    shorterSide = M;
} else {
    longerSide = M;
    shorterSide = N;
}
const diffToLongerSide = shorterSide-X;
const leftToLongerSide = diffToLongerSide<X ? diffToLongerSide : X;
const diffToShorterSide = longerSide-Y;
const leftToShorterSide = diffToShorterSide<Y ? diffToShorterSide : Y;

const needToAlive = leftToShorterSide<leftToLongerSide ? leftToShorterSide : leftToLongerSide;

console.log({needToAlive});

console.log('Задание 2');
const S = 109;
const V = 60;
const T = 2;

console.log({
    S,V,T
});

const dirForward = V>0;

const completeLength = V*T;
const lap = dirForward ? Math.ceil(completeLength/S) : Math.floor(completeLength/S);
const lapLength = dirForward ? S*(lap-1) : S*lap;

const marker = completeLength-lapLength;

console.log({marker});

console.log('Задание 3');
const array = [4, 3, 5, 2, 5, 1, 3, 5];

console.log({
    N: array.length,
    array
});

const resultDict = array.reduce((result, item, index) => {
    if (Object.keys(result[item] || {}).length) {
        result[item] = {
            ...result[item],
            count: ++result[item].count
        };
    } else {
        result[item] = {
            index,
            count: 1,
        };
    }
    return result;
},{});

const uniqItems = Object.entries(resultDict).reduce((result, [key, value]) => {
    if (value.count === 1) result[value.index] = key;
    return result;
}, []).filter((item) => item);

console.log({uniqItems});

console.log('Задание 4');
const randomString = '127.0.0.1';

console.log({
    randomString
});

const mode = 'custom';

let validationResult;

if (mode === 'regexp') {
    const validationMask = RegExp(/^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/);

    validationResult = validationMask.test(randomString);
}

if (mode === 'custom') {
    validationResult = true;

    const splittedString = randomString.split('.');

    if (splittedString.length !== 4) {
        validationResult = false;
    } else {
        splittedString.forEach((item) => {
            const stringToInt = parseInt(item);

            if (isFinite(stringToInt)) {
                if (stringToInt <= 255 && stringToInt >= 0) {

                } else {
                    validationResult = false;
                }
            } else {
                validationResult = false;
            }
        });
    }
}

console.log({validationResult: validationResult ? 'YES' : 'NO'});

console.log('Задание 5');
const Narr = [1,3,2];
const Marr = [4,3,2];

console.log({
    Nn: Narr.length,
    N: Narr,
    Mn: Marr.length,
    M: Marr
});

const resultArrDict = Narr.map(item => Marr.includes(item));

const resultArr = Narr.reduce((result, item, index) => {
    if (resultArrDict[index]) {
        result.push(item);
    }
    return result;
}, []);

console.log({result: resultArr});
