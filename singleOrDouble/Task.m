//
//  Task.m
//  singleOrDouble
//
//  Created by tarena on 16/3/17.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "Task.h"

@implementation Task

+(NSArray*)startTasks{
    Task *task=[[Task alloc]init];
    task.task=@"一起养只小动物";
    Task *task1=[[Task alloc]init];
    task1.task=@"一起出去旅游";
    Task *task2=[[Task alloc]init];
    task2.task=@"一起通宵";
    Task *task3=[[Task alloc]init];
    task3.task=@"一起养小植物";
//    Task *task4=[[Task alloc]init];
//    task4.task=@"一个人出去旅游";
//    NSArray *array=@[]
//    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"task.data"];
//    [NSKeyedArchiver archiveRootObject:self  toFile:filePath];
    return @[task,task2,task1,task3];
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_task forKey:@"task"];
    [aCoder encodeObject:_taskDetail forKey:@"taskDetail"];
    [aCoder encodeBool:_isFinished forKey:@"isFinished"];
    [aCoder encodeBool:_isMarked forKey:@"isMarked"];
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self=[super init];
    if (self) {
        _task=[aDecoder decodeObjectForKey:@"task"];
        _taskDetail=[aDecoder decodeObjectForKey:@"taskDetail"];
        _isFinished=[aDecoder decodeBoolForKey:@"isFinished"];
        _isMarked=[aDecoder decodeBoolForKey:@"isMarked"];
    }
    return self;
}

@end
