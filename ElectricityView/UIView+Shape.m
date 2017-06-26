//
//  UIView+Shape.m
//  BatteryElectricity
//
//  Created by 666gps on 2017/6/26.
//  Copyright © 2017年 666gps. All rights reserved.
//

#import "UIView+Shape.h"

@implementation UIView (Shape)

-(void)setShape:(CGPathRef)shape{
    if (shape == nil)
    {
        self.layer.mask = nil;
    }
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = shape;
    self.layer.mask = maskLayer;
}

@end
