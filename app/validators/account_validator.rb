class AccountValidator < ActiveModel::Validator
  def validate(record)
    if User.find_by(email: record.email)
      record.errors.add(:email, "is already associated with an account")
    end
  end
end
