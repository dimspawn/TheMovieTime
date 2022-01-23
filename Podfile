# Uncomment the next line to define a global platform for your project
platform :ios, '15.0'

source 'https://github.com/dimspawn/The-Movie-Time-CorePodSpecs'

use_frameworks!

workspace 'NewMovieTime'

target 'TheMovieTime' do
use_frameworks!
pod 'Alamofire', '~> 5.5'
pod 'RealmSwift', '~> 10.20'
pod 'SDWebImageSwiftUI', '~> 2.0'
pod 'Core'
end

target 'NowPlaying' do
project './Module/NowPlaying/NowPlaying'
pod 'Alamofire', '~> 5.5'
pod 'RealmSwift', '~> 10.20'
pod 'SDWebImageSwiftUI', '~> 2.0'
pod 'Core'
end

target 'Favorite' do
project './Module/Favorite/Favorite'
pod 'RealmSwift', '~> 10.20'
pod 'SDWebImageSwiftUI', '~> 2.0'
pod 'Core'
end

target 'Detail' do
project './Module/Detail/Detail'
pod 'Alamofire', '~> 5.5'
pod 'RealmSwift', '~> 10.20'
pod 'SDWebImageSwiftUI', '~> 2.0'
pod 'Core'
end

target 'MovieDomain' do
project './Module/MovieDomain/MovieDomain'
end

target 'Common' do
project './Module/Common/Common'
pod 'RealmSwift', '~> 10.20'
end