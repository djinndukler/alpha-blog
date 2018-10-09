class SessionsController < ApplicationController
    def new
        
    end
    
    def create
        user = User.find_by(email: params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password])
            session[:user_id] = user.id
            flash[:success] = "Logado com sucesso!"
            redirect_to user_path(user)
        else
            flash.now[:danger] = "Houve um erro com suas credenciais. E-mail ou senha errado(s)."
            render 'new'
        end
    end
    
    def destroy
        session[:user_id] = nil
        flash[:success] = "Log out feito com sucesso"
        redirect_to root_path
    end
    
    
end