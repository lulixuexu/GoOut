//
//  GOBaseMapViewController.m
//  GoOut
//
//  Created by Liang GUO on 7/25/14.
//  Copyright (c) 2014 bst. All rights reserved.
//
#define WALKSPEED 2.8f
#import "GOBaseMapViewController.h"
#import "GONetworkController.h"
#import "GOCommon.h"
#import "GODocument.h"


enum{
    OverlayViewControllerOverlayTypeCircle = 0,
    OverlayViewControllerOverlayTypePolyline,
    OverlayViewControllerOverlayTypePolygon
};

@interface GOBaseMapViewController ()
@property (nonatomic, strong) NSMutableArray *overlays;
@end

@implementation GOBaseMapViewController
#pragma mark -- Initiation
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)initMapView
{
    _mapView = [[MAMapView alloc]init];
    //_mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.frame = CGRectMake(0,TOPBARHEIGHT+STATUSBARHEIGHT, 320, 400);
    self.mapView.delegate = self;
    
    [self.view addSubview:self.mapView];
    
    self.mapView.visibleMapRect = MAMapRectMake(220880104, 101476980, 272496, 466656);
}
- (void)initSearch
{
    _search = [[AMapSearchAPI alloc]initWithSearchKey:(NSString *)APIKey Delegate:self];
    //_search.delegate = self;
}
- (void)initSubView
{
    UIButton* but = [[UIButton alloc]initWithFrame:CGRectMake(0, _mapView.frame.origin.y+400, 320, 40)];
    [but setTitle:@"getLocation" forState:UIControlStateNormal];
    [but addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    but.backgroundColor = BUTTON_COLOR;
    [self.view addSubview:but];
}
- (void)configureAPIKey
{
    if ([APIKey length] == 0)
    {
        NSString *name   = [NSString stringWithFormat:@"\nSDKVersion:%@\nFILE:%s\nLINE:%d\nMETHOD:%s", [MAMapServices sharedServices].SDKVersion, __FILE__, __LINE__, __func__];
        NSString *reason = [NSString stringWithFormat:@"请首先配置APIKey.h中的APIKey, 申请APIKey参考见 http://api.amap.com"];
        
        @throw [NSException exceptionWithName:name
                                       reason:reason
                                     userInfo:nil];
    }
    
    [MAMapServices sharedServices].apiKey = (NSString *)APIKey;
}
- (void)initOverlays
{
    self.overlays = [NSMutableArray array];
    
    GODocument* doc = [GODocument fetchDocument];
    
    /* Polygon. */
    //NSMutableArray* coordinates = [NSMutableArray array];
    NSString* temp;
    CLLocationCoordinate2D coordinates[doc.convex_hull.count];
    for (int i =0; i<doc.convex_hull.count; i++) {
        temp = [doc.convex_hull[i]objectForKey:@"latitude"];
        coordinates[i].latitude = [temp floatValue];
        
        temp = [doc.convex_hull[i]objectForKey:@"longitude"];
        coordinates[i].longitude = [temp floatValue];
    }
    MAPolygon *polygon = [MAPolygon polygonWithCoordinates:coordinates count:doc.convex_hull.count];
    [self.overlays insertObject:polygon atIndex:0];
    [_mapView addOverlays:_overlays];
}
- (void)initAnnotation
{
    NSMutableArray *annotations = [NSMutableArray array];
     GODocument* doc = [GODocument fetchDocument];
    
    NSString* temp;
    double latitude,longitude;
    for (int i =0; i<doc.convex_hull.count; i++) {
        temp = [doc.convex_hull[i]objectForKey:@"latitude"];
        latitude = [temp floatValue];
        
        temp = [doc.convex_hull[i]objectForKey:@"longitude"];
        longitude = [temp floatValue];
        
        MAPointAnnotation *red = [[MAPointAnnotation alloc] init];
        red.coordinate = CLLocationCoordinate2DMake(latitude, longitude);
        red.title      = @"Red";
        [annotations insertObject:red atIndex:i];
    }
    [_mapView addAnnotations:annotations];
}
#pragma mark -- Event control
- (void)buttonAction:(UIButton*)sender
{
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    
    //[[GONetworkController sharedController]fetchUserTerritory];
    //[_mapView addOverlays:_overlays];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSInteger resultIdentifier = [[change objectForKey:@"new"] integerValue];
    switch (resultIdentifier) {
        case UPDATELOC_SUCCESS:
        {
            [GOCommon showHUDWithText:@"定位成功"];
            [self initAnnotation];
            [self initOverlays];
        }
            break;
        case UPDATELOC_FAILURE:
        {
            [GOCommon showHUDWithText:@"定位错误"];
        }
            break;
        case UPDATELOC_TIME_OUT:
        {
            [GOCommon showHUDWithText:@"无法连接服务器"];
        }
            break;
        case FETCH_CONVEX_HULL_SUCCESS:
        {
            [self initAnnotation];
            [self initOverlays];
        }
            break;
        case FETCH_CONVEX_HULL_FAILURE:
        {
            
        }
            break;
        case FETCH_CONVEX_HULL_TIME_OUT:
        {
            
        }
            break;
        default:
            break;
    }
}
#pragma mark -- private methods
- (void)searchReGeocodeWithCoordinate:(CLLocationCoordinate2D)coordinate
{
    AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
    
    regeo.location = [AMapGeoPoint locationWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    regeo.requireExtension = YES;
    
    [_search AMapReGoecodeSearch:regeo];
}
#pragma mark -- AMapSearchDelegate

/* 逆地理编码回调. */
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    if (response.regeocode != nil)
    {
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(request.location.latitude, request.location.longitude);
        NSString* cityName =  response.regeocode.addressComponent.province;
        [[GONetworkController sharedController]updateUserLocation:coordinate.latitude longitude:coordinate.longitude city:cityName];
    }
}
#pragma mark -- MapView Delegate Methods
- (void)mapViewWillStartLocatingUser:(MAMapView *)mapView
{
    //start track user location info
    //add some filter to track desired location info
    _mapView.desiredAccuracy = 100.f; //less than 100 meters
    _mapView.distanceFilter = 1.f;    //update once move 1 meter
}
- (void)mapViewDidStopLocatingUser:(MAMapView *)mapView
{
    
}
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
{
    CLLocationSpeed speed =  userLocation.location.speed; // desired speed is less than 2.8 m/s
    //for test
    speed = 1;
    if (speed>0.f && speed <= WALKSPEED && userLocation.location != nil) {
        //desired location info report to server
        CLLocationCoordinate2D location = userLocation.location.coordinate;
        [self searchReGeocodeWithCoordinate:location];
    }
}
- (void)mapView:(MAMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"%@",error);
}
- (MAOverlayRenderer *)mapView:(MAMapView *)mapView viewForOverlay:(id <MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MACircle class]])
    {
        MACircleRenderer *circleRenderer = [[MACircleRenderer alloc] initWithCircle:overlay];
        
        circleRenderer.lineWidth   = 4.f;
        circleRenderer.strokeColor = [UIColor blueColor];
        circleRenderer.fillColor   = [UIColor colorWithRed:1 green:0 blue:0 alpha:.3];
        
        return circleRenderer;
    }
    else if ([overlay isKindOfClass:[MAPolygon class]])
    {
        MAPolygonRenderer *polygonRenderer = [[MAPolygonRenderer alloc] initWithPolygon:overlay];
        polygonRenderer.lineWidth   = 4.f;
        polygonRenderer.strokeColor = [UIColor colorWithRed:0 green:1 blue:0 alpha:1];
        polygonRenderer.fillColor   = [UIColor colorWithRed:1 green:0 blue:0 alpha:.3];
        
        return polygonRenderer;
    }
    else if ([overlay isKindOfClass:[MAPolyline class]])
    {
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
        
        polylineRenderer.lineWidth   = 4.f;
        polylineRenderer.strokeColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:1];
        
        return polylineRenderer;
    }
    
    return nil;
}
#pragma mark -- life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configureAPIKey];
    [self initMapView];
    [self initSearch];
    [self initSubView];
    [[GONetworkController sharedController] addObserver:self forKeyPath:@"resultIdentifier" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    //remove observer to the resultIdentifier value change in NetworkControl
    [[GONetworkController sharedController] removeObserver:self forKeyPath:@"resultIdentifier"];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
