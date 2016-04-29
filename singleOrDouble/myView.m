//
//  myView.m
//  singleOrDouble
//
//  Created by tarena on 16/3/14.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "myView.h"

@implementation myView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    UIBezierPath *path=[UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:5];
    [[UIColor colorWithRed:230/255.0 green:115/255.0 blue:91/255.0 alpha:1]setStroke];
    [[UIColor colorWithRed:230/255.0 green:115/255.0 blue:91/255.0 alpha:1]setFill];
    [path fill];
    [path stroke];
}


@end
