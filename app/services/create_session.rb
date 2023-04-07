class CreateSession
    def initialize(email, password)
      @email = email
      @password = password
    end
  
    def call
      generate_session if password_valid?
    end
  
    private
  
    def password_valid?
      user&.authenticate(@password)
    end
  
    def user
      @user ||= User.find_by(email: @email)
    end
  
    def generate_session
      Session.new(user)
    end
end
