class CommentsController < ApplicationController
	def index
		@allComments = Product.joins(:comments).select("products.id, products.name, comments.comment")
	end

	def create
  		@comments = Comment.create(comments_params)
  		# fail
  		# puts params["comment"]["product_id"]
  		# redirect_to request.referer

		if @comments.valid?	
			flash[:success] = "The comment has been successfully added"		
			# redirect_to "/product/#{params[:comment][:product_id]}"
		else
			flash[:errors] = @comments.errors.full_messages
			# redirect_to "/product/#{params[:comment][:product_id]}"
		end
  		
  		redirect_to "/product/#{params[:comment][:product_id]}"
  	end

  	private
	def comments_params
		params.require(:comment).permit(:comment, :product_id)
	end
end
