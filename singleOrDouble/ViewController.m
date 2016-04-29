//
//  ViewController.m
//  singleOrDouble
//
//  Created by tarena on 16/3/12.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ViewController.h"
#import "Task.h"
#import "RightViewController.h"
#import "RESideMenu.h"
@interface ViewController ()<UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *singleOrDouble;
@property (weak, nonatomic) IBOutlet UILabel *single;
@property (weak, nonatomic) IBOutlet UIView *leftView;
@property (weak, nonatomic) IBOutlet UILabel *yearOrMonthLable;
@property (weak, nonatomic) IBOutlet UIView *ArcView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineTotopConstraint;
@property(nonatomic,assign)CGFloat topContraint;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *swipe;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *noteToTopContraint;
@property(nonatomic,assign)CGFloat topContraint1;
@property (weak, nonatomic) IBOutlet UILabel *singleLable;
@property (weak, nonatomic) IBOutlet UILabel *finishTingsCount;
@property (weak, nonatomic) IBOutlet UILabel *jian;
@property(nonatomic,assign)NSInteger i;
//@property (weak, nonatomic) IBOutlet UIButton *changeButton;
@property(nonatomic,strong)UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UILabel *daysLabel;
@property (nonatomic,assign) BOOL firstCome;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setMySingleLable];
    
//    [self.singleOrDouble addTarget:self action:@selector(change:) forControlEvents:UIControlEventTouchUpInside];
    
    UIPanGestureRecognizer *pan=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [self.view addGestureRecognizer:pan];
    self.topContraint=self.lineTotopConstraint.constant;
    self.topContraint1=self.noteToTopContraint.constant;
    pan.delegate=self;
    
    self.swipe.delegate=self;
    self.swipe.direction=UISwipeGestureRecognizerDirectionLeft;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSInteger i=[userDefaults integerForKey:@"finshedThingsCount"];
    self.i=i;
    self.finishTingsCount.text=[NSString stringWithFormat:@"%ld",(long)i];
    [self creatDatePicker];
    self.saveButton.alpha=0;
    NSObject *object=[userDefaults objectForKey:@"first"];
    BOOL isSingle = [userDefaults boolForKey:@"single"];
    if (!object) {
        [userDefaults setObject:@"1" forKey:@"first"];
        return;
    }
    [self isSingle:isSingle];
}


-(void)viewWillAppear:(BOOL)animated{
    [self leftViewAnimation];
}

- (IBAction)swipe:(UISwipeGestureRecognizer *)sender {
    RightViewController *rvc=[self.storyboard instantiateViewControllerWithIdentifier:@"rightVC"];
    rvc.modalTransitionStyle=1;
    rvc.finshCountBlock1=^(NSInteger i){
        self.finishTingsCount.text=[NSString stringWithFormat:@"%ld",(long)i];
        self.i=i;
    };
    [self presentViewController:rvc animated:YES completion:nil];
    
}


-(void)pan:(UIPanGestureRecognizer*)sender{
    CGPoint translation=[sender translationInView:self.view];
    if (translation.x<-20) {
        RightViewController *rvc=[self.storyboard instantiateViewControllerWithIdentifier:@"rightVC"];
        rvc.modalTransitionStyle=1;
        rvc.finshCountBlock1=^(NSInteger i){
            self.finishTingsCount.text=[NSString stringWithFormat:@"%ld",(long)i];
            self.i=i;
            NSLog(@"%@",self.finishTingsCount.text);
        };
        [self presentViewController:rvc animated:YES completion:nil];
    }
    
    if (0<translation.y) {
        if (translation.y<50) {
             self.lineTotopConstraint.constant=self.topContraint+translation.y;
            self.noteToTopContraint.constant=self.topContraint1+translation.y;
        }
        if (sender.state == UIGestureRecognizerStateEnded) {
            
            self.lineTotopConstraint.constant = self.topContraint;
            self.noteToTopContraint.constant=self.topContraint1;
            [UIView animateWithDuration:1 animations:^{
                [self.view layoutIfNeeded];
            }];
            [UIView animateWithDuration:0.5 animations:^{
                self.ArcView.transform=CGAffineTransformRotate(self.ArcView.transform, M_PI);
            } completion:^(BOOL finished) {
                if (translation.y>25) {
                    [self goInfomationVC];

                }
            }];
        }
    }
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return NO;
}




-(void)goInfomationVC{
    [self presentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"information"] animated:YES completion:^{
        
    }];
}

