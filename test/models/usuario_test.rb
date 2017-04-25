require 'test_helper'

class UsuarioTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "debe crear usuario" do
  	u = Usuario.new(username: "jona", email: "jonacede@gmail.com", password: "123456")
  	assert u.save
  	
  end

  test "debe crear un usuario sin que exista gmail" do
  	u = Usuario.new(username: "cede", password: "12345678")
  	assert u.save
  end


end
