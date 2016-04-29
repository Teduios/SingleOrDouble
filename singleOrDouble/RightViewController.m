//
//  RightViewController.m
//  singleOrDouble
//
//  Created by tarena on 16/3/16.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "RightViewController.h"
#import "RightTableViewCell.h"
#import "Task.h"
#import "DetailViewController.h"
@interface RightViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *swipe;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *finshiTingsLabel;
@property(assign,nonatomic)NSInteger allFinshedThingsCount;
@property (weak, nonatomic) IBOutlet UILabel *notFinishTingsLabel;
@property(nonatomic,strong)NSMutableArray *allTasks;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation RightViewController
#pragma mark - lazy load
-(NSMutableArray *)allTasks{
    
    if (!_allTasks) {
        NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"task.data"];
         NSMutableArray *allTasks=[NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        if (allTasks==nil) {
            _allTasks=[[Task startTasks]mutableCopy];
        }else{
            _allTasks=allTasks;
        }
    }
    return _allTasks;
}
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.swipe.direction=UISwipeGestureRecognizerDirectionRight;
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"711"]]];
     self.tableView.backgroundColor = [UIColor clearColor];
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    NSInteger i=[userDefaults integerForKey:@"finshedThingsCount"];
    if (!i) {
        self.allFinshedThingsCount=0;
    }
    self.allFinshedThingsCount=i;
    self.finshiTingsLabel.text=[NSString stringWithFormat:@"%ld",(long)self.allFinshedThingsCount];
    self.notFinishTingsLabel.text=[NSString stringWithFormat:@"%lu",self.allTasks.count-self.allFinshedThingsCount];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)swipe:(UISwipeGestureRecognizer*)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        self.finshCountBlock1(self.allFinshedThingsCount);
    }];
}

- (IBAction)add {
    [self.textField becomeFirstResponder];
}

#pragma mark 3 1
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.allTasks.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RightTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath:indexPath];
    
    Task *task=self.allTasks[indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    cell.selected = task.isFinished;

    cell.finshCountBlock=^(BOOL isSelected){
        if (isSelected) {
            self.allFinshedThingsCount=self.allFinshedThingsCount+=1;
        }else{
            self.allFinshedThingsCount=self.allFinshedThingsCount-=1;
        }
        self.finshiTingsLabel.text=[NSString stringWithFormat:@"%ld",(long)self.allFinshedThingsCount];
        self.notFinishTingsLabel.text=[NSString stringWithFormat:@"%lu",self.allTasks.count-self.allFinshedThingsCount];
        NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
        [userDefaults setInteger:self.allFinshedThingsCount forKey:@"finshedThingsCount"];
        task.isFinished=isSelected;
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"task.data"];
        [NSKeyedArchiver archiveRootObject:self.allTasks toFile:filePath];  
        });
        
    };
    cell.markBlock=^(BOOL isMarked){
        task.isMarked=isMarked;
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
         NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"task.data"];
        [NSKeyedArchiver archiveRootObject:self.allTasks toFile:filePath];   
        });
    };
    cell.mytextLabel.text=task.task;
    cell.clickButton.selected=task.isFinished;
    cell.markedButton.selected=task.isMarked;
    if (task.isMarked) {
        cell.markedImageView.image=[UIImage imageNamed:@"mark"];
    }
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self performSegueWithIdentifier:@"goDetail" sender:indexPath];
}
#pragma mark - 跳转
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(NSIndexPath*)sender{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        RightTableViewCell *cell=[self.tableView cellForRowAtIndexPath:sender];
        DetailViewController *detailVC=segue.destinationViewController;
        detailVC.modalTransitionStyle=2;
        detailVC.labelName=cell.mytextLabel.text;
        detailVC.isMarked=cell.markedButton.selected;
        Task *task=self.allTasks[sender.row];
        detailVC.name=task.task;
    });
}

- (IBAction)addTask:(UITextField *)sender {
    if (sender.text.length!=0) {
        Task *task=[[Task alloc]init];
        task.task=sender.text;
        [self.allTasks addObject:task];
        
        [self.tableView reloadData];
        self.notFinishTingsLabel.text=[NSString stringWithFormat:@"%lu",self.allTasks.count-self.allFinshedThingsCount];
    }
    sender.text=@"";
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"task.data"];
    [NSKeyedArchiver archiveRootObject:self.allTasks toFile:filePath];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self reloadTasks:indexPath];
    [self.allTasks removeObjectAtIndex:indexPath.row];
     self.notFinishTingsLabel.text=[NSString stringWithFormat:@"%lu",self.allTasks.count-self.allFinshedThingsCount];

    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"task.data"];
        [NSKeyedArchiver archiveRootObject:self.allTasks toFile:filePath];
    });
    
    
}

-(void)reloadTasks:(NSIndexPath *)indexPath{
    Task *task=self.allTasks[indexPath.row];

    if (task.isFinished) {
        self.allFinshedThingsCount=self.allFinshedThingsCount-1;
    }
    self.finshiTingsLabel.text=[NSString stringWithFormat:@"%ld",(long)self.allFinshedThingsCount];
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
     dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [userDefaults setInteger:self.allFinshedThingsCount forKey:@"finshedThingsCount"];
    });
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *path=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@image.data",task.task]];
        NSFileManager *fm=[NSFileManager defaultManager];
        path=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@date.data",task.task]];
        [fm removeItemAtPath:path error:nil];
        path=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@detail.data",task.task]];
        [fm removeItemAtPath:path error:nil];
    });
}


@end
