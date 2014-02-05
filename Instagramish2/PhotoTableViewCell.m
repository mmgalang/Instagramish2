//
//  PhotoTableViewCell.m
//  Instagramish2
//
//  Created by Marcial Galang on 2/4/14.
//  Copyright (c) 2014 Marc Galang. All rights reserved.
//

#import "PhotoTableViewCell.h"

@implementation PhotoTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        self.imageView.backgroundColor = [UIColor colorWithHue:.10 saturation:.2 brightness:.95 alpha:1];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.textLabel.numberOfLines = 0;
        self.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.textLabel.font  = [ UIFont fontWithName: @"Arial" size:12.0 ];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = CGRectMake( 20, 40, 280, 280);
    self.textLabel.frame = CGRectMake(20, 10, 280, 30);
    self.textLabel.backgroundColor = [UIColor colorWithHue:.10 saturation:.2 brightness:.95 alpha:1];
   // self.photoButton.frame = CGRectMake( 20.0f, 0.0f, 280.0f, 280.0f);
}

@end
