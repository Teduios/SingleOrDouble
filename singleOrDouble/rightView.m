//
//  rightView.m
//  singleOrDouble
//
//  Created by tarena on 16/3/17.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "rightView.h"

@implementation rightView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    CALayer *layer=self.layer;
    layer.cornerRadius=self.bounds.size.width/2;
    layer.backgroundColor=[UIColor whiteColor].CGColor;
    layer.masksToBounds=YES;
//    CGPoint center=CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
//    UIBezierPath *path=[UIBezierPath bezierPathWithArcCenter:center radius:self.bounds.size.width/2-6 startAngle:0 endAngle:M_PI*2 clockwise:YES];
//    [[UIColor colorWithRed:254/255.0 green:222/255.0 blue:121/255.0 alpha:0.7]setStroke];
//    path.lineWidth=2.5;
//    [path stroke];
}


@end
