//
//  World.h
//  Game Prototype
//
//  Created by Brayden Wilmoth on 8/11/14.
//  Copyright (c) 2014 Prototype. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface World : NSObject

/// Queue of tiles that need to be determined
@property (nonatomic, strong) NSMutableArray *queue;

/// Set of tile objects that are used to generate the map
@property (nonatomic, copy) NSArray *tileset;

/// Number of rows in the tileset grid of the world
@property (nonatomic, assign) NSUInteger rows;

/// Number of columns in the tileset grid of the world
@property (nonatomic, assign) NSUInteger columns;

#pragma mark - Methods
/**
 * Generate a tileset based off of a given initial
 * temperature to start from.
 */
- (instancetype)initWithBaselineTemperature:(CGFloat)temperature rows:(NSUInteger)rows columns:(NSUInteger)columns;

@end
