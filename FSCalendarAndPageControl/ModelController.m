
#import "ModelController.h"
#import "PageContentViewController.h"

@interface ModelController ()

//@property (readonly, nonatomic) NSArray *pageData;

//@property (nonatomic) PageContentViewController *leftPageContentViewController;
//@property (nonatomic) PageContentViewController *centralPageContentViewController;
//@property (nonatomic) PageContentViewController *rightPageContentViewController;

@end


@implementation ModelController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
//        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//        _pageData = [[dateFormatter monthSymbols] copy];
        //        _pageData = [[Timetable alloc] init];
        
//        self.leftPageContentViewController = [[PageContentViewController alloc] init];
//        self.centralPageContentViewController = [[PageContentViewController alloc] init];
//        self.rightPageContentViewController = [[PageContentViewController alloc] init];
    }
    return self;
}

- (PageContentViewController *)viewControllerForDate:(NSDate *)date
{
//    NSLog(@"%s %@", __PRETTY_FUNCTION__, date);
    
    PageContentViewController *p = [PageContentViewController new];
    p.contentObject = date;
    
    return p;
}

//- (PageContentViewController *)viewControllerAtIndex:(NSInteger)index
//{
//    NSLog(@"viewControllerAtIndex %ld", index);
//    
//    // Return the data view controller for the given index.
//    if (([self.pageData count] == 0) || (index >= [self.pageData count])) {
//        return nil;
//    }
//    
//    // Create a new view controller and pass suitable data.
////    PageContentViewController *dataViewController = [[PageContentViewController alloc] init];
//    self.pageContentViewController.contentObject = [self.pageData objectAtIndex:index];
//    return dataViewController;
//}

//- (NSInteger)indexOfViewController:(PageContentViewController *)viewController
//{
//    // Return the index of the given data view controller.
//    // For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
//    return [self.pageData indexOfObject:viewController.contentObject];
//}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
//    NSLog(@"%s %@", __PRETTY_FUNCTION__, viewController);
    
    PageContentViewController *p = [PageContentViewController new];
    p.contentObject = [NSDate dateWithTimeInterval:(-24*60*60) sinceDate:((PageContentViewController *)viewController).contentObject];
    
    return p;
    
//    NSUInteger index = [self indexOfViewController:(PageContentViewController *)viewController];
//    if ((index == 0) || (index == NSNotFound)) {
//        return nil;
//    }
//    
//    index--;
//    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
//    NSLog(@"%s %@", __PRETTY_FUNCTION__, viewController);
    
    PageContentViewController *p = [PageContentViewController new];
    p.contentObject = [NSDate dateWithTimeInterval:(24*60*60) sinceDate:((PageContentViewController *)viewController).contentObject];
    
    return p;
    
//    NSUInteger index = [self indexOfViewController:(PageContentViewController *)viewController];
//    if (index == NSNotFound) {
//        return nil;
//    }
//    
//    index++;
//    if (index == [self.pageData count]) {
//        return nil;
//    }
//    return [self viewControllerAtIndex:index];
}


@end
