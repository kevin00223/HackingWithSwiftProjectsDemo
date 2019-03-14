# HackingWithSwiftProjectsDemo

### key points in demo1 *StormViewer*
1. Load image resource from main bundle
2. Optional unwrapping via `if let`
3. Optional chaining: try doing this, but do nothing if there is a problem
4. Array sorting


### key points in demo2 *GuessTheFlag*
1. implicitly unwrapping optionals (IBOutlet)
2. Relation between point and pixel
3. CALayer
4. To shuffle up the order of an array: `array.shuffle`
5. To generate a random number in a range: `Int.random(in: range)`
￼￼￼

![](http://i63.tinypic.com/24x2mva.jpg)

![](http://i67.tinypic.com/2zz2gpk.png)

### key points in demo3 *SocialMedia*
1. Keyword: `@objc`
   ![](http://i64.tinypic.com/2yl7l0o.png)
2. UIActivityViewController
3. Privacy setting from `info.plist`
4. Difference between `if let` and `guard let`


### key points in demo4 *EasyBrowser*
1. loadView
2. WKWebview
3. Delegation
4. KVO: `#keyPath` / UIProgressView
5. toolbarItems
6. Escaping closure!!!


### key points in demo5 *WordScramble*
1. `Bundle.main.url(forResource: , withExtension: )` 通过文件名+文件后缀 获取资源路径
2. `String(contentOf: )`  loading a file into a string
3. Difference between isEmpty and count == 0
   ![](https://s2.ax1x.com/2019/03/05/kX6YGD.png)
4. Trailing closure:  the structure of a closure: trailing closure syntax, unowned self, a parameter being passed in, then the need for `self.` to make capturing clear
   ![](https://s2.ax1x.com/2019/03/05/kX6yi8.png)
5. reference cycle:
   ![](https://s2.ax1x.com/2019/03/05/kX6wqI.png)
6. keyword: `return`  The return keyword exits a method at any time it's used. If you use return by itself, it exits the method and does nothing else. But if you use return with a value, it sends that value back to whatever called the method
7. `UITextChecker`: a class to spot spelling errors, which makes it perfect for knowing if a given word is real or not
8. Utf16: 
   ![](https://s2.ax1x.com/2019/03/05/kX6BZt.png)
   
   
### key points in demo6 *Auto Layout*
passed
1. `translatesAutoresizingMaskIntoConstraints`: by default iOS generates Auto Layout constraints for you based on a view's size and position. Set this property to be false to disable this feature so that we can set the constraints by ourselves.


### key points in demo7 *Whitehouse Petitions*
1. `Codable` protocol
   ![](https://s2.ax1x.com/2019/03/07/kxaW7T.png)
2. `struct`: default memberwise initializer, 替代OC中model的作用
3. `Data(contentOf: )` : convert file of JSON into data
4. JSON parsing
5. Unwrap variables using the same name 
   ![](https://s2.ax1x.com/2019/03/07/kxahAU.png)


### Key points in demo8 *Swifty Words*
1. grid view
2. `components(separatedBy:)` to split text into an array
3. `joined(separator:)` this makes an array into a single string, with each array element separated by the string specified in its parameter
4. `replacingOccurrences()` we're asking it to replace all instances of | with an empty string, so HA|UNT|ED will become HAUNTED
5. `enumerated()` to loop over an array, and it passes you each object from the array, as well as that object's position in the array
6. Property observer: `didSet`, is code that gets run when their property changes or is about to change(`willSet`)
   ![](http://i65.tinypic.com/iftxxi.png)
