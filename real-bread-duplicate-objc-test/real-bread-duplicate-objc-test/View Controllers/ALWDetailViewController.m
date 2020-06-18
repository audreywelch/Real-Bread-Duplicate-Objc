//
//  ALWDetailViewController.m
//  real-bread-duplicate-objc-test
//
//  Created by Audrey Welch on 6/8/20.
//  Copyright © 2020 Audrey Welch. All rights reserved.
//

#import "ALWDetailViewController.h"
#import "ALWBakeryImageCollectionViewCell.h"

// Conform to delegate protocols in the .m file using the Class Extension
@interface ALWDetailViewController () <UICollectionViewDelegate, UICollectionViewDataSource, MKMapViewDelegate>

// Label & Button Outlets
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;
@property (strong, nonatomic) IBOutlet UIButton *phoneButton;
@property (strong, nonatomic) IBOutlet UILabel *hoursLabel;
@property (strong, nonatomic) IBOutlet UIButton *websiteButton;
@property (strong, nonatomic) IBOutlet UILabel *infoLabel;
@property (strong, nonatomic) IBOutlet UIButton *getDirectionsButton;

// Tag Outlets
@property (strong, nonatomic) IBOutlet UIImageView *sellsLoavesImageView;
@property (strong, nonatomic) IBOutlet UIImageView *milledInHouseImageView;
@property (strong, nonatomic) IBOutlet UIImageView *organicImageView;
@property (strong, nonatomic) IBOutlet UIImageView *servesFoodImageView;
@property (strong, nonatomic) IBOutlet UILabel *sellsLoavesLabel;
@property (strong, nonatomic) IBOutlet UILabel *milledInHouseLabel;
@property (strong, nonatomic) IBOutlet UILabel *organicLabel;
@property (strong, nonatomic) IBOutlet UILabel *servesFoodLabel;

// Map Outlet
@property (strong, nonatomic) IBOutlet MKMapView *mapView;

// Collection View Outlet
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ALWDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"bakery milledInHouse is: %@", self.bakery.milledInHouse ? @"YES" : @"NO");
    
    [self updateViews];

    NSLog(@"bakery location is: %f", self.bakery.latitude);
    NSLog(@"bakery location is: %@", self.bakery.location);
    
    self.title = self.bakery.name;
    
    self.mapView.delegate = self;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.bakery.photos.count;
}

- (UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    ALWBakeryImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionViewCell" forIndexPath:indexPath];
    cell.bakery = self.bakery;
    
    if (!(self.bakery.photos)) {
        cell.bakeryImageView.image = [UIImage imageNamed:@"no_image_available"];
    } else {
        cell.bakeryImageView.image = self.bakery.photos[indexPath.row];
    }
    
    return cell;
}

- (void)updateViews {
    
    self.nameLabel.text = self.bakery.name;
    self.addressLabel.text = self.bakery.address;
    
    NSString *joinedHours = [self.bakery.hours componentsJoinedByString:@"\n"];
    self.hoursLabel.text = joinedHours;
    
    self.infoLabel.text = self.bakery.info;
    
    [self.phoneButton setTitle:self.bakery.phone forState:UIControlStateNormal];
    [self.websiteButton setTitle:self.bakery.website forState:UIControlStateNormal];
    
    // Update tags

    // FIXME: - Lots of duplicated code in the below. DRY it out a little.
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if (!(self.bakery.sellsLoaves)) {
            
            self.sellsLoavesLabel.textColor = UIColor.grayColor;
            NSNumber *strikeSize = [NSNumber numberWithInt:2];
            NSDictionary *strikeThroughAttribute = [NSDictionary dictionaryWithObject:strikeSize forKey:NSStrikethroughStyleAttributeName];
            NSAttributedString *strikeThroughText = [[NSAttributedString alloc] initWithString:@"Sells Loaves" attributes:strikeThroughAttribute];
            self.sellsLoavesLabel.attributedText = strikeThroughText;
        }
        
        if (self.bakery.servesFood == NO) {
            self.servesFoodLabel.textColor = UIColor.grayColor;
            NSNumber *strikeSize = [NSNumber numberWithInt:2];
            NSDictionary *strikeThroughAttribute = [NSDictionary dictionaryWithObject:strikeSize forKey:NSStrikethroughStyleAttributeName];
            NSAttributedString *strikeThroughText = [[NSAttributedString alloc] initWithString:@"Serves Food" attributes:strikeThroughAttribute];
            self.servesFoodLabel.attributedText = strikeThroughText;
        }
        
        if (self.bakery.isOrganic == NO) {
            self.organicLabel.textColor = UIColor.grayColor;
            NSNumber *strikeSize = [NSNumber numberWithInt:2];
            NSDictionary *strikeThroughAttribute = [NSDictionary dictionaryWithObject:strikeSize forKey:NSStrikethroughStyleAttributeName];
            NSAttributedString *strikeThroughText = [[NSAttributedString alloc] initWithString:@"Organic" attributes:strikeThroughAttribute];
            self.organicLabel.attributedText = strikeThroughText;
        }
        
        if (!(self.bakery.isMilledInHouse)) {
            NSLog(@"bakery milledInHouse is: %@", self.bakery.isMilledInHouse ? @"YES" : @"NO");
            self.milledInHouseLabel.textColor = UIColor.grayColor;
            NSNumber *strikeSize = [NSNumber numberWithInt:2];
            NSDictionary *strikeThroughAttribute = [NSDictionary dictionaryWithObject:strikeSize forKey:NSStrikethroughStyleAttributeName];
            NSAttributedString *strikeThroughText = [[NSAttributedString alloc] initWithString:@"Milled In-house" attributes:strikeThroughAttribute];
            self.milledInHouseLabel.attributedText = strikeThroughText;
        }
        
        // Map
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];

        [annotation setCoordinate:self.bakery.location.coordinate];
        [annotation setTitle:self.bakery.name];
        [self.mapView addAnnotation:annotation];
    });

    // FIXME: - Some booleans not returning correctly
    // Apply this to BOOLs - is this why they are all returning YES ?
    // I'd do if (![decodedObjectDictionaries isKindOfClass:[NSDictionary class]]) instead of the explicit comparison to NO.
    // Here it's not a big deal, but you *definitely* don't want to explicitly compared BOOLs with YES, as that can give you
    // false negatives.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
