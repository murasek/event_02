class Users::RegistrationsController < Devise::RegistrationsController
  def build_resource(hash=nil)
    hash[:uid] = User.create_unique_string
    super
  end
  def new
    build_resource
      yield resource if block_given?
      respond_with resource
  end
end
