//
//  Task.h
//  singleOrDouble
//
//  Created by tarena on 16/3/17.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TaskDetail.h"
@interface Task : NSObject<NSCoding>
@property(nonatomic,strong)NSString *task;
//@property(nonatomic,strong)NSString *taskDetail;
@property(nonatomic,assign)BOOL isFinished;
@property(nonatomic,assign)BOOL isMarked;
@property(nonatomic,strong)NSString *taskPictureName;
@property(nonatomic,strong)TaskDetail *taskDetail;
+(NSArray*)startTasks;
@end
