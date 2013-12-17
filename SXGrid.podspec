Pod::Spec.new do |s|
  s.name         = "SXGrid"
  s.version      = "0.0.1"
  s.summary      = "A set of Objective-C classes for working with grids and two-dimensional arrays of objects."
  s.description  = <<-DESC
                   SXGrid is a small set of classes inspired by NSArray and NSMutableArray for modeling and working with grids and two-dimensional arrays in Objective-C.

                   * Helps avoid repetitive nested for loops for working with grid data
                   * Uses blocks to provide powerful transformation capabilities
                   DESC
                   
  s.homepage     = "http://www.jasonwjones.com/projects/SXGrid"
  s.license      = 'Apache License, Version 2.0'
  s.author       = { "Jason Jones" => "jasonwjones@gmail.com" }
  s.platform     = :ios
  s.source       = { :git => "https://github.com/jasonwjones/SXGrid.git", :tag => "0.0.1" }
  s.source_files  = 'SXGrid'
  s.exclude_files = 'SXGrid/*.pch'
  s.requires_arc = true
end
