class FilesController < ApplicationController
  before_action :authenticate_user!

  def index
    @user_files = current_user.user_files
  end

  def create
    @user_file = current_user.user_files.new(user_file_params)
    if @user_file.save
      redirect_to files_path, notice: 'File uploaded successfully.'
    else
      render :index, alert: 'Error uploading file.'
    end
  end

  def destroy
    @user_file = current_user.user_files.find(params[:id])
    @user_file.destroy
    redirect_to files_path, notice: 'File deleted successfully.'
  end

  def share
    @user_file = current_user.user_files.find(params[:id])
    # Generate a public URL using the random token
    @user_file.update(public_url: SecureRandom.hex(10))
    
    # Assuming you have a route that can handle the public URL
    shared_url = file_url(@user_file.public_url)  # This generates the full URL for the file
    
    redirect_to files_path, notice: "File shared successfully. URL: #{shared_url}"
  end

  def public
    @user_file = UserFile.find_by(public_url: params[:id])

    if @user_file && @user_file.uploaded_file.attached?
      # Get the file content using download
      file_content = @user_file.uploaded_file.download
      send_data file_content, type: @user_file.uploaded_file.content_type, disposition: 'attachment', filename: @user_file.uploaded_file.filename.to_s
    else
      redirect_to files_path, alert: 'File not found or invalid share URL.'
    end
  end


  private

  def user_file_params
    params.require(:user_file).permit(:title, :description, :uploaded_file)
  end
end
