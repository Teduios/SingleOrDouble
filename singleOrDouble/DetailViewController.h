//
//  DetailViewController.h
//  singleOrDouble
//
//  Created by tarena on 16/3/17.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskDetail.h"
@interface DetailViewController : UIViewController
@property(nonatomic,strong)NSString *labelName;
@property(nonatomic,assign)BOOL isMarked;
@property(nonatomic,strong)NSString *name;
@end
