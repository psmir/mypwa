class ApplicationController < ActionController::API
  include ActionController::Cookies
  include ActionController::RequestForgeryProtection

  class OperationNotFountError < StandardError; end

  before_action :find_operation, only: :operation

  rescue_from 'OperationNotFountError' do
    render json: { error: 'Operation not found' }, status: 404
  end

  private

  def current_user
    user_id = read_from_session(:user_id)
    return unless user_id.present?

    @current_user ||= User.find_by(id: user_id)
  end

  def store_in_session(key, value)
    cookies.signed[key] = {
      value: value,
      httponly: true
    }
  end

  def read_from_session(key)
    cookies.signed[key]
  end

  def remove_from_session(key)
    cookies.signed[key] = nil
  end

  def operation_params
    params[:payload] || {}
  end

  def find_operation
    raise OperationNotFountError unless BaseOperation.descendant?(params[:name])

    @operation = params[:name].constantize
  end

  # we need to run a controller hook for some actions
  #
  def after_operation_hook(outcome)
    hook_name = "after_#{@operation.to_s.underscore.gsub('/', '_')}"
    send(hook_name, outcome) if respond_to?(hook_name, true)
  end
end
