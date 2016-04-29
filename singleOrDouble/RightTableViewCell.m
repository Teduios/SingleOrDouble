//
//  RightTableViewCell.m
//  singleOrDouble
//
//  Created by tarena on 16/3/16.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "RightTableViewCell.h"
@interface RightTableViewCell()

@property(nonatomic,assign)NSInteger count;
@end

@implementation RightTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (IBAction)click:(UIButton *)sender {

    sender.selected=!sender.selected;
//    if (sender.selected==YES) {
//        self.mytextLabel.textColor=[UIColor redColor];
//    }
    self.finshCountBlock(sender.selected);
}
- (IBAction)click2:(UIButton*)sender {
    sender.selected=!sender.selected;
    if (sender.selected) {
        self.markedImageView.image=[UIImage imageNamed:@"mark"];
    }if (!sender.selected) {
        self.markedImageView.image=nil;
    }
    self.markBlock(sender.selected);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}






@end
