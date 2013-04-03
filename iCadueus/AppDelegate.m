//
//  AppDelegate.m
//  iCadueus
//
//  Created by Les Brown on 8/24/12.
//  Copyright (c) 2012 Les Brown. All rights reserved.
//

#import "AppDelegate.h"

#import "HomeViewController.h"
#import "SearchViewController.h"
#import "FavoritesViewController.h"
#import "InformationViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    UIViewController *homeController = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
    homeController.tabBarItem= [[UITabBarItem alloc] initWithTitle:@"Home" image:[UIImage imageNamed:@"house.png"] tag:0];
    
    UIViewController *searchController = [[SearchViewController alloc] initWithNibName:@"SearchViewController" bundle:nil];
    searchController.tabBarItem= [[UITabBarItem alloc] initWithTitle:@"Search" image:[UIImage imageNamed:@"search.png"] tag:0];
    
    UIViewController *favoritesController = [[FavoritesViewController alloc] initWithNibName:@"FavoritesViewController" bundle:nil];
    favoritesController.tabBarItem= [[UITabBarItem alloc] initWithTitle:@"Favorites" image:[UIImage imageNamed:@"star.png"] tag:0];
    
    UIViewController *informationController = [[InformationViewController alloc] initWithNibName:@"InformationViewController" bundle:nil];
    informationController.tabBarItem= [[UITabBarItem alloc] initWithTitle:@"Info" image:[UIImage imageNamed:@"info.png"] tag:0];
    

    
    
 
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = @[homeController, searchController,favoritesController,informationController];
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    return YES;
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

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

@end
