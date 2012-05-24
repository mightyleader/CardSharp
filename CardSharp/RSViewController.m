//
//  RSViewController.m
//  CardSharp
//
//  Created by Robert Stearn on 03.03.12.
//  Copyright (c) 2012 Cocoadelica. All rights reserved.
//
// **Coding standard**
// All curly braces on a new line. 
// Single space between operands and operators.
// No space between braces or brackets and operands.
// #define-ed constants start with k.
// Tab-indenting, 4 spaces per tab.
// TODO: indicates outstanding task
// DEBUG: indicates code to be removed before production
// **End Coding Standard**

#import "RSViewController.h"
#import "RSPhysicalCard.h"
#import "BCHeart.h"
#import "BCClub.h"
#import "BCSpade.h"
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
@synthesize aTotal, pTotal, adTotal, dTotal;

- (void)viewDidLoad
{
    [super viewDidLoad];
    playershandofCards = [[NSMutableArray alloc] initWithCapacity:10];
    dealershandofCards = [[NSMutableArray alloc] initWithCapacity:5];
	
	RSPhysicalCard *aCard = [[RSPhysicalCard alloc] initWithFrame:CGRectMake(-80, 100, 200, 300)];
	[self.view addSubview:aCard];
	RSPhysicalCard *bCard = [[RSPhysicalCard alloc] initWithFrame:CGRectMake(-80, -80, 200, 300)];
	[self.view addSubview:bCard];
	
	BCHeart *aHeart = [[BCHeart alloc] initWithFrame:CGRectMake(50, 50, 50, 60)];
	[self.view addSubview:aHeart];
	
	BCClub *aClub = [[BCClub alloc] initWithFrame:CGRectMake(50, 120, 50, 60)];
	[self.view addSubview:aClub];
	
	BCSpade *aSpade = [[BCSpade alloc] initWithFrame:CGRectMake(50, 240, 50, 60)];
	[self.view addSubview:aSpade];
	
	[self resetPlay];
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
	//TODO: Lot's of things to add here to make sure ARC works right
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
            [self randomoneoutofFour];
            break;
        case 102:
            if ((aceFlag == TRUE) && (aTotal <= 21)) {
                pTotal = aTotal;
            }
            aceFlag = FALSE;
            [self dealerLogic];
            [actionButton setEnabled:NO];	
            break;
        case 103:
            [self resetPlay];
            break;
        default:
            break;
    }
}

- (void)playerLogic
{
    //TODO: Handle 'Split' condition
    
    if ([playershandofCards count] == 5) 
    {
        [playershandofCards removeAllObjects]; //TODO: Extraneous? Might be, remove if so.
    }
    
    pTotal = [pcardTotal.text intValue]; //Carry over the running total
    
    pcardTotal.textColor = [UIColor whiteColor];
    pcardTotal.backgroundColor = [UIColor clearColor];
    
    RSPlayingCard* nextCard = [self dealCard:FALSE toPlayer:@"player"];
    [playershandofCards addObject:nextCard];
    
    pTotal = pTotal + [nextCard.cardValue intValue];
    aTotal = pTotal + 10; //only used when there's aces in places ;)
    
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
        [self resultHandler];
    }
	else 
	{
        pcardTotal.text = [NSString stringWithFormat:@"%i", pTotal];
        if (aceFlag && aTotal <= 21) 
        {
            pcardTotal.text = [pcardTotal.text stringByAppendingFormat:@" or %i", aTotal];
        }
		if ([playershandofCards count] == 1) 
		{
			[self performSelector:@selector(playerLogic) withObject:nil afterDelay:0.65]; 
		}
    }
}

