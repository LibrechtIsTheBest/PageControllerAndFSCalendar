
#import "RootViewController.h"
#import "ModelController.h"
#import "PageContentViewController.h"
#import "FSCalendar.h"

@interface RootViewController () <UIPageViewControllerDelegate, FSCalendarDelegate>

@property (strong, nonatomic) IBOutlet FSCalendar *calendarView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *calendarHeightConstraint;


@property (nonatomic) UIPageViewController *pageViewController;
@property (readonly, nonatomic) ModelController *modelController;

@end

@implementation RootViewController

@synthesize modelController = _modelController;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /* 
     Page View Controller Setup
     */
    // Do any additional setup after loading the view, typically from a nib.
    // Configure the page view controller and add it as a child view controller.
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageViewController.delegate = self;
    
//    PageContentViewController *startingViewController = [self.modelController viewControllerAtIndex:0];
    PageContentViewController *startingViewController = [self.modelController viewControllerForDate:[NSDate date]];

    
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    self.pageViewController.dataSource = self.modelController;
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    
    // Set the page view controller's bounds using an inset rect so that self's view is visible around the edges of the pages.
    CGRect pageViewRect = self.view.bounds;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        pageViewRect = CGRectInset(pageViewRect, 40.0, 40.0);
    }
    self.pageViewController.view.frame = pageViewRect;
    
    [self.pageViewController didMoveToParentViewController:self];
    
    /*
     Calendar setup
     */
    self.calendarView.scope = FSCalendarScopeWeek;
    self.calendarView.locale = [NSLocale localeWithLocaleIdentifier:@"ru-RU"];
    [self.calendarView.appearance setHeaderDateFormat:@"LLLL yyyy"];
    self.calendarView.firstWeekday = 2;
    [self.calendarView selectDate:[NSDate date]];
}

- (void)calendar:(FSCalendar *)calendar boundingRectWillChange:(CGRect)bounds animated:(BOOL)animated
{
    self.calendarHeightConstraint.constant = CGRectGetHeight(bounds);
    [self.view layoutIfNeeded];
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGFloat y = self.calendarView.frame.origin.y + self.calendarView.frame.size.height;
    self.pageViewController.view.frame = CGRectMake(0, y, screenBounds.size.width, screenBounds.size.height - y);
}

- (ModelController *)modelController
{
    // Return the model controller object, creating it if necessary.
    // In more complex implementations, the model controller may be passed to the view controller.
    if (!_modelController) {
        _modelController = [[ModelController alloc] init];
    }
    return _modelController;
}

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date
{
//    NSLog(@"did select date %@", [calendar stringFromDate:date format:@"yyyy/MM/dd"]);
    
    NSLog(@"did select date %@", date);
    
    PageContentViewController *p = [self.modelController viewControllerForDate:[date dateByAddingTimeInterval:24*60*60]];
    
    NSLog(@"%@", p.contentObject);
    
    [self.pageViewController setViewControllers:@[p] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:NULL];
    
//    self.subjects = [self.timeTable subjectsAtDate:self.calendarView.selectedDate];
//    [self.subjectsTableView reloadData];
}

- (void)calendarCurrentPageDidChange:(FSCalendar *)calendar
{
    NSLog(@"%s %@", __FUNCTION__, [calendar stringFromDate:calendar.currentPage]);
}

#pragma mark - UIPageViewControllerDelegate

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed
{
    NSLog(@"%d %d\n%@", finished, completed, ((PageContentViewController *)pageViewController.viewControllers.firstObject).contentObject);
    
//    [self.calendarView deselectDate:((PageContentViewController *)pageViewController.viewControllers.firstObject).contentObject];
    [self.calendarView selectDate:[((PageContentViewController *)pageViewController.viewControllers.firstObject).contentObject dateByAddingTimeInterval:(-24*60*60)]];
}

@end

