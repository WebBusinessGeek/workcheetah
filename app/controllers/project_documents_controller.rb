class ProjectDocumentsController < ApplicationController
	def create
		@project_document = ProjectDocument.new(params[:project_document])
	  
		if @project_document.save
		  redirect_to project_path(Project.find_by_id(params[:project_document][:project_id])), notice: "Document Uploaded"
		else
		  @project = Project.find_by_id(params[:project_id])
		  render :new
		end
	end
	
	def new
		@project = Project.find_by_id(params[:project_id])
		@project_document = @project.project_documents.new
	end
end
