//
//  ALWBakeryTableViewCell.h
//  real-bread-duplicate-objc-test
//
//  Created by Audrey Welch on 6/6/20.
//  Copyright © 2020 Audrey Welch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALWBakery.h"
//@class ALWBakery;

NS_ASSUME_NONNULL_BEGIN

@interface ALWBakeryTableViewCell : UITableViewCell

@property (nonatomic, strong) ALWBakery *bakery;

- (void)updateViews;

@end

NS_ASSUME_NONNULL_END
