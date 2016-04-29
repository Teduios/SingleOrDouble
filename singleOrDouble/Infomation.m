//
//  Infomation.m
//  singleOrDouble
//
//  Created by tarena on 16/3/25.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "Infomation.h"
#import <UIKit/UIKit.h>
@implementation Infomation
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeObject:_sex forKey:@"sex"];
    [aCoder encodeObject:_xz forKey:@"xz"];
    [aCoder encodeObject:_start forKey:@"start"];
    [aCoder encodeObject:_bithday forKey:@"bithday"];
    [aCoder encodeObject:_height forKey:@"height"];
    [aCoder encodeObject:_weight forKey:@"weight"];
    [aCoder encodeObject:_favo forKey:@"favo"];
    [aCoder encodeObject:_talented forKey:@"talented"];
    [aCoder encodeObject:_header forKey:@"header"];
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self=[super init];
    if (self) {
        _name=[aDecoder decodeObjectForKey:@"name"];
        _sex=[aDecoder decodeObjectForKey:@"sex"];
        _xz=[aDecoder decodeObjectForKey:@"xz"];
        _start=[aDecoder decodeObjectForKey:@"start"];
        _bithday=[aDecoder decodeObjectForKey:@"bithday"];
        _height=[aDecoder decodeObjectForKey:@"height"];
        _weight=[aDecoder decodeObjectForKey:@"weight"];
        _favo=[aDecoder decodeObjectForKey:@"favo"];
        _talented=[aDecoder decodeObjectForKey:@"talented"];
        _header=[aDecoder decodeObjectForKey:@"header"];
    }
    return self;
}

//@property(nonatomic,strong)NSString *name;
//@property(nonatomic,strong)NSString *sex;
//@property(nonatomic,strong)NSString *xz;
//@property(nonatomic,strong)NSString *start;
//@property(nonatomic,strong)NSString *bithday;
//@property(nonatomic,strong)NSString *height;
//@property(nonatomic,strong)NSString *weight;
//@property(nonatomic,strong)NSString *favo;
//@property(nonatomic,strong)NSString *talented;
@end
