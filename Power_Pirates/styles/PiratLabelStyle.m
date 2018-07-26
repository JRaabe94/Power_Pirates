//
//  PiratLabelStyle.m
//  Power_Pirates
//
//  Created by Codecamp on 26.07.18.
//  Copyright © 2018 Codecamp. All rights reserved.
//

#import "PiratLabelStyle.h"

@implementation PiratLabelStyle

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
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.font = [UIFont fontWithName:@"Chalkduster"  size:15];
    self.textColor = UIColor.blackColor;
}

@end
