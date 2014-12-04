#encoding: utf-8
require 'open-uri'
hosts_file = "/etc/hosts"
action = ARGV.size > 0 && ARGV[0] == 'delete' ? 'delete' : 'update'

def read_hosts(file)
  File.exists?(file) ? File.open(file, 'rb') {|file| file.read} : ''
end

def write_hosts(file, content)
  File.open(file, 'wb') {|file| file << content}
end

def match_host_content
  begin
    open('http://www.360kb.com/kb/2_122.html') do |f|
      content = f.read
      if content =~ /<span>#base services<\/span>(.*?)<span>#base services<\/span>/m
        result = $1.scan(/<span>(.*)<\/span>/)
        result.map! {|res| res[0].gsub '&nbsp;', ''}.flatten
      else
        nil
      end
    end
  rescue
    nil
  end
end

if action == 'update'
  host_arr = match_host_content
  if host_arr
    write_content = "#google_host_start\n" + host_arr.join("\n") + "\n#google_host_end\n"
    if File.exists? hosts_file
      hosts_file_content = read_hosts(hosts_file)
      if hosts_file_content =~ /#google_host_start.*#google_host_end/m
        write_content = hosts_file_content.sub(/#google_host_start(.*)#google_host_end/m, write_content)
      else
        write_content = hosts_file_content + "\n" + write_content
      end
    end
    write_hosts hosts_file, write_content
    puts "update success..."
  else
    puts 'match host content fail...'
  end
else
  hosts_file_content = read_hosts(hosts_file)
  if hosts_file_content =~ /#google_host_start.*#google_host_end/m
    write_content = hosts_file_content.sub(/#google_host_start(.*)#google_host_end/m, '')
    write_hosts hosts_file, write_content
  end
  puts "delete success..."
end


