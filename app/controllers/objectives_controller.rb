class ObjectivesController < ApplicationController

	def index
		@objective = Objective.all
	end
	def new
		@objective = Objective.new
	end

	def create
		@objective = Objective.new(params[:objective])
		if @objective.save
			redirect_to course_path(session[:course_id])
		else
			redirect_to(:action => 'new')
		end
	end

	def edit
		@objective = Objective.find(params[:id])
	end

	def update
		@objective = Objective.find(params[:id])
		if @objective.update_attributes(params[:objective])
			redirect_to course_path(session[:course_id])
		else
			redirect_to(:action => 'edit')
		end
	end

	def destroy
		flash[:notice] = "Delete Successfully."
		
		@objective = Objective.find(params[:id])
		@objective.destroy

		redirect_to course_path(session[:course_id])
	end

	def show
		# session[:course_id] = params[:id]
		@course = Course.find(params[:id])
	end

end
