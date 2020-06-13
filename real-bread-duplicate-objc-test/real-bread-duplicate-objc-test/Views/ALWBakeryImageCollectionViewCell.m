//
//  ALWBaleryImageCollectionViewCell.m
//  real-bread-duplicate-objc-test
//
//  Created by Audrey Welch on 6/8/20.
//  Copyright © 2020 Audrey Welch. All rights reserved.
//

#import "ALWBakeryImageCollectionViewCell.h"

@interface ALWBakeryImageCollectionViewCell ()



@end

@implementation ALWBakeryImageCollectionViewCell

- (void)updateViews {
    
    if (!self.bakery) { return; }
    
    // NOT USING DUE TO API KEY RESTRICTION
    
    //
    //    NSURLComponents *urlComponents = [[NSURLComponents alloc] init];
    //    urlComponents.scheme = @"https";
    //    urlComponents.host = @"maps.googleapis.com";
    //    urlComponents.path = @"/maps/api/place/photo";
    //
    //    NSURLQueryItem *sizeQueryItem = [NSURLQueryItem queryItemWithName:@"maxwidth" value:@"400"];
    //    NSURLQueryItem *photoRefsQueryItem = [NSURLQueryItem queryItemWithName:@"photoreferences" value:self.bakery.photos[indexPath.row]];
    //    NSURLQueryItem *apiKeyQueryItem = [NSURLQueryItem queryItemWithName:@"key" value:@"AIzaSyBRMVPW8u3LagIW0t_geAdChN9BAKwb2yQ"];
    //
    //    urlComponents.queryItems = @[sizeQueryItem, photoRefsQueryItem, apiKeyQueryItem];
    //
    //    NSURL *url = urlComponents.URL;
    //
    //    NSLog(@"URL: %@", url);
    //    // @"https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreferences=\(self.bakery.photos[indexPath.row)&key=\(apiKey)"
    
    //        dispatch_async(dispatch_get_global_queue(0, 0), ^{
    //
    //
    //            NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:self.bakery.photos[indexPath.row]]];
    //
    //            dispatch_async(dispatch_get_main_queue(), ^{
    //
    //                if (imageData != nil) {
    //                    cell.bakeryImageView.image = [UIImage imageWithData:imageData];
    //                }
    //            });
    //
    //        });

    
    
    
}

@end
