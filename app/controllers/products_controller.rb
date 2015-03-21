class ProductsController < ApplicationController
	def index
		@products = Product.all.joins("LEFT JOIN categories ON categories.id = category_id").select("products.*,categories.name AS 'Category'")
	end
	def new
		# new product form
		@categories = Category.all
	end
	def show
		# index 
		@product = Product.joins("LEFT JOIN categories ON categories.id = category_id").select("products.*,categories.name AS 'Category'").find(params[:id])
		@comments = Comment.all.where(product_id: params[:id])

		# if @comments.valid?	
		# 	flash[:success] = "The comments has been successfully added"
		# 	redirect_to request.referer
		# else
		# 	flash[:errors] = @comments.errors.full_messages
		# 	redirect_to request.referer
		# end

		# Product.all.joins("LEFT JOIN comments ON comments.id = product_id").select("products.id, products.name, comments.comment")
		# Comment.all.where(product:38)
	end
	def destroy
		Product.find(params[:id]).destroy

		redirect_to '/products'
	end
	def create
		puts product_params
		@product = Product.create(product_params)

		if @product.valid?	
			flash[:success] = "The product has been successfully added"		
			redirect_to '/products/new'
		else
			flash[:errors] = @product.errors.full_messages
			redirect_to '/products/new'
		end
	end

	def edit
		# edit product
		@categories = Category.all
		@product = Product.find(params[:id])
	end

	def update
		@product = Product.find(params[:id])
		@product.update(product_params)
		if @product.valid?	
			flash[:success] = "The product has been successfully updated"		
			redirect_to '/products'
		else
			flash[:errors] = @product.errors.full_messages
			redirect_to request.referer
		end
	end

	private
	def product_params
		params.require(:product).permit(:name, :description, :pricing, :category_id)
	end
	# fail
end
