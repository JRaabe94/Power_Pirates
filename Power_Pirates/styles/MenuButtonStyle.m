//
//  MenuButtonStyle.m
//  Power_Pirates
//
//  Created by Codecamp on 26.07.18.
//  Copyright © 2018 Codecamp. All rights reserved.
//

#import "MenuButtonStyle.h"

@implementation MenuButtonStyle

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = 1/UIScreen.mainScreen.nativeScale;
    //self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, 100, 50);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.layer.backgroundColor = UIColor.lightGrayColor.CGColor;
    self.layer.borderColor = UIColor.blackColor.CGColor;
    
    self.titleLabel.font = [UIFont fontWithName:@"Chalkduster"  size:15];
    self.titleLabel.textColor = UIColor.blackColor;
}

@end
