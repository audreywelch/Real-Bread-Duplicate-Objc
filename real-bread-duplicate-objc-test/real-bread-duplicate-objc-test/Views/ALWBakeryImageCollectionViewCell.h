//
//  ALWBaleryImageCollectionViewCell.h
//  real-bread-duplicate-objc-test
//
//  Created by Audrey Welch on 6/8/20.
//  Copyright © 2020 Audrey Welch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALWBakery.h"

NS_ASSUME_NONNULL_BEGIN

@interface ALWBakeryImageCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *bakeryImageView;

@property (nonatomic, strong) ALWBakery *bakery;

- (void)updateViews;

@end

NS_ASSUME_NONNULL_END
