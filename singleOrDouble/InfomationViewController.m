//
//  InfomationViewController.m
//  singleOrDouble
//
//  Created by tarena on 16/3/17.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "InfomationViewController.h"
#import "Infomation.h"
@interface InfomationViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *header;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *allLabels;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *allButtons;



@end

@implementation InfomationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"711"]]];
    
    // Do any additional setup after loading the view.
    self.header.layer.cornerRadius=self.header.bounds.size.width/2;
    self.header.layer.masksToBounds=YES;
    self.header.layer.borderWidth=2;
    self.header.layer.borderColor=[UIColor whiteColor].CGColor;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"infomation.data"];
        Infomation *infomation = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        NSString *filePathHeader = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"infomationHeader.data"];
        Infomation *infomationHeader = [NSKeyedUnarchiver unarchiveObjectWithFile:filePathHeader];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (infomationHeader!=nil) {
                self.header.image=infomationHeader.header;
            }
            
            if (infomation==nil) {
                return;
            }
            ((UILabel*)self.allLabels[0]).text=infomation.name;
            ((UILabel*)self.allLabels[1]).text=infomation.sex;
            ((UILabel*)self.allLabels[2]).text=infomation.xz;
            ((UILabel*)self.allLabels[3]).text=infomation.start;
            ((UILabel*)self.allLabels[4]).text=infomation.bithday;
            ((UILabel*)self.allLabels[5]).text=infomation.height;
            ((UILabel*)self.allLabels[6]).text=infomation.weight;
            ((UILabel*)self.allLabels[7]).text=infomation.favo;
            NSLog(@"%@",infomation.favo);
            ((UILabel*)self.allLabels[8]).text=infomation.talented;
        });
        
    });
    
    


    
}

- (IBAction)goback:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{

        
    }];
}
- (IBAction)buttonClick:(UIButton*)sender {
    NSInteger i=[self.allButtons indexOfObject:sender];
    [self showAlert:self.allLabels[i]];
    
}

-(void)showAlert:(UILabel*)label{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:nil message:@"请输入修改内容" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionYes=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (alert.textFields[0].text.length!=0) {
            label.text=alert.textFields[0].text;
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                Infomation *infomation=[[Infomation alloc]init];
                infomation.name=((UILabel*)self.allLabels[0]).text;
                infomation.sex=((UILabel*)self.allLabels[1]).text;
                infomation.xz=((UILabel*)self.allLabels[2]).text;
                infomation.start=((UILabel*)self.allLabels[3]).text;
                infomation.bithday=((UILabel*)self.allLabels[4]).text;
                infomation.height=((UILabel*)self.allLabels[5]).text;
                infomation.weight=((UILabel*)self.allLabels[6]).text;
                infomation.favo=((UILabel*)self.allLabels[7]).text;
                infomation.talented=((UILabel*)self.allLabels[8]).text;
                NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"infomation.data"];
                [NSKeyedArchiver archiveRootObject:infomation toFile:filePath];
            });
        }
        else return;
    }];
    UIAlertAction *actionCancle=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
    }];
    [alert addAction:actionYes];
    [alert addAction:actionCancle];
    
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (IBAction)chooseHeader:(UIButton *)sender {
    [self createActionSheet];
}

-(void)createActionSheet {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请选择" message:@"获取头像" preferredStyle:UIAlertControllerStyleActionSheet];
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
    self.header.image = image;
    Infomation *infomation=[[Infomation alloc]init];
    infomation.header=image;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"infomationHeader.data"];
        [NSKeyedArchiver archiveRootObject:infomation toFile:filePath];
    });
    

    [self dismissViewControllerAnimated:YES completion:nil];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

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
