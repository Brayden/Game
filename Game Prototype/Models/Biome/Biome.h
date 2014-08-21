//
//  Biome.h
//  Game Prototype
//
//  Created by Brayden Wilmoth on 8/11/14.
//  Copyright (c) 2014 Prototype. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 < 0 - 33     Tundra
  34 - 67     Plains
  68 - 90     Jungle
  90 +        Desert
 */

NS_OPTIONS(NSUInteger, BiomeType) {
    BiomeTypeTundra,
    BiomeTypePlains,
    BiomeTypeJungle,
    BiomeTypeDesert
};

@interface Biome : NSObject

/// Given biome type of this specific biome object
@property (nonatomic, assign) enum BiomeType type;

@end
