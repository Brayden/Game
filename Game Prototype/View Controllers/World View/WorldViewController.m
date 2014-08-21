//
//  ViewController.m
//  Game Prototype
//
//  Created by Brayden Wilmoth on 8/11/14.
//  Copyright (c) 2014 Prototype. All rights reserved.
//

#import "WorldViewController.h"
#import "TileCell.h"

#import "World.h"
#import "Tile.h"
#import "Biome.h"

@interface WorldViewController ()

/// World generated for this controller
@property (nonatomic, strong) World *world;

/// Number of rows this world will contain
@property (nonatomic, assign) NSUInteger rows;

/// Number of columns this world will contain
@property (nonatomic, assign) NSUInteger columns;

@end


@implementation WorldViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.rows = 10;
    self.columns = 20;
    
    [self regenerateWorld];
}

#pragma mark - Methods

- (void)regenerateWorld {
    CGFloat randomTemperature = arc4random() % 100;
    
    self.world = [[World alloc] initWithBaselineTemperature:randomTemperature rows:self.rows columns:self.columns];
    
    [self.collectionView reloadData];
}

#pragma mark - UICollectionView Methods

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGRect screenSize = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenSize.size.height;
    CGFloat screenHeight = screenSize.size.width;
    
    return CGSizeMake(screenWidth / self.columns, screenHeight / self.rows);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.world.tileset.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString static *identifier = @"TileCell";
    
    Tile *current = self.world.tileset[indexPath.row];
    
    TileCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.temperatureLabel.text = [NSString stringWithFormat:@"%2.0f", [current getTileTemperature]];
    cell.nwTempLabel.text = [NSString stringWithFormat:@"%2.0f", current.northwestTemperature];
    cell.neTempLabel.text = [NSString stringWithFormat:@"%2.0f", current.northeastTemperature];
    cell.swTempLabel.text = [NSString stringWithFormat:@"%2.0f", current.southwestTemperature];
    cell.seTempLabel.text = [NSString stringWithFormat:@"%2.0f", current.southeastTemperature];
    
    if (current.isCenterCell) {
        cell.containerView.backgroundColor = [UIColor orangeColor];
    }
    
    if (current.biome == BiomeTypeTundra) {
        cell.containerView.backgroundColor = [UIColor blueColor];
    } else if (current.biome == BiomeTypePlains) {
        cell.containerView.backgroundColor = [UIColor yellowColor];
    } else if (current.biome == BiomeTypeJungle) {
        cell.containerView.backgroundColor = [UIColor greenColor];
    } else if (current.biome == BiomeTypeDesert) {
        cell.containerView.backgroundColor = [UIColor purpleColor];
    }
    
    return cell;
}

@end
