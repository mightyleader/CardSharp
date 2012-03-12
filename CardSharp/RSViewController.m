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
@synthesize playershandofCards;
@synthesize dealershandofCards;
@synthesize playerCounts;
@synthesize dealerCounts;

- (void)viewDidLoad
{
    [super viewDidLoad];
    playershandofCards = [[NSMutableArray alloc] initWithCapacity:10];
    dealershandofCards = [[NSMutableArray alloc] initWithCapacity:5];
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
    [self setPlayershandofCards:nil];
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
    pcardTotal.textColor = [UIColor blackColor];
    
    RSPlayingCard* nextCard = [self dealCard:FALSE toPlayer:@"player"];
    [playershandofCards addObject:nextCard];
    
    switch ([playershandofCards count]) 
    {
        case 1:
            pcardOne.text = nextCard.cardText;
            break;
        case 2:
            pcardTwo.text = nextCard.cardText;
            break;
        case 3:
            pcardThree.text = nextCard.cardText;
            break;
        case 4:
            pcardFour.text = nextCard.cardText;
            break;
        case 5:
            pcardFive.text = nextCard.cardText;
            break;
        default:
            break;
    }
    
    if ((pTotal + [nextCard.cardValue intValue]) > 21) 
    {
        pcardTotal.text = @"Bust!";
        pcardTotal.textColor = [UIColor redColor];
        [kDelegate newDeal];
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
    int nextentry = [playershandofCards count]; //effectively gives you the next place to deal a card into AND from. Nice.
    int nextshuffledindex = [[[kDelegate shuffledDeckReference] objectAtIndex:nextentry] intValue];
    RSPlayingCard *dealtCard = [[kDelegate referenceDeck].sortedDeck objectAtIndex:nextshuffledindex];
    
    return dealtCard;

}

@end
