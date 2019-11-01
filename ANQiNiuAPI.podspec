Pod::Spec.new do |s|
    s.name = 'ANQiNiuAPI'
    s.version = '2.1.0'
    s.license = 'MIT'
    s.summary = 'ANQiNiuAPI'
    s.homepage = 'https://github.com/anotheren/ANQiNiuAPI'
    s.authors = {
        'anotheren' => 'liudong.edward@gmail.com',
    }
    s.source = { :git => 'https://github.com/anotheren/ANQiNiuAPI.git', :tag => s.version }
    s.ios.deployment_target = '10.0'
    s.swift_versions = ['5.0', '5.1']
    s.source_files = 'Sources/**/*.swift'
    s.frameworks = 'Foundation'
    
    s.dependency 'SwiftyJSON'
    s.dependency 'CryptoSwift'
    s.dependency 'ANBaseNetwork'
    
end
