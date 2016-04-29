//
//  LeftViewController.m
//  singleOrDouble
//
//  Created by tarena on 16/3/26.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "LeftViewController.h"

@interface LeftViewController ()<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic,strong)NSArray *deatil;
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation LeftViewController

-(NSArray *)deatil{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDate *dateYears=[userDefaults objectForKey:@"years"];
    NSDate *dateDays=[userDefaults objectForKey:@"days"];
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    formatter.dateFormat=@"yyyy-MM-dd";
    //    NSDateFormatter *formatter2=[[NSDateFormatter alloc]init];
    //    formatter2.dateFormat=@"yyyy-MM-dd";
    NSString *date1=[formatter stringFromDate:dateDays];
    NSString *date2=[formatter stringFromDate:dateYears];
    if (!date1) {
        date1=@"暂无";
    }
    if (!date2) {
        date2=@"暂无";
    }
    _deatil=@[date1,date2];
    
    return _deatil;
}

-(void)viewWillAppear:(BOOL)animated{
   [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height/2-100, self.view.bounds.size.width, 50*2)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    //seperator线的设置
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identifier];
        cell.backgroundColor = [UIColor whiteColor];
        //cell的文本颜色
        cell.textLabel.textColor = [UIColor blackColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //        cell.selectedBackgroundView = [UIView new];
    }
    
    NSArray *titles = @[@"恋爱日", @"生日"];
//    NSArray *images = @[@"IconSettings", @"IconProfile"];
    cell.textLabel.text = titles[indexPath.row];
    cell.detailTextLabel.text=self.deatil[indexPath.row];
//    cell.imageView.image = [UIImage imageNamed:images[indexPath.row]];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
