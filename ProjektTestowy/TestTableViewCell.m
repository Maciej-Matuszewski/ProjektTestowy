//
//  TestTableViewCell.m
//  
//
//  Created by Maciej Matuszewski on 09.11.2015.
//
//

#import "TestTableViewCell.h"

@implementation TestTableViewCell

@synthesize imageView, titleLabel, descriptionLabel;

- (void)awakeFromNib {
    
    [self setImageView:[[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 60, 60)]];
    [self.imageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.imageView setContentMode:UIViewContentModeScaleAspectFill];
    [self.imageView setClipsToBounds:YES];
    [self addSubview:self.imageView];
    
    [self setTitleLabel:[[UILabel alloc] init]];
    [self.titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
    [self addSubview:self.titleLabel];
    
    [self setDescriptionLabel:[[UILabel alloc] init]];
    [self.descriptionLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:self.descriptionLabel];
    [self.descriptionLabel setFont:[UIFont systemFontOfSize:14]];
    [self.descriptionLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [self.descriptionLabel setNumberOfLines:0];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(==5)-[imageView(==50)]" options:0 metrics:nil views:@{@"imageView":self.imageView}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(==5)-[imageView(==50)]-(==5)-[titleLabel]-|" options:NSLayoutFormatAlignAllTop metrics:nil views:@{@"imageView":self.imageView, @"titleLabel": self.titleLabel}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[titleLabel]-[descriptionLabel]-(>=5)-|" options:NSLayoutFormatAlignAllLeft metrics:nil views:@{@"titleLabel": self.titleLabel, @"descriptionLabel": self.descriptionLabel}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(==5)-[imageView(==50)]-(==5)-[descriptionLabel]-|" options:0 metrics:nil views:@{@"imageView":self.imageView, @"descriptionLabel": self.descriptionLabel}]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)prepareForReuse{
    [self.imageView setImage:nil];
    [self.titleLabel setText:nil];
    [self.descriptionLabel setText:nil];
}

@end
