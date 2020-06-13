//
//  ALWBakeryTableViewCell.m
//  real-bread-duplicate-objc-test
//
//  Created by Audrey Welch on 6/6/20.
//  Copyright © 2020 Audrey Welch. All rights reserved.
//

#import "ALWBakeryTableViewCell.h"

@interface ALWBakeryTableViewCell ()

// Private Properties

// Private IBOutlets
@property (strong, nonatomic) IBOutlet UILabel *bakeryNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *bakeryAddressLabel;
@property (strong, nonatomic) IBOutlet UIImageView *bakeryImageView;

// Private Methods

@end

@implementation ALWBakeryTableViewCell

- (void)updateViews {
    
    if (!self.bakery) { return; }
    
    self.bakeryNameLabel.text = self.bakery.name;
    self.bakeryAddressLabel.text = self.bakery.address;
    
}

@end
