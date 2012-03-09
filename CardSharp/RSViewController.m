//
//  RSViewController.m
//  CardSharp
//
//  Created by Robert Stearn on 03.03.12.
//  Copyright (c) 2012 Cocoadelica. All rights reserved.
//

#import "RSViewController.h"
#define kDelegate (RSAppDelegate*)[[UIApplication sharedApplication] delegate]

@interface RSViewController ()

@end

@implementation RSViewController
@synthesize dcardOne;
@synthesize dcardTotal;
@synthesize dcardTwo;
@synthesize dcardThree;
@synthesize dcardFour;
@synthesize dcardFive;
@synthesize actionButton;
@synthesize pcardOne;
@synthesize pcardTwo;
@synthesize pcardThree;
@synthesize pcardFour;
@synthesize pcardFive;
@synthesize pcardTotal;
@synthesize playershardofCards;
@synthesize dealershandofCards;
@synthesize playerCounts;
@synthesize dealerCounts;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setPcardOne:nil];
    [self setPcardTwo:nil];
    [self setPcardThree:nil];
    [self setPcardFour:nil];
    [self setPcardFive:nil];
    [self setPcardTotal:nil];
    [self setDcardOne:nil];
    [self setDcardTotal:nil];
    [self setDcardTwo:nil];
    [self setDcardThree:nil];
    [self setDcardFour:nil];
    [self setDcardFive:nil];
    [self setActionButton:nil];
    [self setPlayershardofCards:nil];
    [self setPlayerCounts:nil];
    [self setDealerCounts:nil];
    [self setDealershandofCards:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)buttonPressed:(id)sender 
{
    int pTotal = 0;
    int altTotal = 0;
    [kDelegate newDeal];
    
    //First player card
    int nextcard = [[[kDelegate shuffledDeckReference] objectAtIndex:0] intValue];
    pcardOne.text = [[[kDelegate referenceDeck].sortedDeck objectAtIndex:nextcard] cardText];
    if ([[[kDelegate referenceDeck].sortedDeck objectAtIndex:nextcard] altValue] != nil) {
        altTotal = altTotal + [[[[kDelegate referenceDeck].sortedDeck objectAtIndex:nextcard] altValue] intValue];
        pTotal = pTotal + [[[[kDelegate referenceDeck].sortedDeck objectAtIndex:nextcard] cardValue] intValue];
    } else {
        pTotal = pTotal + [[[[kDelegate referenceDeck].sortedDeck objectAtIndex:nextcard] cardValue] intValue];
    }
    
    //Second player card
    nextcard = [[[kDelegate shuffledDeckReference] objectAtIndex:1] intValue];
    pcardTwo.text = [[[kDelegate referenceDeck].sortedDeck objectAtIndex:nextcard] cardText];
    if ([[[kDelegate referenceDeck].sortedDeck objectAtIndex:nextcard] altValue] != nil && altTotal > 0) {
        altTotal = altTotal + [[[[kDelegate referenceDeck].sortedDeck objectAtIndex:nextcard] altValue] intValue];
        pTotal = pTotal + [[[[kDelegate referenceDeck].sortedDeck objectAtIndex:nextcard] cardValue] intValue];
    } else if ([[[kDelegate referenceDeck].sortedDeck objectAtIndex:nextcard] altValue] != nil && altTotal == 0) {
        
    } else {
        pTotal = pTotal + [[[[kDelegate referenceDeck].sortedDeck objectAtIndex:nextcard] cardValue] intValue];
    }
    
    //Update the total
    if (altTotal == 0) {
        pcardTotal.text = [NSString stringWithFormat:@"%i", pTotal];
    } else {
        pcardTotal.text = [NSString stringWithFormat:@"%i/%i", pTotal, altTotal];
    }
    
}

- (void)dealCard
{
    
}

@end
