//
//  ViewController.h
//  Game Prototype
//
//  Created by Brayden Wilmoth on 8/11/14.
//  Copyright (c) 2014 Prototype. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WorldViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;

#pragma mark - Methods
/**
 * Regenerates the entire world with a whole
 * new set of procedural tile generations.
 */
- (IBAction)regenerateWorld;

@end
