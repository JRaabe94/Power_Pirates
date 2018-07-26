//
//  BuySellButton.m
//  Power_Pirates
//
//  Created by Codecamp on 26.07.18.
//  Copyright © 2018 Codecamp. All rights reserved.
//

#import "BuySellButton.h"

@implementation BuySellButton

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
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.layer.cornerRadius = 8.0f;
    
    self.layer.backgroundColor = UIColor.yellowColor.CGColor;
    self.layer.borderColor = UIColor.blackColor.CGColor;
    
    self.titleLabel.font = [UIFont fontWithName:@"Chalkduster"  size:15];
    self.titleLabel.textColor = UIColor.blackColor;
}

@end
