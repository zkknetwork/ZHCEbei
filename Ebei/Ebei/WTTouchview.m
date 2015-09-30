//
//  WTTouchview.m
//  Ebei
//
//  Created by MAC on 15/9/23.
//  Copyright (c) 2015年 mac. All rights reserved.
//
#define degreesToRadinas(x) (M_PI * (x)/180.0)
#import "WTTouchview.h"

@implementation WTTouchview{
    int weiyix;
    int weiyiy;
    int weiyi;
    __weak IBOutlet UILabel *labenweiyi;
    __weak IBOutlet UILabel *labelb;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(WTTouchview *)sharedInstance
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"WTTouchview" owner:nil options:nil];
    return [nibView objectAtIndex:0];
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        //you init
        weiyix=0;
        weiyiy=0;
        weiyi=60;
        
        
    }
    return self;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{

    NSSet *allTouches = [event allTouches];    //返回与当前接收者有关的所有的触摸对象
    UITouch *touch = [allTouches anyObject];   //视图中的所有对象
    CGPoint point = [touch locationInView:[touch view]]; //返回触摸点在视图中的当前坐标
    int x = point.x;
    int y = point.y;
    weiyix=x;
    weiyiy=y;
  //  NSLog(@"1-touch (x, y) is (%d, %d)", x, y);

}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSSet *allTouches = [event allTouches];    //返回与当前接收者有关的所有的触摸对象
    UITouch *touch = [allTouches anyObject];   //视图中的所有对象
    CGPoint point = [touch locationInView:[touch view]]; //返回触摸点在视图中的当前坐标
    int x = point.x;
    int y = point.y;
   // NSLog(@"2-touch (x, y) is (%d, %d)", x, y);
    
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSSet *allTouches = [event allTouches];    //返回与当前接收者有关的所有的触摸对象
    UITouch *touch = [allTouches anyObject];   //视图中的所有对象
    CGPoint point = [touch locationInView:[touch view]]; //返回触摸点在视图中的当前坐标
    int x = point.x;
    int y = point.y;
   // NSLog(@"3-touch (x, y) is (%d, %d)", x, y);
   // NSLog(@"touchesEnded");
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSSet *allTouches = [event allTouches];    //返回与当前接收者有关的所有的触摸对象
    UITouch *touch = [allTouches anyObject];   //视图中的所有对象
    CGPoint point = [touch locationInView:[touch view]]; //返回触摸点在视图中的当前坐标
    CGPoint prePoint=[touch previousLocationInView:self.superview];
    CGPoint curPoint=[touch locationInView:self.superview];
    UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
    CGRect rect=[labenweiyi convertRect: labenweiyi.bounds toView:window];
     CGRect rect1=[labelb convertRect: labelb.bounds toView:window];
    int aa=rect.origin.x;
    int bb=rect1.origin.x;
    
    float angle=[self getAngleWithOrginPoint:self.center PointX:prePoint PointY:curPoint];


    CGAffineTransform transform1 =  self.transform;

    CGFloat rotate = acosf(transform1.a);
    //if (transform1.b < 0) {
        rotate+= M_PI;
  //  }
    CGFloat degree = rotate/M_PI * 180;
    NSLog(@"+++++++++ degree : %f", degree);
    CGAffineTransform newTransForm = CGAffineTransformRotate(transform1, angle);
    [self setTransform:newTransForm];
    CGFloat newRotate = acosf(newTransForm.a);
    if (newTransForm.b < 0) {
        newRotate+= M_PI;
        NSLog(@"%----");
    }
    CGFloat newDegree = newRotate/M_PI * 180;
    NSLog(@"+++++++++ newDegree : %f", newDegree);
  
    if (aa>bb) {

    self.shujv=[NSString stringWithFormat:@"%d",(int)newDegree/4];
    }
    else{
        self.shujv=[NSString stringWithFormat:@"%d",(180+360-(int)newDegree)/4];
    }
    //存储用户信息
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    [userDefaults setObject:self.shujv forKey:@"weight"];//用户体重
    
    [userDefaults synchronize];
    if (_delegate && [_delegate respondsToSelector:@selector(setWeight:)])
    {
        [self.delegate setWeight:self.shujv];
    }

    
//数据＝腰围
    NSLog(@"%@-%d",self.shujv);
  
}
-(float)getAngleWithOrginPoint:(CGPoint)aOrginPoint PointX:(CGPoint)aPointX PointY:(CGPoint)aPointY
{
    //得到pointX到原点的距离
    float xToOrgin=[self getDistanceFromPointX:aPointX toPointY:aOrginPoint];
    //得到pointX到原点的水平距离
    float xDistanceOnX=aPointX.x-aOrginPoint.x;
    //用反余弦函数得到pointX与水平线的夹角
    float xAngle=acos(xDistanceOnX/xToOrgin);
    
    
    //用同样的方法得到pointY与水平线的夹角
    float yToOrgin=[self getDistanceFromPointX:aPointY toPointY:aOrginPoint];
    float yDistanceOnX=aPointY.x-aOrginPoint.x;
    float yAngle=acos(yDistanceOnX/yToOrgin);
    float angle=xAngle-yAngle;
    
    return angle;
}
-(float)getDistanceFromPointX:(CGPoint)PointX toPointY:(CGPoint)PointY
{
    float xDis=PointX.x-PointY.x;
    float yDis=PointX.y-PointY.y;
    float distance=sqrtf(xDis*xDis+yDis*yDis);
    return distance;
}
@end
