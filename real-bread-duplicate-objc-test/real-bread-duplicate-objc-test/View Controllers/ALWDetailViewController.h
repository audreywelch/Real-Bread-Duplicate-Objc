//
//  ALWDetailViewController.h
//  real-bread-duplicate-objc-test
//
//  Created by Audrey Welch on 6/8/20.
//  Copyright © 2020 Audrey Welch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALWBakeryController.h"
#import <MapKit/MapKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ALWDetailViewController : UIViewController

@property (nonatomic, strong, nullable) ALWBakery *bakery;
@property (nonatomic, strong) ALWBakeryController *bakeryController;

- (void)updateViews;

@end

NS_ASSUME_NONNULL_END
