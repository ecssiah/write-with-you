class AccountValidator < ActiveModel::Validator
  def validate(user)
    if User.find_by(email: user.email)
      user.errors.add(:email, "is already associated with an account")
    end
  end
end
