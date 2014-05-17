//
//  CircleDrawerView.m
//  TestTableCustomDrawing
//
//  Created by Alexander on 15.05.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import "CircleDrawerView.h"


@implementation CircleDrawerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (UIImage*)verticalGradientWithColor1:(UIColor*)color1 color2:(UIColor*)color2
{
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGFloat r1, g1, b1, a1, r2, g2, b2, a2;
    [[UIColor colorWithRed:0.519 green:0.667 blue:0.434 alpha:1.000] getRed: &r1 green:&g1 blue:&b1 alpha:&a1];
    [[UIColor colorWithRed:0.399 green:0.619 blue:0.667 alpha:1.000] getRed: &r2 green:&g2 blue:&b2 alpha:&a2];
    CGFloat colors [] = {
        r1, g1, b1, a1,
        r2, g2, b2, a2
    };
    CGColorSpaceRef baseSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(baseSpace, colors, NULL, 2);
    CGColorSpaceRelease(baseSpace), baseSpace = NULL;
    
    CGContextDrawLinearGradient(context, gradient, CGPointMake(5, 0), CGPointMake(5, rect.size.height), 0);
    CGGradientRelease(gradient);
}

@end
