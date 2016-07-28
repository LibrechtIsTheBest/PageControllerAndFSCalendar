
#import "ModelController.h"
#import "PageContentViewController.h"

@interface ModelController ()

@property (readonly, nonatomic) NSArray *pageData;

@end


@implementation ModelController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        _pageData = [[dateFormatter monthSymbols] copy];
        //        _pageData = [[Timetable alloc] init];
    }
    return self;
}

- (PageContentViewController *)viewControllerAtIndex:(NSInteger)index
{
    NSLog(@"viewControllerAtIndex %ld", index);
    
    // Return the data view controller for the given index.
    if (([self.pageData count] == 0) || (index >= [self.pageData count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    PageContentViewController *dataViewController = [[PageContentViewController alloc] init];
    dataViewController.contentObject = [self.pageData objectAtIndex:index];
    return dataViewController;
}

- (NSInteger)indexOfViewController:(PageContentViewController *)viewController
{
    // Return the index of the given data view controller.
    // For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
    return [self.pageData indexOfObject:viewController.contentObject];
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(PageContentViewController *)viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(PageContentViewController *)viewController];
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.pageData count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}


@end
