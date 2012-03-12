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
    int pTotal = [pcardTotal.text intValue];
    //int altTotal = 0;
    
    RSPlayingCard* nextCard = [self dealCard:FALSE toPlayer:@"player"];
    [playershardofCards addObject:nextCard];
    
    NSLog(@"%i", [nextCard.cardValue intValue]);
    
    if ((pTotal + [nextCard.cardValue intValue]) > 21) 
    {
        pcardTotal.text = @"Bust!";
        pcardTotal.textColor = [UIColor redColor];
    } else {
        pTotal = pTotal + [nextCard.cardValue intValue];
        pcardTotal.text = [NSString stringWithFormat:@"%i", pTotal];
    }
    

    
}

- (RSPlayingCard*)dealCard:(BOOL)newHand toPlayer:(NSString*)player
{
    if (newHand) 
    {
        [kDelegate newDeal]; //shuffles the deck
    }
    int nextentry = [playershardofCards count]; //effectively gives you the next place to deal a card into AND from. Nice.
    int nextshuffledindex = [[[kDelegate shuffledDeckReference] objectAtIndex:nextentry] intValue];
    RSPlayingCard *dealtCard = [[kDelegate referenceDeck].sortedDeck objectAtIndex:nextshuffledindex];
    
    return dealtCard;

}

@end
