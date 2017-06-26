//
//  ElectricityView.m
//  BatteryElectricity
//
//  Created by 666gps on 2017/6/26.
//  Copyright © 2017年 666gps. All rights reserved.
//

#import "ElectricityView.h"
#import "UIView+Shape.h"


@implementation ElectricityView{
    
    CGFloat viewW;
    CGFloat viewH;
    CGFloat WaterMaxHeight;
    float _horizontal;
    float _horizontal2;
    float waterHeight;
    
    CAShapeLayer * ovalShapeLayer;
    UIView *dianliangView;
    UIView *dianliangView2;
    NSTimer *waterTimer;
    NSTimer *waterTimer2;
    UILabel *dianliangLbel;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        viewW = self.frame.size.width;
        viewH = self.frame.size.height;
        WaterMaxHeight = viewW - 40;
        self.backgroundColor = [UIColor whiteColor];
        [self creatBaseUI];
    }
    return self;
}
-(void)creatBaseUI{
//画外部图形
    UIView * circleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewW, viewW)];
    [self addSubview:circleView];
    circleView.layer.cornerRadius = viewW / 2;
    circleView.layer.masksToBounds = YES;
    circleView.backgroundColor = [UIColor clearColor];
    circleView.transform = CGAffineTransformMakeRotation(-M_PI_2);
    //  第一层浅白色的虚线圆
    CAShapeLayer * ovalLayer = [CAShapeLayer layer];
    ovalLayer.strokeColor = [UIColor yellowColor].CGColor;
    ovalLayer.fillColor = [UIColor clearColor].CGColor;
    ovalLayer.lineWidth = 10;
    ovalLayer.lineDashPattern  = @[@2,@6];
    ovalLayer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(5,5,2 * viewW / 2 - 10,2 * viewW / 2 - 10)].CGPath;
    [circleView.layer addSublayer:ovalLayer];
    // 第二层黄色的虚线圆 电量多少的
    ovalShapeLayer = [CAShapeLayer layer];
    ovalShapeLayer.strokeColor = [UIColor greenColor].CGColor;
    ovalShapeLayer.fillColor = [UIColor clearColor].CGColor;
    ovalShapeLayer.lineWidth = 10;
    ovalShapeLayer.lineDashPattern  = @[@2,@6];
    CGFloat refreshRadius = viewW / 2;
    ovalShapeLayer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(5,5,2 * refreshRadius-10,2 * refreshRadius-10)].CGPath;
    ovalShapeLayer.strokeEnd = 0;
    [circleView.layer addSublayer:ovalShapeLayer];
    // 白色实线的小圆圈
    CAShapeLayer * ocircleLayer = [CAShapeLayer layer];
    ocircleLayer.strokeColor = [UIColor yellowColor].CGColor;
    ocircleLayer.fillColor = [UIColor clearColor].CGColor;
    ocircleLayer.lineWidth = 1;
    ocircleLayer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(15,15,2 * viewW / 2 - 30,2 * viewW / 2 - 30)].CGPath;
    [circleView.layer addSublayer:ocircleLayer];

    UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(20, 20, viewW - 40, viewW - 40)];
    [self addSubview:backView];
    backView.layer.cornerRadius = (viewW - 40) / 2;
    backView.layer.masksToBounds = YES;
    backView.backgroundColor = [UIColor grayColor];

    /// 第一层水波纹view ===========================
    dianliangView = [[UIView alloc] initWithFrame:CGRectMake(20, 20, viewW - 40, viewW - 40)];
    [self addSubview:dianliangView];
    dianliangView.layer.cornerRadius = (viewW - 40) / 2;
    dianliangView.layer.masksToBounds = YES;
    dianliangView.backgroundColor = [UIColor colorWithRed:0.34 green:0.40 blue:0.71 alpha:0.80];
    /// 第二层水波纹 view =======================
    dianliangView2 = [[UIView alloc] initWithFrame:CGRectMake(20, 20, viewW - 40, viewW - 40)];
    [self addSubview:dianliangView2];
    dianliangView2.layer.cornerRadius = (viewW - 40) / 2;
    dianliangView2.layer.masksToBounds = YES;
    dianliangView2.backgroundColor = [UIColor colorWithRed:0.32 green:0.52 blue:0.82 alpha:0.60];
    ///
    dianliangLbel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20 + (viewW - 40) / 2 - 30, viewW - 40, 60)];
    [self addSubview:dianliangLbel];
    dianliangLbel.font = [UIFont systemFontOfSize:50];
    dianliangLbel.textAlignment = NSTextAlignmentCenter;
    dianliangLbel.textColor = [UIColor whiteColor];
    
    waterTimer = [NSTimer scheduledTimerWithTimeInterval:0.08 target:self selector:@selector(waterAction) userInfo:nil repeats:YES];
    waterTimer2 = [NSTimer scheduledTimerWithTimeInterval:0.10 target:self selector:@selector(waterAction2) userInfo:nil repeats:YES];
    [self showNumber];
}
- (void)waterAction{
    CGMutablePathRef wavePath = CGPathCreateMutable();
    CGPathMoveToPoint(wavePath, nil, 0,-WaterMaxHeight*0.5);
    float y = 0;
    _horizontal += 0.15;
    for (float x = 0; x <= dianliangView.frame.size.width; x++) {
        //峰高* sin(x * M_PI / self.frame.size.width * 峰的数量 + 移动速度)
        y = 7* sin(x * M_PI / dianliangView.frame.size.width * 2 - _horizontal) ;
        CGPathAddLineToPoint(wavePath, nil, x, y+waterHeight);
    }
    CGPathAddLineToPoint(wavePath, nil, dianliangView.frame.size.width , WaterMaxHeight*0.5);
    CGPathAddLineToPoint(wavePath, nil, dianliangView.frame.size.width, WaterMaxHeight);
    CGPathAddLineToPoint(wavePath, nil, 0, WaterMaxHeight);
    [dianliangView setShape:wavePath];
}

- (void)waterAction2{
    CGMutablePathRef wavePath2 = CGPathCreateMutable();
    CGPathMoveToPoint(wavePath2, nil, 0,-WaterMaxHeight*0.5);
    float y2 = 0;
    _horizontal2 += 0.1;
    for (float x2 = 0; x2 <= dianliangView2.frame.size.width; x2++) {
        //峰高* sin(x * M_PI / self.frame.size.width * 峰的数量 + 移动速度)
        y2 = -5* cos(x2 * M_PI / dianliangView2.frame.size.width * 2 + _horizontal2) ;
        CGPathAddLineToPoint(wavePath2, nil, x2, y2+waterHeight);
    }
    CGPathAddLineToPoint(wavePath2, nil, dianliangView2.frame.size.width , WaterMaxHeight*0.5);
    CGPathAddLineToPoint(wavePath2, nil, dianliangView2.frame.size.width, WaterMaxHeight);
    CGPathAddLineToPoint(wavePath2, nil, 0, WaterMaxHeight);
    [dianliangView2 setShape:wavePath2];
}
-(void)showNumber{
    ovalShapeLayer.strokeEnd = 0.56;
    waterHeight = (1 - 0.56) * (viewW - 40);
    dianliangLbel.text = [NSString stringWithFormat:@"56%@",@"%"];
}
-(void)endTimer{
    [waterTimer invalidate];
    [waterTimer2 invalidate];
    waterTimer = nil;
    waterTimer2 = nil;
}
@end
