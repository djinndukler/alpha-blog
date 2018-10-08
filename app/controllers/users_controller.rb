class UsersController < ApplicationController
    
    def index
        @users = User.paginate(page: params[:page], per_page: 4)
    end
    
    def new
        @users = User.new
    end
    
    def create
        @users = User.new(user_params)
        if @users.save
            flash[:success] = "Bem-vindo ao Blog, #{@user.username}"
            redirect_to articles_path
        else
            render 'new'
        end
    end
    
    def edit
        @users = User.find(params[:id])
        
    end
    
    def update
        @users = User.find(params[:id])
        if @users.update(user_params)
            flash[:success] = "Sua conta foi atualizada com sucesso!"
            redirect_to articles_path
        else
            render 'edit'
        end
    end
    
    def show
        @users=User.find(params[:id])
        @users_articles = @users.articles.paginate(page: params[:page], per_page: 4)
    end
    
    private
    def user_params
        params.require(:user).permit(:username, :email, :password)
    end
end