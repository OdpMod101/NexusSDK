#import <UIKit/UIKit.class>
#include <iostream>

// Definiujemy główny widok naszej aplikacji na telefonie
@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 1. Tworzymy okno aplikacji dopasowane do ekranu iPhone'a
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // 2. Prosty widok bazowy
    UIViewController *viewController = [[UIViewController alloc] init];
    viewController.view.backgroundColor = [UIColor colorWithRed:0.05 green:0.07 blue:0.09 alpha:1.0]; // Ciemne tło
    
    // 3. Tekst na środku ekranu
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 100)];
    label.center = viewController.view.center;
    label.text = @"NexusSDK iOS Launcher\nStatus: Aktywny\nSystem: Bez Gradle!";
    label.textColor = [UIColor systemGreenColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    label.font = [UIFont fontWithName:@"Courier-Bold" size:20];
    
    [viewController.view addSubview:label];
    self.window.rootViewController = viewController;
    [self.window makeKeyAndVisible];
    
    std::cout << "[NexusSDK iOS] Aplikacja wystartowała na iPhone!" << std::endl;
    return YES;
}
@end

// Główny punkt startowy aplikacji iOS
int main(int argc, char * argv[]) {
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
