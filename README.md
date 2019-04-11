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
   

### Key points in demo9 *Grand Central Dispatch*
1. `DispatchQueue.global().async` to perform long-running operation on the background thread
2. `DispatchQueue.main.async` to get back to foreground thread to update user interface
   ![](http://i63.tinypic.com/2nv8eao.png)
   ![](http://i65.tinypic.com/i76flj.png)
   
   
### Key points in demo10 *Names To Faces*
1. `UICollectionView`: showing cells in grid
2. `fatalError(message: String)` always causes a crash, so we can use it to escape from a method that has a return value without sending anything back
3. Optional Typecasting: to tell Swift that an object it thought was type A is actually type E. When dequeueing a custom collectionview cell we need to typecast it to our specific type.
4. `UIImagePickerController`:
    1. Property: `allowsEditing`  set the allowsEditing property to be true, which allows the user to crop the picture they select
    2. delegate
5. `UUID`
6. ⚠️为什么创建一个继承自NSObject类的Person类 还自定义了构造方法 却不使用struct(本身就自带默认的`memberwise initializer`, 解释见demo12)
7. ⚠️重新运行后之前显示的图片消失 页面为空(涉及数据持久化存储 见demo12)

### Key points in demo11 *Pachinko*
1. `SpriteKit`: Apple's fast and easy toolkit designed specifically for 2D games. It includes sprites, fonts, physics, particle effects and more, and it's built into every iOS device.
2. Anchor point: “position me based on my center”, whereas UIKit positions things based on their top-left corner
3. `SKSpriteNode`: to load any picture from your app bundle just like UIImage
4. Data type: `Set`, just like an array, except each object can appear only once: touchsBegan方法中返回的touches数组就是Set类型
5. `Int.random(in:)` to get a random integer
6. `CGFloat.random(in:)` to get a random cgfloat number

### Key points in demo12 *UserDefaults* via NSCoding & Codable
1. structs: all basic data type are structs, ie Int, Float, Bool, String, Array, Dictionary, Date (In swift, strings, arrays and dictionaries are all structs, not objects) ???
2. `UserDefaults`: 
    1. Function:
        1. it can be used to store any basic data type: Int, Float, Bool, String, URL, along with complex type: Array, Dictionary, Data
        2. But if u want to store custom type data(such as a custom class, or a struct), you should convert it into Data first, then use UserDefaults to store
    2. Method 1: `NSCoding`
        1. Make your custom Class (Struct is not allow here, cuz struct is not allowed to conform to NSCoding protocol) conform to NSCoding protocol (实现两个协议方法: to encode and decode your data)
        2. Convert your custom Class to Data by using NSKeyedArchiver
        3. Then you can store your data via UserDefaults
    3. Method 2: `Codable`
        1. Make your custom Class / Struct conform to Codable protocol (no more methods to be implemented)
        2. Convert your custom Class / Struct into Data by using JSONEncoder
        3. Then you can store your data via UserDefaults
    4. Difference between `NSCoding` and `Codable`
        1. NSCoding can only be used onto custom Class (not Struct)
        2. Codable can be used onto both custom Class and Struct 
        ![](http://i63.tinypic.com/121x2cx.png)
3. In `UserDefaults`, use `object(forKey: )` and `as?` to get an optional object, then use `??` to either unwrap the object or set a default value, all in one line. 
![](http://i64.tinypic.com/zva1pf.png)
4. `NSCoder`: is responsible for both encoding(writing) and decoding(reading) your data so that it can be used with UserDefaults
5. keyword: `required` in NSCoder init method means: is anyone tried to subclass this class, they are required to implement this method
6. 总结:???
    1. swift里的基本数据类型int float string array dictionary本质都是struct
    2. 而且这些基本数据类型(包括很多系统的类, 如UIColor, UIImage等)都默认遵守NSCoding协议
    3. 但是struct类型并不默认遵守NSCoding协议 且也不能遵守NSCoding协议
    4. 因此如果想将自定义数据通过UserDefaults方式保存, 需要定义成类 而不是结构体


### Key points in Demo13 *Instafilter*
1. `Auto Layout`: Reset To Suggested Constraints
2. `Core Image`: apply filters to images
    1. Two important classes:
        1. `CIContext`: a component from CoreImage that handles rendering
        2. `CIFilter`: 图片渲染器
    2. How to render a image 
        1. 实例化一个`CIFilter`类的对象(渲染器) 设置渲染方式
        2. 将需要被渲染的图片转成`CIImage`对象, 并设置给渲染器
        3. 执行渲染:
            1. 将slider的值设置给不同渲染器对应的key
            2. 从渲染器中获取图片(`outputImage`)
            3. 将图片交给`CIContext`对象进行渲染: 将返回的`CGImage`对象转成`UIImage`对象并设置给`UIImageView`
![](http://i66.tinypic.com/vzkhox.png)
![](http://i64.tinypic.com/25kr6du.png)
3. `UIImageWriteToSavedPhotosAlbum()` 保存图片到相册 (截图)
    1. `Selector`中方法参数书写格式: 只需要保存形参(外不用参数), 不需要体现实参(内部用参数)
    2. `Error`: Swift中的Error是一个协议(不是类), 可以通过`localizedDescription`属性打印错误信息
![](http://i65.tinypic.com/213ozsp.png)
