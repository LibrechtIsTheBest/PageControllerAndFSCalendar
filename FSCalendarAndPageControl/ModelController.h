
#import <UIKit/UIKit.h>

@class PageContentViewController;

@interface ModelController : NSObject <UIPageViewControllerDataSource>

- (PageContentViewController *)viewControllerForDate:(NSDate *)date;
//- (NSDate *)dateOfViewController:(PageContentViewController *)viewController;

//- (PageContentViewController *)viewControllerAtIndex:(NSInteger)index;
//- (NSInteger)indexOfViewController:(PageContentViewController *)viewController;

@end
