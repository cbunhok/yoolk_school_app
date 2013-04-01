class CoursesController < ApplicationController

	def index
		@category = Category.all
	end

	def show
		@course = Course.find(params[:id])
		# session[:course_name] = @course.title
	end

	# def showObjective
	# 	session[:course_id] = params[:id]
	# 	@course = Course.find(params[:id])
	# end

	def new
		@course = Course.new
	end

	def create

		@course = Course.new(params[:course])
		if @course.save
			flash[:notice] = "Create Successfully."
			redirect_to category_path(session[:category_id])
		else
			redirect_to(:action => 'new')
		end

	end

	def edit
		@course = Course.find(params[:id])
	end

	def update

		@course = Course.find(params[:id])

		if @course.update_attributes(params[:course])
			flash[:notice] = "Update Successfully."
			redirect_to category_path(session[:category_id])
		else
			render('edit')
		end

	end

	def destroy
		@course = Course.find(params[:id])

		@course.destroy
		redirect_to category_path(session[:category_id])
	end

end
