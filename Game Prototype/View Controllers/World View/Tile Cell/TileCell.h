//
//  TileCell.h
//  Game Prototype
//
//  Created by Brayden Wilmoth on 8/11/14.
//  Copyright (c) 2014 Prototype. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TileCell : UICollectionViewCell

@property (nonatomic, weak) IBOutlet UIView *containerView;

@property (nonatomic, weak) IBOutlet UILabel *temperatureLabel;

@property (nonatomic, weak) IBOutlet UILabel *nwTempLabel;
@property (nonatomic, weak) IBOutlet UILabel *neTempLabel;
@property (nonatomic, weak) IBOutlet UILabel *swTempLabel;
@property (nonatomic, weak) IBOutlet UILabel *seTempLabel;

@end
