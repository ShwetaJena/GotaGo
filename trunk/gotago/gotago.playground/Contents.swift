//: Playground - noun: a place where people can play

import UIKit

var myVar = 42
myVar = 50
let myConst = 75

let implicitInteger = 70
let implicitDouble = 70.0
let explicitDouble: Double = 70

let label = "Gotago"
let width = 100
let widthLabel = label + String(width)

let apple = 5
let orange = 20
let appleSummary = "I have \(apple) Apples"
let orangeSummary = "I have \(orange) Oranges"

let optionalInt: Int? = 9
let actualInt: Int = optionalInt!

var myString = "7"
var possibleInt = Int(myString)
print(possibleInt)


var ratingList = ["poor", "average", "good", "excellent"]
ratingList[1]
ratingList

var greeting = "Hello!"
var optionalName: String? = "John Appleseed"
var optionalHello: String? = "Hello"
if let hello = optionalHello where hello.hasPrefix("H"), let name = optionalName {
    greeting = "\(hello), \(name)"
}

func greet(name: String, day: String) -> String {
    return "Hello \(name), today is \(day)."
}

greet("Atin", day: "Monday")
greet("Jai", day: "Sunday")