- (IBAction)goInfomationClick:(id)sender {
    [UIView animateWithDuration:0.5 animations:^{
        self.ArcView.transform=CGAffineTransformRotate(self.ArcView.transform, M_PI);
    } completion:^(BOOL finished) {
        [self goInfomationVC];
    }];

}
- (IBAction)changeSD:(UIButton *)sender {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    if (sender.isSelected) {
        NSDate *date=[userDefaults objectForKey:@"years"];
        NSTimeInterval interval=-[date timeIntervalSinceNow];
        NSString *dateStr = [NSString stringWithFormat:@"%ld",(NSInteger)interval/(60*60*24*30*12)];
        self.daysLabel.text=dateStr;
    }else{
        NSDate *date=[userDefaults objectForKey:@"days"];
        NSTimeInterval interval=-[date timeIntervalSinceNow];
        NSString *dateStr = [NSString stringWithFormat:@"%ld",(NSInteger)interval/(60*60*24)];
        self.daysLabel.text=dateStr;
        
    }
    sender.selected=!sender.selected;
    [self isSingle:!sender.selected];
    
    [userDefaults setBool:!sender.selected forKey:@"single"];
}



-(void)isSingle:(BOOL) isSingle{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (!isSingle) {
        self.single.text=@"恋爱";
//        self.single.textColor=[UIColor redColor];
        self.singleOrDouble.selected=YES;
        self.yearOrMonthLable.text=@"天";
        self.singleLable.text=@"double";
        self.finishTingsCount.text=[NSString stringWithFormat:@"%ld",(long)self.i];
        NSDate *date=[userDefaults objectForKey:@"days"];
        NSTimeInterval interval=-[date timeIntervalSinceNow];
        NSString *dateStr = [NSString stringWithFormat:@"%ld",(NSInteger)interval/(60*60*24)];
        self.daysLabel.text=dateStr;
    }else{
        self.yearOrMonthLable.text=@"年";
        self.single.text=@"单身";
        self.singleOrDouble.selected=NO;
//        self.single.textColor=[UIColor grayColor];
        self.singleLable.text=@"single";
        self.finishTingsCount.text=[NSString stringWithFormat:@"%ld",(long)self.i];
        NSDate *date=[userDefaults objectForKey:@"years"];
        NSTimeInterval interval=-[date timeIntervalSinceNow];
        NSString *dateStr = [NSString stringWithFormat:@"%ld",(NSInteger)interval/(60*60*24*30*12)];
        self.daysLabel.text=dateStr;
    }

}

-(void)leftViewAnimation{
    self.leftView.alpha=1;
    [UIView animateWithDuration:1.5 delay:0 options:UIViewAnimationOptionAutoreverse|UIViewAnimationOptionRepeat  animations:^{
        self.leftView.alpha=0;
    } completion:^(BOOL finished) {
        
    }];
    
}

-(void)setMySingleLable{
    [_singleLable.layer setMasksToBounds:YES];
    [_singleLable.layer setCornerRadius:8];
    [_singleLable.layer setBorderWidth:2];
//    CGColorSpaceRef colorSpaceRef=CGColorSpaceCreateDeviceRGB();
    CGColorRef color=[UIColor blackColor].CGColor;
    [_singleLable.layer setBorderColor:color];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}


-(void)creatDatePicker{
    self.datePicker=[[UIDatePicker alloc]init];
    self.datePicker=[[UIDatePicker alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height*0.3)];
    self.datePicker.datePickerMode=UIDatePickerModeDate;
    [self.view addSubview:self.datePicker];
}
- (IBAction)datePickerSee:(id)sender {
    if (self.singleOrDouble.selected) {
        self.tipLabel.text=@"请选择恋爱日";
    }
    if (!self.singleOrDouble.selected) {
        self.tipLabel.text=@"请输入破蛋日";
    }
    [UIView animateWithDuration:0.5 animations:^{
        self.datePicker.frame=CGRectMake(0, self.view.bounds.size.height*0.4, self.view.bounds.size.width, self.view.bounds.size.height*0.3);
        
    } completion:^(BOOL finished) {
        self.saveButton.alpha=1;

    }];
    self.singleOrDouble.enabled=NO;
}
- (IBAction)sava:(id)sender {
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    NSDate *date=[self.datePicker date];
    
    NSTimeInterval interval=-[date timeIntervalSinceNow];
    self.tipLabel.text=@"";
    self.saveButton.alpha=0;
    [UIView animateWithDuration:0.5 animations:^{
       self.datePicker.frame=CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height*0.3);
    } completion:^(BOOL finished) {

    }];
    NSInteger result;
    if (self.singleOrDouble.selected) {
        result=interval/(60*60*24);

        self.daysLabel.text=[NSString stringWithFormat:@"%ld",(long)result];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [userDefaults setObject:date forKey:@"days"];
        });
    }
    if (!self.singleOrDouble.selected) {
        result=interval/(60*60*24*30*12);
        ;
        self.daysLabel.text=[NSString stringWithFormat:@"%ld",(long)result];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [userDefaults setObject:date forKey:@"years"];
        });
    }
    self.singleOrDouble.enabled=YES;
    
    
}
- (IBAction)goLeftVC:(id)sender {
    [self.sideMenuViewController presentLeftMenuViewController];
}



@end
