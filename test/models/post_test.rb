require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  

   test "debe encontrar un post por id" do
   	post_id = posts(:primer_articulo).id
   	post = Post.find(post_id)
   	assert_equal post, posts(:primer_articulo), "No encontr el registo" 
   end

   test "debe borrar un post" do
   		post = posts(:primer_articulo)
   		post.destroy
   		assert_raise(ActiveRecord::RecordNotFound) {Post.find(post.id)}
   end

   test "no debe crear un post" do

   		post = Post.new
   		assert post.invalid?, "el posr deberia ser invalido"

   end

   test "cada post tiene que ser unico" do
   		post = Post.new
   		post.titulo = posts(:primer_articulo).titulo
   		assert post.invalid? "dos pos no pueden tener el mismo titulo"
   end

end