- (void)dealerLogic
{
	dTotal = [dcardTotal.text intValue];
    
    //deal a card
    dcardTotal.textColor = [UIColor whiteColor];
    dcardTotal.backgroundColor = [UIColor clearColor];
    
    RSPlayingCard* nextCard = [self dealCard:FALSE toPlayer:@"dealer"];
    [dealershandofCards addObject:nextCard];
    
    dTotal = dTotal + [nextCard.cardValue intValue];
    adTotal = dTotal + 10; //only used when there's aces in places ;)
    
    //Ace detector
    if ([nextCard.cardValue intValue] == 1) 
    {
        aceFlag = TRUE; //Ace is back and he told you so.
    }
    
    //Set label text appropriately
    switch ([dealershandofCards count]) 
    {
        case 1:
            dcardOne.text = nextCard.cardText;
            break;
        case 2:
            dcardTwo.text = nextCard.cardText;
            break;
        case 3:
            dcardThree.text = nextCard.cardText;
            break;
        case 4:
            dcardFour.text = nextCard.cardText;
            break;
        case 5:
            dcardFive.text = nextCard.cardText;
            break;
        default:
            break;
    }
    if (dTotal > 21) //bust condition
    {
		NSLog(@"Over 21: Bust, %i/%i", dTotal, adTotal); //DEBUG
        dcardTotal.text = @"Bust!";
        dcardTotal.backgroundColor = [UIColor redColor];
        [self resultHandler];
    } 
    else if (dTotal > pTotal) //stand if dealers won but could still draw a card
    {
		NSLog(@"Dealer beats player: Stand, %i/%i", dTotal, adTotal); //DEBUG
		dcardTotal.text = [NSString stringWithFormat:@"%i", dTotal];
       [self performSelector:@selector(resultHandler) withObject:nil afterDelay:0.75];    
    }
	else if ((aceFlag == TRUE) && (adTotal > pTotal) && (adTotal <= 21)) //alt stand if dealers won but could still draw a card
    {
		NSLog(@"Alt Dealer beats player: Stand, %i/%i", dTotal, adTotal); //DEBUG
		dcardTotal.text = [NSString stringWithFormat:@"%i", adTotal];
		dTotal = adTotal;
		[self performSelector:@selector(resultHandler) withObject:nil afterDelay:0.75];    
    }
    else if ((dTotal < pTotal) && ([dealershandofCards count] < 5))  //always draw when losing to player
    {
		NSLog(@"Under pTotal and no 5CT: Draw, %i/%i", dTotal, adTotal); //DEBUG
        dcardTotal.text = [NSString stringWithFormat:@"%i", dTotal];
        if (aceFlag && adTotal <= 21) 
        {
			NSLog(@"Ace in the hand, appending alt score, %i/%i", dTotal, adTotal); //DEBUG
            dcardTotal.text = [dcardTotal.text stringByAppendingFormat:@" or %i", adTotal];
        }
        [self performSelector:@selector(dealerLogic) withObject:nil afterDelay:0.75];
    } 
	else if ((dTotal >= pTotal)) //stand if over or equal to player or 5 card trick
		//DEBUG  || ([dealershandofCards count] == 5)
    {
        NSLog(@">=19 or 5CT: Stand, %i/%i vs %i", dTotal, adTotal, pTotal); //DEBUG
		dcardTotal.text = [NSString stringWithFormat:@"%i", dTotal];
        if ((aceFlag == TRUE) && (adTotal <= 21)) 
        {
			NSLog(@"Ace in the hand, appending alt score, %i/%i", dTotal, adTotal); //DEBUG
            dcardTotal.text = [dcardTotal.text stringByAppendingFormat:@" or %i", adTotal];
			dTotal = adTotal;
        }
        [self performSelector:@selector(resultHandler) withObject:nil afterDelay:0.75];
    } 
	else if ([dealershandofCards count] == 5) 
	{
		NSLog(@"Five Card Trick, %i/%i", dTotal, adTotal); //DEBUG
		dTotal = 21, adTotal = 21;
		dcardTotal.text = @"Five card trick";
		[self performSelector:@selector(resultHandler) withObject:nil afterDelay:0.75];
	}
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
    int nextentry;
    int nextshuffledcard;
    RSPlayingCard *dealtCard;
    
    if ([player isEqualToString:@"player"]) 
    {
        nextentry = [playershandofCards count]; //effectively gives you the next index to deal a card to AND from. Nice.
        nextshuffledcard = [[[kDelegate shuffledDeckReference] objectAtIndex:nextentry] intValue];
        dealtCard = [[kDelegate referenceDeck].sortedDeck objectAtIndex:nextshuffledcard];
    }
         
    if ([player isEqualToString:@"dealer"]) 
    {
        nextentry = [dealershandofCards count] + 10; //yes, it's duplicated code but it's only 3 lines so deal with it. 'Deal'. Ha!
        nextshuffledcard = [[[kDelegate shuffledDeckReference] objectAtIndex:nextentry] intValue];
        dealtCard = [[kDelegate referenceDeck].sortedDeck objectAtIndex:nextshuffledcard];
    }
    return dealtCard;
}

- (void)resultHandler
{
	//TODO: Pay bet amount.
	
    NSLog(@"Player: %i/%i. Dealer: %i/%i", pTotal, aTotal, dTotal, adTotal);
	
	//TODO: This really doesn't work properly yet
	int playershighestHand;
	int dealershighestHand;
	NSString *titleString = [[NSString alloc] init];
	NSString *messageString = [[NSString alloc] init];
	
	if (pTotal > 21) 
	{
		playershighestHand = 0;
	} else {
		playershighestHand = pTotal;
	}
	
	if (dTotal > 21) 
	{
		dealershighestHand = 0;
	} else {
		dealershighestHand = dTotal;
	}
	
	if (playershighestHand > dealershighestHand) 
	{
		titleString = @"You won!";
		messageString = [NSString stringWithFormat:@"You scored %i, I scored %i", pTotal, dTotal];
	} else if (dealershighestHand > playershighestHand) 
	{
		titleString = @"You lost...";
		messageString = [NSString stringWithFormat:@"I scored %i, you scored %i", dTotal, pTotal];
	} else if (playershighestHand == dealershighestHand) 
	{
		titleString = @"It's a draw";
		messageString = [NSString stringWithFormat:@"We both scored %i", pTotal];
	}
	
	UIAlertView *resultView = [[UIAlertView alloc] initWithTitle:titleString 
														 message:messageString 
														delegate:self 
											   cancelButtonTitle:@"Play Again" 
											   otherButtonTitles: nil]; //TODO: Replace this with a custom presentation.
	[resultView show];
}

- (BOOL)randomoneoutofFour
{
	//TODO: No longer used.
    int randomNumber = arc4random() % 25; //random number from 0-25
    if ((randomNumber % 5) == 0) //does it divide evenly by 5?
    {
        return TRUE;
    }
    return FALSE; 
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
    pcardTotal.text = nil;
    dcardTotal.text = nil;
	pTotal = 0, dTotal = 0, aTotal = 0, adTotal = 0;
    pcardTotal.backgroundColor = [UIColor clearColor];
    dcardTotal.backgroundColor = [UIColor clearColor];
    aceFlag = FALSE;
    [playershandofCards removeAllObjects];
    [dealershandofCards removeAllObjects];
    [kDelegate newDeal];
    [actionButton setEnabled:YES];
	[self performSelector:@selector(playerLogic) withObject:nil afterDelay:0.75]; 
	
    
}

@end
