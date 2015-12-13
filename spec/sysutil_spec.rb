require 'active_support/core_ext/kernel/reporting'
require 'spec_helper'

describe Sysutil do

  Config.configure(root_password: 'ROOT PASSWORD HERE')
  
  it 'has a version number' do
    expect(Sysutil::VERSION).not_to be nil
  end

  describe Sysutil::User do

    user = Sysutil::User

    describe '.current_user' do
      it 'returns the current system user' do
        expect(user.current_user).to eq(`echo -n $USER`)
      end
    end
    
    describe '.list' do
      it 'provides a list of users as array' do
        expect(user.list).to be_an(Array)
      end
    end

    describe '.add!' do
      it 'adds a user' do
        u = user.add!('testuser', 'testpassword')
        expect(u).to eq(true)
      end
    end

    describe '.delete!' do
      it 'deletes a user' do
        u = user.delete!('testuser')
        expect(u).to eq(true)
      end
    end
    
  end
end
