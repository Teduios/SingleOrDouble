//
//  TaskDetail.h
//  singleOrDouble
//
//  Created by tarena on 16/3/30.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TaskDetail : NSObject<NSCoding>
@property(nonatomic,strong)UIImage *image;
@property(nonatomic,strong)NSString *detail;
@property(nonatomic,strong)NSString *finishDate;
@end
