class UsersController < ApplicationController
    
    before_action :set_user, only: [:edit, :update, :show]
    before_action :require_same_user, only: [:edit, :update]
    
    def index
        @users = User.paginate(page: params[:page], per_page: 4)
    end
    
    def new
        @users = User.new
    end
    
    def create
        @users = User.new(user_params)
        if @users.save
            flash[:success] = "Bem-vindo ao Blog, #{@users.username}"
            redirect_to articles_path
        else
            render 'new'
        end
    end
    
    def edit
    end
    
    def update
        if @users.update(user_params)
            flash[:success] = "Sua conta foi atualizada com sucesso!"
            redirect_to articles_path
        else
            render 'edit'
        end
    end
    
    def show
        @users_articles = @users.articles.paginate(page: params[:page], per_page: 4)
    end
    
    private
    def user_params
        params.require(:user).permit(:username, :email, :password)
    end
    
    def set_user
        @users = User.find(params[:id]) 
    end
    
    def require_same_user
        if current_user != @user
            flash[:danger] = "Você só pode editar a sua conta."
            redirect_to root_path
        end
    end
end