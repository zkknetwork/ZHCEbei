//////////////////////////////////////// 茶信 //////////////////////////////////////////////




//////////////////////以下私有／／／／／／／／／／／／／／／／
//通知中心

//单例


#pragma mark 通用
//////////////////////////////////////// 通用 //////////////////////////////////////////////
//快速的查看一段代码的执行时间
#define TICK NSDate *startTime = [NSDate date]
#define TOCK NSLog(@"Time: %f", -[startTime timeIntervalSinceNow])

//日志输出宏定义
#ifdef DEBUG
#define MyLog(...) NSLog(@"%s %@", __PRETTY_FUNCTION__,[NSString stringWithFormat:__VA_ARGS__])//NSLog(__VA_ARGS__)
#else
#define MyLog(...)
#endif

//颜色获取
#define kGetColorFromRGB(x,y,z,a) [UIColor colorWithRed:x/255.0 green:y/255.0 blue:z/255.0 alpha:a]
#define kGetColorFromHex(_f, _a)  [UIColor colorWithRed:((float)((_f & 0xFF0000) >> 16))/255.0 \
green:((float)((_f & 0xFF00)    >> 8))/255.0 \
blue:((float) (_f & 0xFF)           )/255.0 \
alpha:(_a)]

#define kBlackColor         [UIColor blackColor]
#define kDarkGrayColor      [UIColor darkGrayColor]
#define kLightGrayColor     [UIColor lightGrayColor]
#define kWhiteColor         [UIColor whiteColor]
#define kGrayColor          [UIColor grayColor]
#define kGreenColor         [UIColor greenColor]
#define kBlueColor          [UIColor blueColor]
#define kYellowColor        [UIColor yellowColor]
#define kMagentaColor       [UIColor magentaColor]
#define kOrangeColor        [UIColor orangeColor]
#define kPurpleColor        [UIColor purpleColor]
#define kBrownColor         [UIColor brownColor]
#define kClearColor         [UIColor clearColor]
#define kRedColor           [UIColor redColor]

// 屏幕frame
#define kApplicationFrame   [UIScreen mainScreen].applicationFrame
#define kScreenWidth        [UIScreen mainScreen].bounds.size.width
#define kScreenHeight       [UIScreen mainScreen].bounds.size.height


// 常用类
#define kUserDefaults       [NSUserDefaults standardUserDefaults]
#define kNotificationCenter [NSNotificationCenter defaultCenter]
#define kApplication        [UIApplication sharedApplication]
#define kAppDelegate        (AppDelegate *)[[UIApplication sharedApplication] delegate]
#define kFileManager        [NSFileManager defaultManager]
#define kInfoDict           [[NSBundle mainBundle]infoDictionary]
#define kMainBundle         [NSBundle mainBundle]

// 设备判断
#define IsIOS7OrLater       ([[[UIDevice currentDevice] systemVersion] floatValue] >=7.0 ? YES : NO)
#define IsIOS5              (([[[UIDevice currentDevice] systemVersion] floatValue] >=5.0 && [[[UIDevice currentDevice] systemVersion] floatValue] < 6.0) ? YES : NO)
#define IsiPhone5           ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

// 文件夹
#define kDocDir             [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject]
// 每个用户自己的存储文件夹,用到了userId，所以必须在登录后使用
#define kAccountFile        [kDocDir stringByAppendingPathComponent:[Base64 stringByEncodingData:[kMyProfileTool.userId dataUsingEncoding:NSStringEncodingConversionAllowLossy]]]
// 用户头像
#define kHeadImageFile      [kAccountFile stringByAppendingPathComponent:[NSString stringWithFormat:@"head.png"]]

// 软件版本
#define kBundleVersionKey   @"CFBundleShortVersionString"
#define kBundleBuildKey     (NSString *)kCFBundleVersionKey

// 控件的tag初始值
#define kStartTag 100

// block self
#define WEAKSELF typeof(self) __weak weakSelf = self;
#define STRONGSELF typeof(weakSelf) __strong strongSelf = weakSelf;


//字体大小
#define ShareFont        [UIFont fontWithName:@"Helvetica-Bold" size:20]
#define HeiTiFont(_size) [UIFont fontWithName:@"STHeitiSC-Medium" size:_size]
//setImage
#define ImageNamed(_name)     [UIImage imageNamed:_name]
//******本地读取图片
#define  App_ContentFile(aFileName,aFileType) [[NSBundle mainBundle]pathForResource:aFileName ofType:aFileType]


typedef void (^BtnClickedBlock)(UIButton *btn);
typedef void (^VoidBlock) ();
typedef void (^OneObjBlock) (id obj);
typedef void (^TwoObjBlock) (id obj0,id obj1);
typedef void (^ThreeObjBlock) (id obj0,id obj1,id obj2);

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
//////////////////////////////////////// 通用 //////////////////////////////////////////////
