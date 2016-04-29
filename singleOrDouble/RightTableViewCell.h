//
//  RightTableViewCell.h
//  singleOrDouble
//
//  Created by tarena on 16/3/16.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^FinshThing_Count)(BOOL);
typedef void(^Mark)(BOOL);
@interface RightTableViewCell : UITableViewCell
@property(nonatomic,assign)NSInteger finishCount;
@property (weak, nonatomic) IBOutlet UILabel *mytextLabel;
@property (weak, nonatomic) IBOutlet UIButton *clickButton;
@property (weak, nonatomic) IBOutlet UIButton *markedButton;
@property(nonatomic,strong)FinshThing_Count finshCountBlock;
@property (weak, nonatomic) IBOutlet UIImageView *markedImageView;
@property(nonatomic,strong)Mark markBlock;
@end
