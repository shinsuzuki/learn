#----------------------------------------------------------------------------- my_module.rb
# -*- coding: utf-8 -*-

#-------------------------------------------------------------------------------
# module:FileUtilty
#-------------------------------------------------------------------------------
module FileUtilty

  require 'find'
  
  #
  #ファイルから内容を取得します
  #
  #（例）data_lines = read_file("test_utf8.txt","r:UTF-8");
  #
  def read_file(file_path, mode)
    data_lines=[]
      
    File.open(file_path, mode) do |f|
      while line = f.gets
        data_lines.push(line.chomp())
      end
    end  
  
    return data_lines
  end
  
  #
  #ファイルに保存します
  #
  #（例）write_file("save_test.txt","w:UTF-8",data_lines)
  #
  def write_file(file_path, mode, lines)
    File.open(file_path, mode) do |f|
      lines.each do |line| 
        f.puts line;
      end  
    end
  end
 
  
  #
  #指定ディレクトリのファイルを取得します
  #
  def get_filenames(dir, extname)
    files = []
    
    Find.find(dir) do |f|
      if File.file? f
        if File.extname(f) == extname
          files.push(f)
        end
      end
    end
    
    return files
  end
  
end