//
//  Infomation.h
//  singleOrDouble
//
//  Created by tarena on 16/3/25.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Infomation : NSObject<NSCoding>
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *sex;
@property(nonatomic,strong)NSString *xz;
@property(nonatomic,strong)NSString *start;
@property(nonatomic,strong)NSString *bithday;
@property(nonatomic,strong)NSString *height;
@property(nonatomic,strong)NSString *weight;
@property(nonatomic,strong)NSString *favo;
@property(nonatomic,strong)NSString *talented;
@property(nonatomic,strong)UIImage *header;
//+(Infomation*)infomationWothNSArray:(NSArray*)arr;
@end
