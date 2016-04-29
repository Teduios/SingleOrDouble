//
//  RightViewController.h
//  singleOrDouble
//
//  Created by tarena on 16/3/16.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^FinshThings_Count)(NSInteger);
@interface RightViewController : UIViewController
@property(nonatomic,strong)FinshThings_Count finshCountBlock1;
@end
