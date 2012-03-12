//
//  RSViewController.h
//  CardSharp
//
//  Created by Robert Stearn on 03.03.12.
//  Copyright (c) 2012 Cocoadelica. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSViewController : UIViewController
//Data Storage

//Player properties
@property (strong, nonatomic) IBOutlet UILabel *pcardOne;
@property (strong, nonatomic) IBOutlet UILabel *pcardTwo;
@property (strong, nonatomic) IBOutlet UILabel *pcardThree;
@property (strong, nonatomic) IBOutlet UILabel *pcardFour;
@property (strong, nonatomic) IBOutlet UILabel *pcardFive;
@property (strong, nonatomic) IBOutlet UILabel *pcardTotal; //TODO: get rid of this when we don't need it, move to array
@property (strong, nonatomic) NSMutableArray *playershandofCards;
@property (strong, nonatomic) NSMutableArray *playerCounts;

//Dealer Properties
@property (strong, nonatomic) IBOutlet UILabel *dcardOne;
@property (strong, nonatomic) IBOutlet UILabel *dcardTotal; //TODO: get rid of this when we don't need it, move to array
@property (strong, nonatomic) IBOutlet UILabel *dcardTwo;
@property (strong, nonatomic) IBOutlet UILabel *dcardThree;
@property (strong, nonatomic) IBOutlet UILabel *dcardFour;
@property (strong, nonatomic) IBOutlet UILabel *dcardFive;
@property (strong, nonatomic) NSMutableArray *dealershandofCards;
@property (strong, nonatomic) NSMutableArray *dealerCounts;

//Controls
@property (strong, nonatomic) IBOutlet UIButton *actionButton;

- (IBAction)buttonPressed:(id)sender;
- (RSPlayingCard*)dealCard:(BOOL)newHand toPlayer:(NSString*)player;

@end
