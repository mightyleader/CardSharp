//
//  RSAppDelegate.m
//  CardSharp
//
//  Created by Robert Stearn on 03.03.12.
//  Copyright (c) 2012 Cocoadelica. All rights reserved.
//

#import "RSAppDelegate.h"

@implementation RSAppDelegate

@synthesize window = _window;
@synthesize referenceDeck = _referenceDeck;
@synthesize shuffledDeckReference = _shuffledDeckReference;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self referenceDeck];
    [self shuffledDeckReference];
    // Override point for customization after application launch.
    return YES;
}

- (RSPackofCards*)referenceDeck
{
    if (_referenceDeck == nil) 
    {
       _referenceDeck = [[RSPackofCards alloc] init];
    }
    return _referenceDeck;
}

- (void)newDeal
{
    [_shuffledDeckReference removeAllObjects];
    _shuffledDeckReference = nil;
    [self shuffledDeckReference];
    
//    for (int randomcard = 0; randomcard < [_shuffledDeckReference count]; randomcard++) 
//    {
//        int nextcard = [[_shuffledDeckReference objectAtIndex:randomcard] intValue];
//        RSPlayingCard *foundCard = [[self referenceDeck].sortedDeck objectAtIndex:nextcard];
//        NSLog(@"%@, %@", foundCard.longName, foundCard.cardText);
//    } DEBUG

}

- (NSMutableArray*)shuffledDeckReference
{
    if (_shuffledDeckReference == nil) 
    {
        _shuffledDeckReference = [[NSMutableArray alloc] init];
        //fill with random numbers from 0 - 52 as index references against the referenceDeck.
        int n = 52;
        NSMutableArray *numbers = [NSMutableArray array];
        for (int i = 0; i < n; i++) 
        {
            [numbers addObject:[NSNumber numberWithInt:i]];
        }
        NSMutableArray *result = [NSMutableArray array];
        while ([numbers count] > 0) 
        {
            int r = arc4random() % [numbers count];
            NSNumber *randomElement = [numbers objectAtIndex:r];
            [result addObject:randomElement];
            [numbers removeObjectAtIndex:r];
        }
        _shuffledDeckReference = result;
    }
    return _shuffledDeckReference;
}


							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
