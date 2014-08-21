//
//  World.m
//  Game Prototype
//
//  Created by Brayden Wilmoth on 8/11/14.
//  Copyright (c) 2014 Prototype. All rights reserved.
//

#import "World.h"
#import "Tile.h"
#import "Biome.h"

@implementation World

#pragma mark - Initializers

- (instancetype)initWithBaselineTemperature:(CGFloat)temperature rows:(NSUInteger)rows columns:(NSUInteger)columns {
    self = [super init];
    
    if (self != nil) {
        self.queue = [NSMutableArray array];
        
        self.rows = rows;
        self.columns = columns;
        
        NSMutableArray *tiles = [NSMutableArray arrayWithCapacity:(rows * columns)];
        
        for (NSUInteger index = 0; index < (rows * columns); index++) {
            Tile *emptyTile = [[Tile alloc] init];
            emptyTile.hasPopulated = NO;
            
            NSUInteger currentColumn = index % columns;
            NSUInteger currentRow = (index / columns) % rows;
            
            emptyTile.row = currentRow;
            emptyTile.column = currentColumn;
            
            [tiles insertObject:emptyTile atIndex:index];
        }
        
        NSUInteger centerColumnIndex = floorf(columns / 2);
        NSUInteger centerRowIndex = floorf(rows / 2);
        NSUInteger centerIndex = (centerRowIndex * columns) + centerColumnIndex;
        
        Tile *centerTile = [self createCenterTileWithTemperature:temperature atRow:centerRowIndex andColumn:centerColumnIndex];
        [tiles replaceObjectAtIndex:centerIndex withObject:centerTile];
        
        self.tileset = [tiles copy];

        [self populateAdjacentTilesFrom:centerTile];
        
        for (Tile *tile in self.tileset) {
            CGFloat tilesTemperature = [tile getTileTemperature];
            
            if (tilesTemperature < 33) {
                tile.biome = BiomeTypeTundra;
            } else if (tilesTemperature > 33 && tilesTemperature <= 68) {
                tile.biome = BiomeTypePlains;
            } else if (tilesTemperature > 68 && tilesTemperature <= 90) {
                tile.biome = BiomeTypeJungle;
            } else if (tilesTemperature > 90) {
                tile.biome = BiomeTypeDesert;
            }
        }
    }
    
    return self;
}

#pragma mark - Private Methods

- (Tile *)createCenterTileWithTemperature:(CGFloat)temperature atRow:(NSUInteger)row andColumn:(NSUInteger)column {
    Tile *centerTile = [[Tile alloc] initWithPrimaryBiome:nil secondaryBiome:nil];
    centerTile.northwestTemperature = temperature + 4;
    centerTile.northeastTemperature = temperature - 4;
    centerTile.southwestTemperature = temperature + 8;
    centerTile.southeastTemperature = temperature + 4;
    centerTile.isCenterCell = YES;
    centerTile.hasPopulated = YES;
    centerTile.row = row;
    centerTile.column = column;
    
    return centerTile;
}

- (Tile *)getTileAtRow:(NSUInteger)row column:(NSUInteger)column {
    for (Tile *tile in self.tileset) {
        if (tile.row == row && tile.column == column) {
            return tile;
        }
    }
    
    return nil;
}

- (void)populateAdjacentTilesFrom:(Tile *)tile {
    Tile *left;
    Tile *right;
    Tile *up;
    Tile *down;
    
    if (tile.column > 0) {
        left = [self getTileAtRow:tile.row column:(tile.column - 1)];
        
        if (!left.hasPopulated && left != nil) {
            CGFloat nwTemperature = arc4random() % 6;
            CGFloat neTemperature = arc4random() % 4;
            CGFloat swTemperature = arc4random() % 6;
            CGFloat seTemperature = arc4random() % 4;
            
            left.northwestTemperature = tile.northwestTemperature - nwTemperature;
            left.northeastTemperature = tile.northeastTemperature - neTemperature;
            left.southwestTemperature = tile.southwestTemperature + swTemperature;
            left.southeastTemperature = tile.southeastTemperature + seTemperature;
            
            left.hasPopulated = YES;
            
//            [self populateAdjacentTilesFrom:left];
        }
    }
    
    if (tile.column < self.columns) {
        right = [self getTileAtRow:tile.row column:(tile.column + 1)];
        
        if (!right.hasPopulated && right != nil) {
            CGFloat nwTemperature = arc4random() % 6;
            CGFloat neTemperature = arc4random() % 4;
            CGFloat swTemperature = arc4random() % 6;
            CGFloat seTemperature = arc4random() % 4;
            
            right.northwestTemperature = tile.northwestTemperature - nwTemperature;
            right.northeastTemperature = tile.northeastTemperature - neTemperature;
            right.southwestTemperature = tile.southwestTemperature + swTemperature;
            right.southeastTemperature = tile.southeastTemperature + seTemperature;
            
            right.hasPopulated = YES;
            
//            [self populateAdjacentTilesFrom:right];
        }
    }

    if (tile.row > 0) {
        down = [self getTileAtRow:(tile.row - 1) column:tile.column];
        
        if (!down.hasPopulated) {
            CGFloat nwTemperature = arc4random() % 3;
            CGFloat neTemperature = arc4random() % 3;
            CGFloat swTemperature = arc4random() % 8;
            CGFloat seTemperature = arc4random() % 8;
            
            down.northwestTemperature = tile.northwestTemperature - nwTemperature;
            down.northeastTemperature = tile.northwestTemperature - neTemperature;
            down.southwestTemperature = tile.southwestTemperature + swTemperature;
            down.southeastTemperature = tile.southeastTemperature + seTemperature;
            
            down.hasPopulated = YES;
            
//            [self populateAdjacentTilesFrom:down];
        }
    }
    
    if (tile.column < self.columns) {
        up = [self getTileAtRow:(tile.row + 1) column:tile.column];
        
        if (!up.hasPopulated) {
            CGFloat nwTemperature = arc4random() % 8;
            CGFloat neTemperature = arc4random() % 8;
            CGFloat swTemperature = arc4random() % 3;
            CGFloat seTemperature = arc4random() % 3;
            
            up.northwestTemperature = tile.northwestTemperature - nwTemperature;
            up.northeastTemperature = tile.northeastTemperature - neTemperature;
            up.southwestTemperature = tile.southwestTemperature + swTemperature;
            up.southeastTemperature = tile.southeastTemperature + seTemperature;
            
            up.hasPopulated = YES;
            
//            [self populateAdjacentTilesFrom:up];
        }
    }
    
    // Each corner it touches gets added to a queue
    // The queue contains an array of tiles
    // Each tile in the queue goes through it's touching parts and adds them to the queue also
    // This allows for it to organically be calculated from the center point
    
    if (left) {
        [self.queue addObject:left];
    }
    
    if (right) {
        [self.queue addObject:right];
    }
    
    if (up) {
        [self.queue addObject:up];
    }
    
    if (down) {
        [self.queue addObject:down];
    }
    
    if (self.queue.count > 0) {
        [self populateAdjacentTiles];
    }
}

