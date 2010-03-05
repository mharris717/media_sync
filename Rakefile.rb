require 'rubygems'
require 'rake'
require 'fileutils'
load File.dirname(__FILE__) + "/constants.rb"

def ec(cmd)
  puts cms
  res = `#{cmd}`
  puts res
  res
end

def update
  ec "git pull origin master"
end

def copy_all
  copy_tv "Avatar"
end

def mkdir_if(dir)
  FileUtils.mkdir(dir) unless FileTest.exists?(dir)
end

def copy_tv(show)
  mkdir_if("#{ARCHOS_VIDEO_DIR}/TV")
  mkdir_if("#{ARCHOS_VIDEO_DIR}/TV/#{show}")
  Dir["I:/LinkDir/#{show}/*"].each do |dir|  
    mkdir_if("#{ARCHOS_VIDEO_DIR}/TV/#{show}/#{dir}")
  end
  Dir["I:/LinkDir/#{show}/*/*.*"].each do |file|
    trimmed_file = file.split("/")[-3..-1].join("/")
    FileUtils.cp file, "#{ARCHOS_VIDEO_DIR}/TV/#{trimmed_file}"
  end
end

copy_all