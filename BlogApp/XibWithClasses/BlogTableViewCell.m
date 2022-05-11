//
//  BlogTableViewCell.m
//  BlogApp
//
//  Created by Muhammad Saud Anwar on 10/05/2022.
//

#import "BlogTableViewCell.h"

@implementation BlogTableViewCell
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.imgView.layer.cornerRadius = 10.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