- (void)populateAdjacentTiles {
    if (self.queue.count == 0) {
        return;
    }
    
    Tile *tile = self.queue[0];
    
    Tile *left;
    Tile *right;
    Tile *up;
    Tile *down;
    
    if (tile.column > 0) {
        left = [self getTileAtRow:tile.row column:(tile.column - 1)];
        
        if (!left.hasPopulated && left != nil) {
            CGFloat nwTemperature = arc4random() % 6;
            CGFloat neTemperature = arc4random() % 4;
            CGFloat swTemperature = arc4random() % 6;
            CGFloat seTemperature = arc4random() % 4;
            
            left.northwestTemperature = tile.northwestTemperature - nwTemperature;
            left.northeastTemperature = tile.northeastTemperature - neTemperature;
            left.southwestTemperature = tile.southwestTemperature + swTemperature;
            left.southeastTemperature = tile.southeastTemperature + seTemperature;
            
            left.hasPopulated = YES;
        }
    }
    
    if (tile.column < self.columns) {
        right = [self getTileAtRow:tile.row column:(tile.column + 1)];
        
        if (!right.hasPopulated && right != nil) {
            CGFloat nwTemperature = arc4random() % 6;
            CGFloat neTemperature = arc4random() % 4;
            CGFloat swTemperature = arc4random() % 6;
            CGFloat seTemperature = arc4random() % 4;
            
            right.northwestTemperature = tile.northwestTemperature - nwTemperature;
            right.northeastTemperature = tile.northeastTemperature - neTemperature;
            right.southwestTemperature = tile.southwestTemperature + swTemperature;
            right.southeastTemperature = tile.southeastTemperature + seTemperature;
            
            right.hasPopulated = YES;
        }
    }
    
    if (tile.row > 0) {
        down = [self getTileAtRow:(tile.row - 1) column:tile.column];
        
        if (!down.hasPopulated) {
            CGFloat nwTemperature = arc4random() % 24;
            CGFloat neTemperature = arc4random() % 24;
            CGFloat swTemperature = arc4random() % 6;
            CGFloat seTemperature = arc4random() % 6;
            
            down.northwestTemperature = tile.northwestTemperature - nwTemperature;
            down.northeastTemperature = tile.northwestTemperature - neTemperature;
            down.southwestTemperature = tile.southwestTemperature + swTemperature;
            down.southeastTemperature = tile.southeastTemperature + seTemperature;
            
            down.hasPopulated = YES;
        }
    }
    
    if (tile.column < self.columns) {
        up = [self getTileAtRow:(tile.row + 1) column:tile.column];
        
        if (!up.hasPopulated) {
            CGFloat nwTemperature = arc4random() % 6;
            CGFloat neTemperature = arc4random() % 6;
            CGFloat swTemperature = arc4random() % 24;
            CGFloat seTemperature = arc4random() % 24;
            
            up.northwestTemperature = tile.northwestTemperature - nwTemperature;
            up.northeastTemperature = tile.northeastTemperature - neTemperature;
            up.southwestTemperature = tile.southwestTemperature + swTemperature;
            up.southeastTemperature = tile.southeastTemperature + seTemperature;
            
            up.hasPopulated = YES;
        }
    }
    
    Tile *testLeft = [self getTileAtRow:tile.row column:(tile.column - 2)];
    if (testLeft && !testLeft.hasPopulated) {
        [self.queue addObject:left];
    }
    
    Tile *testRight = [self getTileAtRow:tile.row column:(tile.column + 2)];
    if (testRight && !testRight.hasPopulated) {
        [self.queue addObject:right];
    }
    
    Tile *testUp = [self getTileAtRow:(tile.row + 2) column:tile.column];
    if (testUp && !testUp.hasPopulated) {
        [self.queue addObject:up];
    }

    Tile *testDown = [self getTileAtRow:(tile.row - 2) column:tile.column];
    if (testDown && !testDown.hasPopulated) {
        [self.queue addObject:down];
    }
    
    [self.queue removeObjectAtIndex:0];
    
    [self populateAdjacentTiles];
}

@end
