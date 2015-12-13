require 'open3'
require_relative 'config.rb'

module Sysutil

  class Package

    def self.install!(*packages)

      packages = packages.join(' ')

      install_command = case linux_variant[:family]
                        when 'Debian'
                          'apt-get install -y'
                        when 'Redhat'
                          'yum install -y'
                        when 'Solaris'
                          'pkg install'
                        end

      install_command = conditional_sudo + install_command
      out, err, status = Open3.capture3(install_command)

      if status.success?
        {success: true, output: out}
      else
        {success: false, output: "Error: #{err}"}
      end
      
    end

    def self.remove!(*packages)

      remove_command = case linux_variant[:family]
                           when 'Debian'
                             'apt-get remove -y'
                           when 'Redhat'
                             'yum remove -y'
                           when 'Solaris'
                             'pkg-delete'
                           end

      remove_command = conditional_sudo + remove_command
      out, err, status = Open3.capture3(remove_command)

      if status.success?
        {success: true, output: out}
      else
        {success: false, output: "Error: #{err}"}
      end
      
    end

    def self.autoremove!

      autoremove_command = case linux_variant[:family]
                           when 'Debian'
                             'apt-get autoremove -y'
                           when 'Redhat'
                             'yum autoremove'
                           when 'Solaris'
                             'pkg-delete -a'
                           end

      autoremove_command = conditional_sudo + autoremove_command
      out, err, status = Open3.capture3(autoremove_command)

      if status.success?
        {success: true, message: out}
      else
        {success: true, output: "Error: #{err}"}
      end
      
    end

  end
  
end
