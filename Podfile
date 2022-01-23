# Uncomment the next line to define a global platform for your project
platform :ios, '15.0'

source 'https://github.com/dimspawn/The-Movie-Time-CorePodSpecs'

use_frameworks!

workspace 'NewMovieTime'

def net_pods
pod 'Alamofire', '~> 5.5'
end

def shared_pods
pod 'RealmSwift', '~> 10.20'
pod 'SDWebImageSwiftUI', '~> 2.0'
end

target 'TheMovieTime' do
use_frameworks!
net_pods
shared_pods
pod 'Core'
end

target 'NowPlaying' do
project './Module/NowPlaying/NowPlaying'
net_pods
shared_pods
pod 'Core'
end

target 'Favorite' do
project './Module/Favorite/Favorite'
shared_pods
pod 'Core'
end

target 'Detail' do
project './Module/Detail/Detail'
net_pods
shared_pods
pod 'Core'
end

target 'MovieDomain' do
project './Module/MovieDomain/MovieDomain'
end

target 'Common' do
project './Module/Common/Common'
shared_pods
end