class User < ActiveRecord::Base

  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: {minimum: 4}
  validates :password_confirmation, presence: true

  def self.authenticate_with_credentials(email, password)

    email = email.strip.downcase
    @user = User.find_by_email(email)

    if @user && @user.authenticate(password)

      @user
    else

      nil
    end

  end
  
end
