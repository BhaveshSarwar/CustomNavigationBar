
Pod::Spec.new do |s|

# this should be your podName which has to exact same as your project name

  s.name             = 'CustomNavigationBar'

# Pod version should be the release number which you have published on github
  s.version          = '0.1.0'
# Summary about the pod which has be bigger in length than the name

  s.summary          = 'Customise navigation bar height '
# Description should be bigger than the summary
  s.description      = <<-DESC
  This can help to customise the height of navigation bar Navigation bar provides default back button and title
                       DESC
#  This has to be url of your git project
  s.homepage         = 'https://github.com/BhaveshSarwar/CustomNavigationBar'
# You have to add license file in your project which has this same name
  # License file copied from internet for the sample
#  This file should be present in the folder where podpsec file is availale
#  Need to mention the license file name in below line
  s.license          = { :type => 'MIT', :file => 'LICENSE' }

# It has to be author
  s.author           = { 'Bhavesh Sarwar' => 'bsarwar@inspeero.com' }
# This should be your cloning url
  s.source           = { :git => 'https://github.com/BhaveshSarwar/CustomNavigationBar.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'
  s.swift_version = '3.2'
# You can declare here which swift files has to be included in pod files
  s.source_files = 'Custom\ NavigationBarLib/*'

end
