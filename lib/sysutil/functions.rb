def conditional_sudo
  if `echo -n $USER` != "root"
    "echo #{Config.config[:root_password]} | sudo -S "
  else
    ""
  end
end

def linux_variant
  r = { :distro => nil, :family => nil }

  if File.exists?('/etc/lsb-release')
    File.open('/etc/lsb-release', 'r').read.each_line do |line|
      r = { :distro => $1 } if line =~ /^DISTRIB_ID=(.*)/
    end
  end

  if File.exists?('/etc/debian_version')
    r[:distro] = 'Debian' if r[:distro].nil?
    r[:family] = 'Debian' if r[:variant].nil?
  elsif File.exists?('/etc/redhat-release') or File.exists?('/etc/centos-release')
    r[:family] = 'RedHat' if r[:family].nil?
    r[:distro] = 'CentOS' if File.exists?('/etc/centos-release')
  elsif File.exists?('/etc/SuSE-release')
    r[:distro] = 'SLES' if r[:distro].nil?
  end

  return r
end
