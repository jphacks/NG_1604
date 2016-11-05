# platform :ios, '9.0'
use_frameworks!

target 'OASIS' do

    # infra
    pod 'Firebase/Core'
    pod 'Firebase/Messaging'
    pod 'Firebase/Database'
    pod 'Firebase/Auth'

    # auth
    pod 'FacebookCore'
    pod 'FacebookLogin'

    # network
    pod 'Alamofire', '~> 3.5'

    # util
    pod 'SwiftTask', git: 'https://github.com/ReactKit/SwiftTask.git', branch: 'swift/3.0'
    pod 'Himotoki', '~> 3.0'

    # view
    pod 'Kingfisher', '~> 3.0'
    pod 'Spring', git: 'https://github.com/MengTo/Spring.git', branch: 'swift3'
    pod 'XLPagerTabStrip', '6.0'
    pod 'JSQMessagesViewController'
    pod 'Eureka', '~> 2.0.0-beta.1'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
