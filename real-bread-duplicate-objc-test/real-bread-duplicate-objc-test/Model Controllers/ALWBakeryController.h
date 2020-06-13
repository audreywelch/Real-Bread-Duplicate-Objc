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
@property (nonatomic, strong) NSArray *bakeries; // Should likely have copy attribute. Should be readonly externally?

// Returns count of bakeries
- (NSInteger)numberOfBakeries; // Make this a readonly @property?

// Returns bakery at specific index
// The following should be called -bakeryAtIndex:. The argument should be an NSInteger not an int, and don't call it indexPath. indexPath is more than a single number, e.g. a section *and* row. This is just an index.
- (ALWBakery *)bakeryAt:(int)indexPath;

// Nice use of 'fetch' here. Don't use 'get' instead. That's a very obvious sign of an inexperienced ObjC dev to me.
- (void)fetchBakeriesWithCompletionBlock:(ALWBakeryCompletion)completionBlock;

// I think this could be named better. What does it do? What file? Why is it public?
- (NSData *)JSONFromFile;


@end

NS_ASSUME_NONNULL_END
