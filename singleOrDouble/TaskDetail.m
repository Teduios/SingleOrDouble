//
//  TaskDetail.m
//  singleOrDouble
//
//  Created by tarena on 16/3/30.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "TaskDetail.h"

@implementation TaskDetail
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_image forKey:@"image"];
    [aCoder encodeObject:_finishDate forKey:@"date"];
    [aCoder encodeObject:_detail forKey:@"detail"];
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self=[super init]) {
        _image=[aDecoder decodeObjectForKey:@"image"];
        _detail=[aDecoder decodeObjectForKey:@"detail"];
        _finishDate=[aDecoder decodeObjectForKey:@"date"];
    }
    return self;
}

@end
