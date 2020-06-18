//
//  ALWBakeryController.h
//  real-bread-duplicate-objc-test
//
//  Created by Audrey Welch on 6/6/20.
//  Copyright © 2020 Audrey Welch. All rights reserved.
//

#import <Foundation/Foundation.h>

// Forward Class Declaration to avoid importing .h files into other .h files
@class ALWBakery;

// Declaration of named type for completion handler
typedef void(^ALWBakeryCompletion)(NSArray<ALWBakery *> * _Nullable bakeries, NSError * _Nullable error);

NS_ASSUME_NONNULL_BEGIN

@interface ALWBakeryController : NSObject

// Array to store bakery objects
@property (nonatomic, copy) NSArray *bakeries;

// Returns count of bakeries
- (NSInteger)numberOfBakeries;

// Returns bakery at specific index
- (ALWBakery *)bakeryAtIndex:(NSInteger)index;

// Fetches bakeries from firebase
- (void)fetchBakeriesWithCompletionBlock:(ALWBakeryCompletion)completionBlock;

@end

NS_ASSUME_NONNULL_END
