//
//  Tile.h
//  Game Prototype
//
//  Created by Brayden Wilmoth on 8/11/14.
//  Copyright (c) 2014 Prototype. All rights reserved.
//

@class Biome;

@interface Tile : NSObject

/// Object containing the primary biome type for the current tile
@property (nonatomic, strong) Biome *primaryBiomeType;

/// Object containing the secondary biome type for the current tile
@property (nonatomic, strong) Biome *secondaryBiomeType;

#warning Remove this later
@property (nonatomic, assign) NSUInteger biome;

/// Value between 0 and 1 that declares the weight of the primary biome
@property (nonatomic, assign) CGFloat primaryBiomeWeight;

/// Value between 0 - 100 for the top left tile corner temperature
@property (nonatomic, assign) CGFloat northwestTemperature;

/// Value between 0 - 100 for the top right tile corner temperature
@property (nonatomic, assign) CGFloat northeastTemperature;

/// Value between 0 - 100 for the bottom left tile corner temperature
@property (nonatomic, assign) CGFloat southwestTemperature;

/// Value between 0 - 100 for the bottom right tile corner temperature
@property (nonatomic, assign) CGFloat southeastTemperature;

/// Is this cell the source cell for the temperatures
@property (nonatomic, assign) BOOL isCenterCell;

/// Checks a flag of whether this tile has been populated yet
@property (nonatomic, assign) BOOL hasPopulated;

/// Property retaining the row of the map it is generated on
@property (nonatomic, assign) NSUInteger row;

/// Property retaining the column of the map it is generated on
@property (nonatomic, assign) NSUInteger column;

#pragma mark - Methods
/**
 * Instantiate a tile object with given primary
 * and secondary biome objects.  The remaining
 * items will be populated automatically.
 */
- (instancetype)initWithPrimaryBiome:(Biome *)primary secondaryBiome:(Biome *)secondary;

/**
 * Returns a mean temperature based on the four corner
 * temperatures that are declared in the properties.
 */
- (CGFloat)getTileTemperature;

@end
