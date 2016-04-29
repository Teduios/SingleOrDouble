//
//  DetailViewController.m
//  singleOrDouble
//
//  Created by tarena on 16/3/17.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "DetailViewController.h"
#import "TaskDetail.h"
@interface DetailViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *myLabel;
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
@property (weak, nonatomic) IBOutlet UIImageView *smallImageView;
@property (weak, nonatomic) IBOutlet UIImageView *markedImageView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property(strong,nonatomic)UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIImageView *editImageView;
@property (weak, nonatomic) IBOutlet UIView *touchMeView;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewToTopConstraint;
@property (nonatomic, assign) CGFloat f;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.saveButton.alpha=0;
    self.myLabel.text=self.labelName;
    
    if (self.isMarked) {
        self.markedImageView.image=[UIImage imageNamed:@"mark"];
    }if (!self.isMarked) {
        self.markedImageView.image=nil;
    }
    [self creatDatePicker];
    self.f=self.imageViewToTopConstraint.constant;
}
-(void)viewWillAppear:(BOOL)animated{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@image.data",self.name]];
        NSString *filePath2 = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@date.data",self.name]];
        TaskDetail *taskDetailDate=[NSKeyedUnarchiver unarchiveObjectWithFile:filePath2];
        TaskDetail *taskDetail=[NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        NSString *filePath3 = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@detail.data",self.name]];
        TaskDetail *taskDetailDetail=[NSKeyedUnarchiver unarchiveObjectWithFile:filePath3];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.dateLabel.text=taskDetailDate.finishDate;
            self.textLabel.text=taskDetailDetail.detail;
            if (taskDetail) {
                self.myImageView.image=taskDetail.image;
                self.smallImageView.image=taskDetail.image;
            }
        });
    });
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openKeyboard:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeKeyboard:) name:UIKeyboardWillHideNotification object:nil];
    });
    

    self.touchMeView.alpha=1;
    [UIView animateWithDuration:1.5 delay:0 options:UIViewAnimationOptionAutoreverse|UIViewAnimationOptionRepeat  animations:^{
        self.touchMeView.alpha=0;
    } completion:^(BOOL finished) {
        
    }];
}


- (IBAction)goBack:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewWillLayoutSubviews{
    [self setmyImageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setmyImageView{
    
    [_myImageView.layer setMasksToBounds:YES];
    [_myImageView.layer setCornerRadius:self.myImageView.bounds.size.width/2];
    [_myImageView.layer setBorderWidth:2];
    //    CGColorSpaceRef colorSpaceRef=CGColorSpaceCreateDeviceRGB();
//    CGColorRef color=[UIColor Color].CGColor;
//    [_myImageView.layer setBorderColor:color];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
- (IBAction)chooseImage:(id)sender {
    [self createActionSheet];
}

-(void)createActionSheet {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请选择" message:@"获取照片" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //打开 图片编辑器 用相机的形式打开
        [self chooseHeadImage:(UIImagePickerControllerSourceTypeCamera)];
    }];
    
    UIAlertAction *photoLibrary = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //打开 图片编辑器 用相册的形式打开
        [self chooseHeadImage:(UIImagePickerControllerSourceTypePhotoLibrary)];
    }];
    
    [alert addAction:cancel];
    [alert addAction:camera];
    [alert addAction:photoLibrary];
    
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)chooseHeadImage:(UIImagePickerControllerSourceType)type {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    //允许编辑图片
    imagePicker.allowsEditing = YES;
    //类型 是 相机  或  相册
    imagePicker.sourceType = type;
    //设置代理
    imagePicker.delegate = self;
    
    [self presentViewController:imagePicker animated:YES completion:nil];
    
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    //把选中图片取出来
    UIImage *image = info[UIImagePickerControllerEditedImage];
    self.myImageView.image = image;
    self.smallImageView.image=image;
    TaskDetail *taskDetail=[[TaskDetail alloc]init];
    taskDetail.image=image;
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@image.data",self.name]];
    NSLog(@"%@",filePath);
    [NSKeyedArchiver archiveRootObject:taskDetail toFile:filePath];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)datePickSee:(id)sender {

    self.saveButton.alpha=1;
    self.editImageView.alpha=0;
    [UIView animateWithDuration:0.8 animations:^{
        self.datePicker.frame=CGRectMake(0, self.view.bounds.size.height*0.7, self.view.bounds.size.width, self.view.bounds.size.height*0.3);
    } completion:^(BOOL finished) {
        
    }];
}

- (IBAction)datePickerSave {
    NSDate *date=[self.datePicker date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    self.dateLabel.text=dateStr;
    self.saveButton.alpha=0;
    self.editImageView.alpha=1;
    [UIView animateWithDuration:0.5 animations:^{
        self.datePicker.frame=CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height*0.3);
    }];
    TaskDetail *taskDetail=[[TaskDetail alloc]init];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        taskDetail.finishDate=dateStr;
        NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@date.data",self.name]];
        [NSKeyedArchiver archiveRootObject:taskDetail toFile:filePath];
    });
}

-(void)creatDatePicker{
    self.datePicker=[[UIDatePicker alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height*0.3)];
    self.datePicker.datePickerMode=UIDatePickerModeDate;
    
    [self.view addSubview:self.datePicker];
}

- (IBAction)clickReturn:(UITextField *)sender {
    self.textLabel.text=sender.text;
    sender.text=@"";
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        TaskDetail *taskDetail=[[TaskDetail alloc]init];
        NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@detail.data",self.name]];
        taskDetail.detail=self.textLabel.text;
    NSLog(@"%@",taskDetail.detail);
        [NSKeyedArchiver archiveRootObject:taskDetail toFile:filePath];
    });
    
}

-(void)openKeyboard:(NSNotification *)notification
{
    // 获取动画的种类
    NSInteger option = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    // 获取动画的时长
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 获取键盘的大小
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // 修改底部约束的contant，调整文本框的位置
    self.imageViewToTopConstraint.constant = self.imageViewToTopConstraint.constant - keyboardFrame.size.height+150;
    
    [UIView animateWithDuration:duration delay:0 options:option animations:^{
        
        [self.view layoutIfNeeded];
        
    } completion:nil];
}
-(void)closeKeyboard:(NSNotification *)notification
{
    self.imageViewToTopConstraint.constant = self.f;
    
}

//取消对键盘通知的监听
- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
