//
//  ColorPickerCell.m
//  test7
//
//  Created by Баз Светик on 21.07.13.
//  Copyright (c) 2013 ru.testoc. All rights reserved.
//

#import "ColorPickerCell.h"

@implementation ColorPickerCell

@synthesize titleCell = _titleCell;
@synthesize textCell = _textCell;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
