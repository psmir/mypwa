# frozen_string_literal: true

class MainController < ApplicationController

  def operation
    outcome = @operation.run!(operation_params, actor: current_user)
    after_operation_hook outcome

    if outcome.success?
      render json: { success: true, payload: outcome.result }
    else
      render json: { success: false, errors: outcome.errors.message }
    end
  end

  private

  def after_user_sign_in(outcome)
    return unless outcome.success?

    store_in_session(:user_id, outcome.result[:id])
  end

  def after_user_sign_up(outcome)
    return unless outcome.success?

    store_in_session(:user_id, outcome.result[:id])
  end

  def after_user_sign_out(outcome)
    return unless outcome.success?

    remove_from_session(:user_id)
  end
end
