require 'open3'
require_relative 'config.rb'

module Sysutil

  class User
    
    def self.current_user
      `echo -n $USER`
    end
    
    def self.list

      list_users_command = 'cut -d: -f1 /etc/passwd'
      
      out, err, status = Open3.capture3(list_users_command)
      
        if status.success?
          # Split the output on the newline to make an array of users
          {success: true, output: out.split("\n")}
        else
          {success: false, message: "Error: #{err}"}
        end
        
    end

    def self.add!(name, opts={})

      add_user_command = conditional_sudo + "adduser #{name}"
      
      out, err, status = Open3.capture3(add_user_command)

      if status.success?
        {success: true, output: out}
      else
        {success: false, output: "Error: #{err}"}
      end
      
    end

    def self.set_password!(user, password, confirmation)

      # TODO: Change user password in such a way that we don't need chpasswd
      set_password_command = conditional_sudo + "echo \"#{user}:#{password}\" | /usr/sbin/chpasswd"
      puts set_password_command

      if password == confirmation
        out, err, status = Open3.capture3(set_password_command)

        if status.success?
          {succesS: true, output: out}
        else
          {success: false, output: "Error: #{err}"}
        end
      else
        {success: false, output: "Error: Passwords don't match"}
      end
      
    end

    def self.delete!(name, opts={})
      
      delete_user_command = conditional_sudo + "userdel #{name}"

      if opts[:force]
        delete_user_command += ' --force'
      end
      
      if opts[:with_home]
        delete_user_command += ' --remove'
      end

      out, err, status = Open3.capture3(delete_user_command)

      if status.success?
        {success: true, output: out}
      else
        {success: false, output: "Error: #{err}"}
      end
      
    end

    def self.add_to_group!(user, groupname, opts={})

      flags = opts[:primary] ? '-g' : '-a -G'
      
      add_to_group_command = cond_sudo + "usermod #{flags} #{groupname} #{user}"
      
      out, err, status = Open3.capture3(add_to_group_command)

      if status.success?
        {success: true, output: out}
      else
        {success: false, output: "Error: #{err}"}
      end
    end

    def self.list_groups(user)

      list_groups_command = "groups #{user}"
      
      out, err, status = Open3.capture3(list_groups_command)

      if status.success?
        groups = /(?<=\: )([a-z ]+)/.match(out).to_s.split(' ')
        {success: true, output: groups}
      else
        {success: true, message: "Error: #{err}"}
      end
      
    end
    
  end
  
end
