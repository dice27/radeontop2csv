#! /usr/bin/env ruby

def is_valid_argument?
  ARGV.size() == 1 and File.exist?(ARGV[0])
end

def get_time (src)
  return Time.at(src[/.*?:/].gsub(/:/, '').to_i).to_s
end

def format_line (line)
  return line.gsub(/(\s|　|[a-zA-Z%])+/, '').gsub(/.*?:/, get_time(line) + ',')
end

def convert (target)
  File.open('result.csv','w') do |result_file|
    result_file.puts('Time,Graphics pipe,Event Engine,Vertex Grouper + Tesselator,Texture Addresser,Shader Export,Sequencer Instruction Cache,Shader Interpolator,Scan Converter,Primitive Assembly,Depth Block,Color Block')
    File.open(target) do |file|
      file.each_line do |line|
        result_file.puts(format_line(line))
      end
    end
  end
end

if __FILE__ == $0
  if is_valid_argument? then
    convert(ARGV[0])
  end
end
