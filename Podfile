# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'TriviaDuels-ReSwift' do
  use_frameworks!

  pod 'ReSwift', '~> 4.0'
  pod 'ReSwiftRouter', :git => 'https://github.com/ReSwift/ReSwift-Router', :commit => 'c6216d2c040681c3c2474a3b00c70e81fc77e673'
  pod 'Alamofire'
  pod 'ObjectMapper'
  pod 'AlamofireObjectMapper'

  def testing_pods
    pod 'Quick'
    pod 'Nimble'
  end

  target 'TriviaDuels-ReSwiftTests' do
    inherit! :search_paths
    testing_pods
  end

  target 'TriviaDuels-ReSwiftUITests' do
    inherit! :search_paths
    testing_pods
  end

end
