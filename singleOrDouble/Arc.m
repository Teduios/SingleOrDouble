//
//  Arc.m
//  singleOrDouble
//
//  Created by tarena on 16/3/15.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "Arc.h"

@implementation Arc


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CALayer *layer=self.layer;
    layer.cornerRadius=self.bounds.size.width/2;
    layer.backgroundColor=[UIColor whiteColor].CGColor;
    layer.masksToBounds=YES;
    CGPoint center=CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    UIBezierPath *path=[UIBezierPath bezierPathWithArcCenter:center radius:self.bounds.size.width/2-6 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    [[UIColor colorWithRed:254/255.0 green:222/255.0 blue:121/255.0 alpha:0.7]setStroke];
    path.lineWidth=2.5;
    [path stroke];
    
    UIBezierPath *path2=[UIBezierPath bezierPath];
    [path2 moveToPoint:CGPointMake(center.x-12, center.y)];
    [path2 addLineToPoint:CGPointMake(center.x+12, center.y)];
    
    [path2 moveToPoint:CGPointMake(center.x, center.y-12)];
    [path2 addLineToPoint:CGPointMake(center.x, center.y+12)];
    
    [[UIColor colorWithRed:230/255.0 green:115/255.0 blue:91/255.0 alpha:1]setStroke];
    path2.lineWidth=2;
    [path2 stroke];
}


@end
