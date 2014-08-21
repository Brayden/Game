//
//  Tile.m
//  Game Prototype
//
//  Created by Brayden Wilmoth on 8/11/14.
//  Copyright (c) 2014 Prototype. All rights reserved.
//

#import "Tile.h"

@implementation Tile

- (instancetype)initWithPrimaryBiome:(Biome *)primary secondaryBiome:(Biome *)secondary {    
    self.primaryBiomeType = primary;
    self.secondaryBiomeType = secondary;
    
    return self;
}

- (CGFloat)getTileTemperature {
    if (self.hasPopulated) {
        return (self.northeastTemperature + self.northwestTemperature + self.southeastTemperature + self.southwestTemperature) / 4;
    } else {
        return 0.0f;
    }
}

@end
