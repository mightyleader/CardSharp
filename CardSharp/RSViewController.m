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
@synthesize aceFlag;

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
    switch ([sender tag]) {
        case 101:
            [self playerLogic];
            break;
        case 102:
            [self dealerLogic];
            break;
        default:
            break;
    }
}

- (void)playerLogic
{
    //TODO: Handle 'Stand/Stick' action
    //TODO: Handle 'Split' condition
    //TODO: Handle dealers turn 
    
    if ([playershandofCards count] == 5) 
    {
        [playershandofCards removeAllObjects]; //TODO: Extraneous? Might be, remove if so.
    }
    
    int pTotal = [pcardTotal.text intValue]; //Carry over the running total
    
    pcardTotal.textColor = [UIColor whiteColor];
    pcardTotal.backgroundColor = [UIColor clearColor];
    
    RSPlayingCard* nextCard = [self dealCard:FALSE toPlayer:@"player"];
    [playershandofCards addObject:nextCard];
    
    pTotal = pTotal + [nextCard.cardValue intValue];
    int aTotal = pTotal + 10; //only used when there's aces in places ;)
    
    //Ace detector
    if ([nextCard.cardValue intValue] == 1) 
    {
        aceFlag = TRUE; //Ace is back and he told you so.
    }
    
    //Set label text appropriately
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
    
    if (pTotal > 21) 
    {
        pcardTotal.text = @"Bust!";
        pcardTotal.backgroundColor = [UIColor redColor];
        [playershandofCards removeAllObjects]; 
        [kDelegate newDeal];
        [self resetPlay];
        //TODO: Pay dealer bet amount.
    } else {
        pcardTotal.text = [NSString stringWithFormat:@"%i", pTotal];
        if (aceFlag && aTotal <= 21) 
        {
            pcardTotal.text = [pcardTotal.text stringByAppendingFormat:@" or %i", aTotal];
        }
    }
}

- (void)dealerLogic
{
    NSLog(@"Test button response");
    //deal a card
    // 0.5 second delay (user configurable
    //if total < 17 then draw [self dealerLogic];
    //if total => 18 then stand
    //if hand count == 5 then stand
    
}



- (void)betHandler
{
    
}

- (RSPlayingCard*)dealCard:(BOOL)newHand toPlayer:(NSString*)player
{
    if (newHand) 
    {
        [kDelegate newDeal]; //shuffles the deck
    }
    int nextentry = [playershandofCards count]; //effectively gives you the next index to deal a card to AND from. Nice.
    int nextshuffledcard = [[[kDelegate shuffledDeckReference] objectAtIndex:nextentry] intValue];
    RSPlayingCard *dealtCard = [[kDelegate referenceDeck].sortedDeck objectAtIndex:nextshuffledcard];
    
    return dealtCard;
}

- (void)resultHandler
{
    
}

- (void)resetPlay
{
    pcardOne.text = nil; 
    pcardTwo.text = nil; 
    pcardThree.text = nil; 
    pcardFour.text = nil; 
    pcardFive.text = nil;
    dcardOne.text = nil;
    dcardTwo.text = nil;
    dcardThree.text = nil;
    dcardFour.text = nil;
    dcardFive.text = nil;
    aceFlag = FALSE;
    [playershandofCards removeAllObjects];
    
}

@end
